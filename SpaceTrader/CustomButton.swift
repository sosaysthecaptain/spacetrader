//
//  CustomButton.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/4/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class CustomButton: UIButton {
    // use inset 10 for top and bottom, 20 for left and right as a default

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
        
        //self.frame = CGRectMake(100, 100, 200, 40)
        
        
        
        // downstate
        //self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        // gray out option?
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        

        
    }
    
    // use this instead of extension
    override var highlighted: Bool {
        didSet {
            
            if (highlighted) {
                self.backgroundColor = UIColor.grayColor()
                //self.tintColor = UIColor.whiteColor()
            }
            else {
                self.backgroundColor = UIColor.whiteColor()
                //self.tintColor = UIColor.blackColor()
            }
            
        }
    }
    
    override var enabled: Bool {
        didSet {
            if (enabled) {
                self.layer.borderColor = UIColor.blackColor().CGColor
            } else {
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        //self.isInterfaceBuilder = true
    }

    
    // maybe make a "grayed out" state in which the button is invisible?

}
