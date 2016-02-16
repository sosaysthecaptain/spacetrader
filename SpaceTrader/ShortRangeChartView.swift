//
//  ShortRangeChartView.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/5/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

protocol ShortRangeChartDelegate: class {
    func targetSystemDidChange()
}

class ShortRangeChartView: UIView {
    
    weak var delegate: ShortRangeChartDelegate?
    
    var planetsOnMap: [mapPlanet] = []
    var wormholeAsOpposedToPlanet = false
    
    let pointsPerParsec: CGFloat = 6
    let circleColor = UIColor.blackColor()
    
    var locationOfCurrentPlanet: CGPoint {
        get {
            return convertPoint(center, fromCoordinateSpace: superview!)
        }
    }
    
    var rangeCircleRadius: CGFloat {
        return CGFloat(player.commanderShip.fuel) * pointsPerParsec
    }
    
    override func drawRect(rect: CGRect) {
        
        // draw range circle
        let rangeCirclePath = UIBezierPath(arcCenter: locationOfCurrentPlanet, radius: rangeCircleRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        rangeCirclePath.lineWidth = 1
        circleColor.set()
        rangeCirclePath.stroke()
        
        // populate planets
        planetsOnMap = []                       // IMPORTANT: CLEAR PLANETSONMAP AS PART OF REFRESH
        for planet in galaxy.planets {
            drawPlanet(planet)
        }
        
        // draw crosshairs on target system
        for mapPlanet in planetsOnMap {
            if mapPlanet.system.name == galaxy.targetSystem!.name {
                drawTargetCrosshairs(mapPlanet)
            }
        }
        
        // if planet is tracked, drawTrackedArrow
        for mapPlanet in planetsOnMap {
            if galaxy.trackedSystem != nil {
                if mapPlanet.system.name == galaxy.trackedSystem!.name {
                    //drawTrackedArrow(mapPlanet)
                    drawTrackedArrow2(mapPlanet.system)
                    drawTrackedCrosshairs(mapPlanet)
                }
            }
        }
        
    }
    
    
    
    // draws planet, also draws wormhole if necessary.
    func drawPlanet(system: StarSystem) {
        let currentSystemMapXCoord: CGFloat = locationOfCurrentPlanet.x
        let currentSystemMapYCoord: CGFloat = locationOfCurrentPlanet.y
        
        let xDifference: CGFloat = CGFloat(galaxy.currentSystem!.xCoord) - CGFloat(system.xCoord)
        let yDifference: CGFloat = CGFloat(galaxy.currentSystem!.yCoord) - CGFloat(system.yCoord)
        
        let xCoord: CGFloat = currentSystemMapXCoord - (xDifference * CGFloat(pointsPerParsec))
        let yCoord: CGFloat = currentSystemMapYCoord - (yDifference * CGFloat(pointsPerParsec))

        let location = CGPointMake(xCoord, yCoord)
        let visited: Bool = system.visited
        
        var add = false
        // draw only if on the map and not on the edge
        if isItOnTheMap(xCoord, yCoord: yCoord) {
            add = true
        } else {        // KLUDGE FIX--hopefully eliminate need for this?
            for systemInRange in galaxy.systemsInRange {
                if system.name == systemInRange.name {
                    add = true
                }
            }
        }
        
        if add {
            drawPlanetCircle(location, visited: visited)
            
            // add name
            let nameLocationX: CGFloat = xCoord - 15
            let nameLocationY: CGFloat = yCoord - 20
            let nameLocation = CGPointMake(nameLocationX, nameLocationY)
            let text = NSAttributedString(string: system.name)
            text.drawAtPoint(nameLocation)
            
            // add to planetsOnMap
            let mapEntry = mapPlanet(system: system, mapLocation: location)
            planetsOnMap.append(mapEntry)
            
            // if planet has a wormhole, draw one of those, and add it to the map
            if system.wormhole {
                let wormholeX = location.x + 10
                let wormholeY = location.y
                let wormholeLocation = CGPoint(x: wormholeX, y: wormholeY)
                drawWormholeCircle(wormholeLocation)
                
                let wormholeMapEntry = mapPlanet(system: system.wormholeDestination!, mapLocation: wormholeLocation)
                wormholeMapEntry.throughWormhole == true
                planetsOnMap.append(wormholeMapEntry)
            }
            
            
        }
        
        
    }
    
    // outcome of this function should be a new targetSystem and a call to redraw
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInView(self)
        
        // identify planet in mapPlanet that was touched
        var minDistance: CGFloat = 100
        var closestPlanet: mapPlanet?
        
        for mapPlanet in planetsOnMap {
            let distance = distanceFromTouchToPlanet(touchLocation, planet: mapPlanet)
            if distance < 20 {
                if distance < minDistance {
                    minDistance = distance
                    closestPlanet = mapPlanet
                }
                galaxy.targetSystem = closestPlanet!.system
                delegate?.targetSystemDidChange()
                self.setNeedsDisplay()
            }
        }
        
    }
    
