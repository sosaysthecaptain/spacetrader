//
//  GalacticChartView.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class GalacticChartView: UIView {
    weak var delegate: ShortRangeChartDelegate?
    
    var planetsOnMap: [mapPlanet] = []
    var wormholeAsOpposedToPlanet = false
    
    let pointsPerParsec: CGFloat = 2
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
        
        
        // populate planets
        planetsOnMap = []                       // IMPORTANT: CLEAR PLANETSONMAP AS PART OF REFRESH
        for planet in galaxy.planets {
            drawPlanet(planet)
        }

        
        // draw crosshairs on target system, range circle on current planet
        for mapPlanet in planetsOnMap {
            if mapPlanet.system.name == galaxy.targetSystem!.name {
                drawTargetCrosshairs(mapPlanet)
                print("drawing crosshairs on \(mapPlanet.system.name)")
                if mapPlanet.throughWormhole {
                    print("target system is through a wormhole")
                    // get other end of wormhole
                    for potentialDestination in planetsOnMap {
                        if (potentialDestination.system.name == mapPlanet.system.name) && (potentialDestination.throughWormhole == false) {
                            let otherEnd = potentialDestination
                            drawWormholeArrow(mapPlanet, endWormhole: otherEnd)
                        }
                    }
                }
            }
            
            // draw crosshairs on tracked system
            if galaxy.trackedSystem != nil {
                
                for mapPanet in planetsOnMap {
                    if mapPlanet.system.name == galaxy.trackedSystem!.name {
                        drawTrackedCrosshairs(mapPlanet)
                        //drawTrackedArrow(mapPlanet)
                    }
                }
            }
            
            // range circle
            if mapPlanet.system.name == galaxy.currentSystem!.name {
                drawRangeCircle(mapPlanet.mapLocation)
            }

        }
        
        
        // maybe draw red arrow for wormhole?
    }
    
    func drawRangeCircle(mapLocation: CGPoint) {
        let rangeCirclePath = UIBezierPath(arcCenter: mapLocation, radius: rangeCircleRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        rangeCirclePath.lineWidth = 1
        UIColor.blackColor().setStroke()
        rangeCirclePath.stroke()
    }
    
    func drawWormholeArrow(startWormhole: mapPlanet, endWormhole: mapPlanet) {
        let startX: CGFloat = startWormhole.mapLocation.x
        let startY: CGFloat = startWormhole.mapLocation.y
        let endX: CGFloat = endWormhole.mapLocation.x
        let endY: CGFloat = endWormhole.mapLocation.y
        
        let redArrow = UIBezierPath()
        redArrow.moveToPoint(CGPoint(x: startX, y: startY))
        redArrow.addLineToPoint(CGPoint(x: endX, y: endY))
        redArrow.lineWidth = 1.0
        UIColor.blackColor().setStroke()
        redArrow.stroke()
    }
    
    
    
    // draws planet, also draws wormhole if necessary.
    func drawPlanet(system: StarSystem) {
        
        let xCoord: CGFloat = CGFloat(system.xCoord + 6) * pointsPerParsec
        let yCoord: CGFloat = CGFloat(system.yCoord + 3) * pointsPerParsec
        
        let location = CGPointMake(xCoord, yCoord)
        let visited: Bool = system.visited
        
        
        drawPlanetCircle(location, visited: visited)
        
        // add to planetsOnMap
        let mapEntry = mapPlanet(system: system, mapLocation: location)
        planetsOnMap.append(mapEntry)
        
        // if planet has a wormhole, draw one of those, and add it to the map
        if system.wormhole {
            let wormholeX = location.x + 7
            let wormholeY = location.y
            let wormholeLocation = CGPoint(x: wormholeX, y: wormholeY)
            drawWormholeCircle(wormholeLocation)
            
            let wormholeMapEntry = mapPlanet(system: system.wormholeDestination!, mapLocation: wormholeLocation)
            wormholeMapEntry.throughWormhole = true
            planetsOnMap.append(wormholeMapEntry)
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
        let planetRadius = CGFloat(2)
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
        let planetRadius = CGFloat(2)
        let wormholeDrawLocationX = location.x
        let wormholeDrawLocationY = location.y
        let wormholeDrawLocation = CGPoint(x: wormholeDrawLocationX, y: wormholeDrawLocationY)
        let wormholeCircle = UIBezierPath(arcCenter: wormholeDrawLocation, radius: planetRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        UIColor.redColor().setStroke()
        UIColor.whiteColor().setFill()
        wormholeCircle.stroke()
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
        upperTick.addLineToPoint(CGPoint(x: planetZeroX, y: planetZeroY - 10))
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
    
    func drawTrackedArrow(trackedSystem: mapPlanet) {
        // this is actually only needed in the short range chart
        var currentSystem: mapPlanet?
        for planet in planetsOnMap {
            if planet.system.name == galaxy.currentSystem!.name {
                currentSystem = planet
            }
        }
        
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
    
    func redrawSelf() {
        self.setNeedsDisplay()
    }

}
