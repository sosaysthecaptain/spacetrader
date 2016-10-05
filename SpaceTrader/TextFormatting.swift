//
//  TextFormatting.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/11/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

// this is essentially a CSS stylesheet. These subclasses of labels can be applied to everything, and modified in only one place

// TODO:
// H2 (large purple)
// StandardLabel (gray, standard size, used for almost everything)          DONE
// StandardLabelPurple (same as above but purple)                           DONE
// SmallLabelGray (gray, smaller, used for things like "Resources:")        DONE
// MakeFitGray? / MakeFitPurple? (used for long prices/P-L statements?)
// SmallNotBold (for target system descriptor line on buy)


// experimental label class
class StandardLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = textGray
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
    }
}

class StandardLabelPurple: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = mainPurple
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
    }
}

class LightGrayLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = inactiveGray
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
    }
}

class PurpleHeader: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = mainPurple
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        
    }
}

class SmallLabelPurple: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = mainPurple
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        
    }
}

class SmallLabelGray: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = textGray
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        
    }
}

class SmallLabelGrayRJ: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = textGray
        self.textAlignment = NSTextAlignment.right
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        
    }
}

class SmallNotBold: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        self.textColor = textGray
        self.font = UIFont(name: "AvenirNext-Medium", size: 13)       // still bold, maybe change
        
    }
}


