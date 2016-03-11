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

class SpaceTraderButton: UIButton {
    // this is the parent class. Sets font, size, margins, defaults
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // font
        self.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        
        // border
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1
        
        // colors
        self.layer.borderColor = mainPurple.CGColor                         // set border color
        self.setTitleColor(mainPurple, forState: UIControlState.Normal)     // set normal text color
        self.setTitleColor(inactiveGray, forState: UIControlState.Disabled)   // set disabled text color
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()                               // TODO: set
    }
    
    //    // DOWNSTATE
    //    override var highlighted: Bool {
    //        didSet {
    //            if (highlighted) {
    //                self.backgroundColor = UIColor.grayColor()
    //                //self.tintColor = UIColor.whiteColor()
    //            }
    //            else {
    //                self.backgroundColor = UIColor.whiteColor()
    //                //self.tintColor = UIColor.blackColor()
    //            }
    //        }
    //    }
}



class PurpleButtonTurnsGray: SpaceTraderButton {
    // this is the main purple button, on disable it turns gray (does not vanish)
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = mainPurple.CGColor                         // set border color
        self.setTitleColor(mainPurple, forState: UIControlState.Normal)     // set normal text color
        self.setTitleColor(inactiveGray, forState: UIControlState.Disabled)   // set disabled text color
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
    }
    
    // set enabled and disabled colors for border
    override var enabled: Bool {
        didSet {
            if (enabled) {
                self.layer.borderColor = mainPurple.CGColor
            } else {
                self.layer.borderColor = inactiveGray.CGColor
            }
        }
    }
}

// note: insets on all buttons should be 15 for sides and 8 for top and bottom

// TODO: set downstate
class PurpleButtonVanishes: SpaceTraderButton {
    // this is the purple button that vanishes when inactivated
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = mainPurple.CGColor                         // set border color
        self.setTitleColor(mainPurple, forState: UIControlState.Normal)     // set normal text color
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)   // set disabled text color
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
    }
    
    
    // set enabled and disabled colors for border
    override var enabled: Bool {
        didSet {
            if (enabled) {
                self.layer.borderColor = mainPurple.CGColor
            } else {
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
}

// TODO: set downstate
class GrayButtonTurnsLighter: SpaceTraderButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = textGray.CGColor                         // set border color
        self.setTitleColor(textGray, forState: UIControlState.Normal)     // set normal text color
        self.setTitleColor(inactiveGray, forState: UIControlState.Disabled)   // set disabled text color
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
    }
    
    // set enabled and disabled colors for border
    override var enabled: Bool {
        didSet {
            if (enabled) {
                self.layer.borderColor = textGray.CGColor
            } else {
                self.layer.borderColor = inactiveGray.CGColor
            }
        }
    }
}

class GrayButtonVanishes: SpaceTraderButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = textGray.CGColor                         // set border color
        self.setTitleColor(textGray, forState: UIControlState.Normal)     // set normal text color
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)   // set disabled text color
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
    }
    
    // set enabled and disabled colors for border
    override var enabled: Bool {
        didSet {
            if (enabled) {
                self.layer.borderColor = textGray.CGColor
            } else {
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
}

class BaysCashBox: SpaceTraderButton {
    // not actually a button, but writing it as one for lack of a better idea
    // insets: 8 and 25
    
    //**************************************************************************************************
    // USAGE: create and connect as button, constrained to margins
    // insets should be 25 and 8
    // set text like this:

    //let numberFormatter = NSNumberFormatter()
    //numberFormatter.numberStyle = .DecimalStyle
    //let cashFormatted = numberFormatter.stringFromNumber(player.credits)
    //let cashLabelText = "\(cashFormatted!) cr."
    
    //baysOutlet.setTitle("Bays: \(player.commanderShip.baysFilled)/\(player.commanderShip.totalBays)", forState: UIControlState.Disabled)
    //cashOutlet.setTitle(cashLabelText, forState: UIControlState.Disabled)
    //**************************************************************************************************
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 0;
        self.layer.borderColor = textGray.CGColor                       // set border color
        self.setTitleColor(textGray, forState: UIControlState.Disabled) // set normal text color
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.whiteColor()
        
        self.enabled = false                                            // these are just disabled buttons
        
    }
}

// can set color, that's about it
class PurpleStepper: UIStepper {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // set color
        self.tintColor = mainPurple
    }
}
