//
//  BaysCashBoxView.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/11/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class BaysCashBoxView: UIView {

    // view should be drawn to edges (not margins) and should be 40 high. This includes upper margin.
    
    override func drawRect(rect: CGRect) {
        // define constants
        let bottom = self.bounds.height + 10
        let top = 10
        let leftEdge = 10
        let rightEdge = self.bounds.width - 10
        
        print("BaysCashBox bounds: \(bottom), \(top), \(leftEdge), \(rightEdge)")
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