    func drawPlanetCircle(location: CGPoint, visited: Bool) {
        let planetRadius = CGFloat(4)
        let planetCircle = UIBezierPath(arcCenter: location, radius: planetRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        let unvisitedColor: UIColor = UIColor.greenColor()
        let visitedColor: UIColor = UIColor.blueColor()
        
        if visited == true {
            visitedColor.set()
        } else {
            unvisitedColor.set()
        }
        
        planetCircle.stroke()
        planetCircle.fill()
    }
    
    func drawWormholeCircle(location: CGPoint) {
        let planetRadius = CGFloat(4)
        let wormholeDrawLocationX = location.x
        let wormholeDrawLocationY = location.y
        let wormholeDrawLocation = CGPoint(x: wormholeDrawLocationX, y: wormholeDrawLocationY)
        let wormholeCircle = UIBezierPath(arcCenter: wormholeDrawLocation, radius: planetRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        UIColor.redColor().setStroke()
        UIColor.whiteColor().setFill()
        wormholeCircle.stroke()
    }
    
    func isItOnTheMap(xCoord: CGFloat, yCoord: CGFloat) -> Bool {
     
        var xOk = false
        var yOk = false
        
        if xCoord > 5 && xCoord < (self.frame.width - 5) {
            xOk = true
        }
        if yCoord > 5 && yCoord < (self.frame.height - 5) {
            yOk = true
        }
        
        if xOk && yOk {
            return true
        }
        return false
    }
    
    func distanceFromTouchToPlanet(touchLocation: CGPoint, planet: mapPlanet) -> CGFloat {
        let xDistance = abs(touchLocation.x - planet.mapLocation.x)
        let yDistance = abs(touchLocation.y - planet.mapLocation.y)
        let distance = sqrt((xDistance * xDistance) + (yDistance * yDistance))
        return distance
    }
    
    func distanceFromTouchToPoint(touchLocation: CGPoint, point: CGPoint) -> CGFloat {
        let xDistance = abs(touchLocation.x - point.x)
        let yDistance = abs(touchLocation.y - point.y)
        let distance = sqrt((xDistance * xDistance) + (yDistance * yDistance))
        return distance
    }
    
    func drawTargetCrosshairs(planetOnMap: mapPlanet) {
        let planetZeroX = planetOnMap.mapLocation.x
        let planetZeroY = planetOnMap.mapLocation.y
        
        let upperTick = UIBezierPath()
        upperTick.moveToPoint(CGPoint(x: planetZeroX, y: planetZeroY - 5))
        upperTick.addLineToPoint(CGPoint(x: planetZeroX, y: planetZeroY - 8))
        upperTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        upperTick.stroke()
        
        let lowerTick = UIBezierPath()
        lowerTick.moveToPoint(CGPoint(x: planetZeroX, y: planetZeroY + 5))
        lowerTick.addLineToPoint(CGPoint(x: planetZeroX, y: planetZeroY + 10))
        lowerTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        lowerTick.stroke()
        
        let rightTick = UIBezierPath()
        rightTick.moveToPoint(CGPoint(x: planetZeroX + 5, y: planetZeroY))
        rightTick.addLineToPoint(CGPoint(x: planetZeroX + 10, y: planetZeroY))
        rightTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        rightTick.stroke()
        
        let leftTick = UIBezierPath()
        leftTick.moveToPoint(CGPoint(x: planetZeroX - 5, y: planetZeroY))
        leftTick.addLineToPoint(CGPoint(x: planetZeroX - 10, y: planetZeroY))
        leftTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        leftTick.stroke()
    }
    
    func drawTrackedArrow(trackedSystem: mapPlanet) {
        
        // this is actually only needed in the short range chart
        var currentSystem: mapPlanet?
        for planet in planetsOnMap {
            if planet.system.name == galaxy.currentSystem!.name {
                currentSystem = planet
            }
        }
        
        print("current system map coords: \(currentSystem!.mapLocation.x), \(currentSystem!.mapLocation.y)")
        
        if galaxy.trackedSystem != nil {
            let startX: CGFloat = currentSystem!.mapLocation.x
            let startY: CGFloat = currentSystem!.mapLocation.y
            let endX: CGFloat = trackedSystem.mapLocation.x
            let endY: CGFloat = trackedSystem.mapLocation.y
            
            let deltaX = endX - startX
            let deltaY = endY - startY
            
            let partialDeltaX = deltaX / 5
            let partialDeltaY = deltaY / 5
            
            let newX = startX + partialDeltaX
            let newY = startY + partialDeltaY
            
            let targetX: CGFloat = newX
            let targetY: CGFloat = newY
            
            let redArrow = UIBezierPath()
            redArrow.moveToPoint(CGPoint(x: startX, y: startY))
            redArrow.addLineToPoint(CGPoint(x: targetX, y: targetY))
            redArrow.lineWidth = 1.0
            UIColor.redColor().setStroke()
            redArrow.stroke()
        }
    }
    
    func drawTrackedArrow2(trackedSystem: StarSystem) {
        // we know that current system is at (hard coded, but still)
        let mapCenterX: CGFloat = 175
        let mapCenterY: CGFloat = 100
        
        // with that in mind, we need to get angle from real coords
        let startRealX = CGFloat(galaxy.currentSystem!.xCoord)
        let startRealY = CGFloat(galaxy.currentSystem!.yCoord)
        let endRealX = CGFloat(galaxy.trackedSystem!.xCoord)
        let endRealY = CGFloat(galaxy.trackedSystem!.yCoord)
        
        // goal is coordinates of a point a fixed distance away from map center, in the direction of endReal from endStart
        let opposite = startRealY - endRealY
        let adjacent = startRealX - endRealX
        let angle = atan(opposite / adjacent)
        print(angle)
    }
    
    func drawTrackedCrosshairs(planetOnMap: mapPlanet) {
        let planetZeroX = planetOnMap.mapLocation.x
        let planetZeroY = planetOnMap.mapLocation.y
        
        let upperLTick = UIBezierPath()
        upperLTick.moveToPoint(CGPoint(x: planetZeroX - 4, y: planetZeroY - 4))
        upperLTick.addLineToPoint(CGPoint(x: planetZeroX - 7, y: planetZeroY - 7))
        upperLTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        upperLTick.stroke()
        
        let lowerLTick = UIBezierPath()
        lowerLTick.moveToPoint(CGPoint(x: planetZeroX - 4, y: planetZeroY + 4))
        lowerLTick.addLineToPoint(CGPoint(x: planetZeroX - 7, y: planetZeroY + 7))
        lowerLTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        lowerLTick.stroke()
        
        let lowerRTick = UIBezierPath()
        lowerRTick.moveToPoint(CGPoint(x: planetZeroX + 4, y: planetZeroY + 4))
        lowerRTick.addLineToPoint(CGPoint(x: planetZeroX + 7, y: planetZeroY + 7))
        lowerRTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        lowerRTick.stroke()
        
        let upperRTick = UIBezierPath()
        upperRTick.moveToPoint(CGPoint(x: planetZeroX + 4, y: planetZeroY - 4))
        upperRTick.addLineToPoint(CGPoint(x: planetZeroX + 7, y: planetZeroY - 7))
        upperRTick.lineWidth = 2.0
        UIColor.blackColor().setStroke()
        upperRTick.stroke()
    }
    
    func redrawSelf() {
        self.setNeedsDisplay()
    }
}

class mapPlanet {
    let system: StarSystem
    let mapLocation: CGPoint
    var throughWormhole: Bool = false
    
    init(system: StarSystem, mapLocation: CGPoint) {
        self.system = system
        self.mapLocation = mapLocation
    }
}
