//
//  Gadget.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

class Gadget: NSObject, NSCoding {
    let type: GadgetType
    let name: String
    let price: Int
    let sellPrice: Int
    let techLevel: TechLevelType
    let chance: Int
    let image: UIImage

    init(type: GadgetType) {
        self.type = type
        
        switch type {
        case GadgetType.cargoBays:
            self.name = "5 extra cargo bays"
            self.price = 2475
            self.sellPrice = 1875
            self.techLevel = TechLevelType.techLevel4
            self.chance = 35
            self.image = UIImage(named: "bays")!
        case GadgetType.hBays:
            self.name = "Hidden cargo bays"
            self.price = 0
            self.sellPrice = 0
            self.techLevel = TechLevelType.techLevel8
            self.chance = 0
            self.image = UIImage(named: "hbays")!
        case GadgetType.autoRepair:
            self.name = "Auto-repair system"
            self.price = 7450
            self.sellPrice = 5625
            self.techLevel = TechLevelType.techLevel5
            self.chance = 20
            self.image = UIImage(named: "repsys")!
        case GadgetType.navigation:
            self.name = "Navigating system"
            self.price = 14850
            self.sellPrice = 11250
            self.techLevel = TechLevelType.techLevel6
            self.chance = 20
            self.image = UIImage(named: "navsys")!
        case GadgetType.targeting:
            self.name = "Targeting system"
            self.price = 24750
            self.sellPrice = 18750
            self.techLevel = TechLevelType.techLevel6
            self.chance = 20
            self.image = UIImage(named: "targsys")!
        case GadgetType.cloaking:
            self.name = "Cloaking device"
            self.price = 99000
            self.sellPrice = 75000
            self.techLevel = TechLevelType.techLevel7
            self.chance = 5
            self.image = UIImage(named: "cloak")!
        case GadgetType.fuelCompactor:
            self.name = "Fuel compactor"
            self.price = 30000
            self.sellPrice = 0                              // ****
            self.techLevel = TechLevelType.techLevel8
            self.chance = 0
            self.image = UIImage(named: "fuel")!
        }
    }
   
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.type = GadgetType(rawValue: decoder.decodeInteger(forKey: "type"))!
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.price = decoder.decodeInteger(forKey: "price")
            self.sellPrice = decoder.decodeInteger(forKey: "sellPrice")
            self.techLevel = TechLevelType(rawValue: decoder.decodeObject(forKey: "techLevel") as! String!)!
            self.chance = decoder.decodeInteger(forKey: "chance")
            self.image = decoder.decodeObject(forKey: "image") as! UIImage
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(type.rawValue, forKey: "type")
            encoder.encode(name, forKey: "name")
            encoder.encode(price, forKey: "price")
            encoder.encode(sellPrice, forKey: "sellPrice")
            encoder.encode(techLevel.rawValue, forKey: "techLevel")
            encoder.encode(chance, forKey: "chance")
            encoder.encode(image, forKey: "image")
        }
}
