//
//  RuleView.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/10/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class RuleView: UIView {
    
// USAGE: create view that goes fully side to side, and is high enough to include margins (35)
// create all constraints, set its class to this. Will draw rule.
    
    override func drawRect(rect: CGRect) {
        // calculate endpoints
        let offsetFromLeftEdge: CGFloat = 20
        let rightCoordinate = CGPoint(x: self.bounds.width, y: (self.bounds.height / 2))
        print("right coordinate: (\(rightCoordinate.x), \(rightCoordinate.y))")
        let leftCoordinate = CGPoint(x: offsetFromLeftEdge, y: self.bounds.height / 2)
        
        
        // draw line
        let ruleLine = UIBezierPath()
        ruleLine.moveToPoint(leftCoordinate)
        ruleLine.addLineToPoint(rightCoordinate)
        ruleLine.lineWidth = 0.5
        inactiveGray.setStroke()
        ruleLine.stroke()
    }
    
}
