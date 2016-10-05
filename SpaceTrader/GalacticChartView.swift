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
    
    var pointsPerParsec: CGFloat = 2
    let circleColor = UIColor.black
    
    var locationOfCurrentPlanet: CGPoint {
        get {
            return convert(center, from: superview!)
        }
    }
    
    var rangeCircleRadius: CGFloat {
        return CGFloat(player.commanderShip.fuel) * pointsPerParsec
    }
    
    override func draw(_ rect: CGRect) {
        
        // figure out size of screen this is displaying on, adjust scale accordingly
        //print("view width: \(self.bounds.width)")
        if self.bounds.width < 300 {
            pointsPerParsec = 1.7
        }
        
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
    
    func drawRangeCircle(_ mapLocation: CGPoint) {
        let rangeCirclePath = UIBezierPath(arcCenter: mapLocation, radius: rangeCircleRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        rangeCirclePath.lineWidth = 1
        textGray.setStroke()
        rangeCirclePath.stroke()
    }
    
    func drawWormholeArrow(_ startWormhole: mapPlanet, endWormhole: mapPlanet) {
        let startX: CGFloat = startWormhole.mapLocation.x
        let startY: CGFloat = startWormhole.mapLocation.y
        let endX: CGFloat = endWormhole.mapLocation.x
        let endY: CGFloat = endWormhole.mapLocation.y
        
        let redArrow = UIBezierPath()
        redArrow.move(to: CGPoint(x: startX, y: startY))
        redArrow.addLine(to: CGPoint(x: endX, y: endY))
        redArrow.lineWidth = 1.0
        textGray.setStroke()
        redArrow.stroke()
    }
    
    
    
    // draws planet, also draws wormhole if necessary.
    func drawPlanet(_ system: StarSystem) {
        
        let xCoord: CGFloat = CGFloat(system.xCoord + 6) * pointsPerParsec
        let yCoord: CGFloat = CGFloat(system.yCoord + 3) * pointsPerParsec
        
        let location = CGPoint(x: xCoord, y: yCoord)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
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
    
    func drawPlanetCircle(_ location: CGPoint, visited: Bool) {
        let planetRadius = CGFloat(2)
        let planetCircle = UIBezierPath(arcCenter: location, radius: planetRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        let unvisitedColor: UIColor = mapGreen
        let visitedColor: UIColor = mapBlue
        
        if visited == true {
            visitedColor.set()
        } else {
            unvisitedColor.set()
        }
        
        planetCircle.stroke()
        planetCircle.fill()
    }
    
    func drawWormholeCircle(_ location: CGPoint) {
        let planetRadius = CGFloat(2)
        let wormholeDrawLocationX = location.x
        let wormholeDrawLocationY = location.y
        let wormholeDrawLocation = CGPoint(x: wormholeDrawLocationX, y: wormholeDrawLocationY)
        let wormholeCircle = UIBezierPath(arcCenter: wormholeDrawLocation, radius: planetRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        UIColor.red.setStroke()
        UIColor.white.setFill()
        wormholeCircle.stroke()
    }
    
    
    func distanceFromTouchToPlanet(_ touchLocation: CGPoint, planet: mapPlanet) -> CGFloat {
        let xDistance = abs(touchLocation.x - planet.mapLocation.x)
        let yDistance = abs(touchLocation.y - planet.mapLocation.y)
        let distance = sqrt((xDistance * xDistance) + (yDistance * yDistance))
        return distance
    }
    
    func distanceFromTouchToPoint(_ touchLocation: CGPoint, point: CGPoint) -> CGFloat {
        let xDistance = abs(touchLocation.x - point.x)
        let yDistance = abs(touchLocation.y - point.y)
        let distance = sqrt((xDistance * xDistance) + (yDistance * yDistance))
        return distance
    }
    
    func drawTargetCrosshairs(_ planetOnMap: mapPlanet) {
        let planetZeroX = planetOnMap.mapLocation.x
        let planetZeroY = planetOnMap.mapLocation.y
        
        let upperTick = UIBezierPath()
        upperTick.move(to: CGPoint(x: planetZeroX, y: planetZeroY - 5))
        upperTick.addLine(to: CGPoint(x: planetZeroX, y: planetZeroY - 10))
        upperTick.lineWidth = 2.0
        textGray.setStroke()
        upperTick.stroke()
        
        let lowerTick = UIBezierPath()
        lowerTick.move(to: CGPoint(x: planetZeroX, y: planetZeroY + 5))
        lowerTick.addLine(to: CGPoint(x: planetZeroX, y: planetZeroY + 10))
        lowerTick.lineWidth = 2.0
        textGray.setStroke()
        lowerTick.stroke()
        
        let rightTick = UIBezierPath()
        rightTick.move(to: CGPoint(x: planetZeroX + 5, y: planetZeroY))
        rightTick.addLine(to: CGPoint(x: planetZeroX + 10, y: planetZeroY))
        rightTick.lineWidth = 2.0
        textGray.setStroke()
        rightTick.stroke()
        
        let leftTick = UIBezierPath()
        leftTick.move(to: CGPoint(x: planetZeroX - 5, y: planetZeroY))
        leftTick.addLine(to: CGPoint(x: planetZeroX - 10, y: planetZeroY))
        leftTick.lineWidth = 2.0
        textGray.setStroke()
        leftTick.stroke()
    }
    
    func drawTrackedCrosshairs(_ planetOnMap: mapPlanet) {
        let planetZeroX = planetOnMap.mapLocation.x
        let planetZeroY = planetOnMap.mapLocation.y
        
        let upperLTick = UIBezierPath()
        upperLTick.move(to: CGPoint(x: planetZeroX - 4, y: planetZeroY - 4))
        upperLTick.addLine(to: CGPoint(x: planetZeroX - 7, y: planetZeroY - 7))
        upperLTick.lineWidth = 2.0
        textGray.setStroke()
        upperLTick.stroke()
        
        let lowerLTick = UIBezierPath()
        lowerLTick.move(to: CGPoint(x: planetZeroX - 4, y: planetZeroY + 4))
        lowerLTick.addLine(to: CGPoint(x: planetZeroX - 7, y: planetZeroY + 7))
        lowerLTick.lineWidth = 2.0
        textGray.setStroke()
        lowerLTick.stroke()
        
        let lowerRTick = UIBezierPath()
        lowerRTick.move(to: CGPoint(x: planetZeroX + 4, y: planetZeroY + 4))
        lowerRTick.addLine(to: CGPoint(x: planetZeroX + 7, y: planetZeroY + 7))
        lowerRTick.lineWidth = 2.0
        textGray.setStroke()
        lowerRTick.stroke()
        
        let upperRTick = UIBezierPath()
        upperRTick.move(to: CGPoint(x: planetZeroX + 4, y: planetZeroY - 4))
        upperRTick.addLine(to: CGPoint(x: planetZeroX + 7, y: planetZeroY - 7))
        upperRTick.lineWidth = 2.0
        textGray.setStroke()
        upperRTick.stroke()
    }
    
    func drawTrackedArrow(_ trackedSystem: mapPlanet) {
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
            redArrow.move(to: CGPoint(x: startX, y: startY))
            redArrow.addLine(to: CGPoint(x: targetX, y: targetY))
            redArrow.lineWidth = 1.0
            UIColor.red.setStroke()
            redArrow.stroke()
        }
    }
    
    func redrawSelf() {
        self.setNeedsDisplay()
    }

}
