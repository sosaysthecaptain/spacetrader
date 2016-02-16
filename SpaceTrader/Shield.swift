//
//  Shield.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

class Shield: NSObject, NSCoding {
    let type: ShieldType
    let name: String
    let power: Int
    var currentStrength: Int = 0    // do we want to initialize them at zero? I think so?
    let price: Int
    let sellPrice: Int
    let techLevel: TechLevelType
    let chance: Int                 // percent chance that this is fitted in a slot
    let image: UIImage
    
    var percentStrength: Int {
        get {
            return Int((Double(currentStrength) / Double(power)) * 100)
        }
        set(newPercentage) {
            currentStrength = newPercentage * (currentStrength / 100)
        }
    }
    
    init(type: ShieldType) {
        self.type = type
        
        switch type {
        case ShieldType.energyShield:
            self.name = "Energy shield"
            self.power = 100
            self.price = 4950
            self.sellPrice = 3750
            self.techLevel = TechLevelType.techLevel5
            self.chance = 70
            self.image = UIImage(named: "energy")!
        case ShieldType.reflectiveShield:
            self.name = "Reflective shield"
            self.power = 200
            self.price = 19800
            self.sellPrice = 15000
            self.techLevel = TechLevelType.techLevel6
            self.chance = 30
            self.image = UIImage(named: "reflective")!
        case ShieldType.lightningShield:
            self.name = "Lightning shield"
            self.power = 350
            self.price = 45000
            self.sellPrice = 0              // *****
            self.techLevel = TechLevelType.techLevel8
            self.chance = 0
            self.image = UIImage(named: "lightning")!
        }
    }
    
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.type = ShieldType(rawValue: decoder.decodeObjectForKey("type") as! Int!)!
            self.name = decoder.decodeObjectForKey("name") as! String
            self.power = decoder.decodeObjectForKey("power") as! Int
            self.currentStrength = decoder.decodeObjectForKey("currentStrength") as! Int
            self.price = decoder.decodeObjectForKey("price") as! Int
            self.sellPrice = decoder.decodeObjectForKey("sellPrice") as! Int
            self.techLevel = TechLevelType(rawValue: decoder.decodeObjectForKey("techLevel") as! String!)!
            self.chance = decoder.decodeObjectForKey("chance") as! Int
            self.image = decoder.decodeObjectForKey("image") as! UIImage
    
            super.init()
        }
    
        func encodeWithCoder(encoder: NSCoder) {
            encoder.encodeObject(type.rawValue, forKey: "type")
            encoder.encodeObject(name, forKey: "name")
            encoder.encodeObject(power, forKey: "power")
            encoder.encodeObject(currentStrength, forKey: "currentStrength")
            encoder.encodeObject(price, forKey: "price")
            encoder.encodeObject(sellPrice, forKey: "sellPrice")
            encoder.encodeObject(techLevel.rawValue, forKey: "techLevel")
            encoder.encodeObject(chance, forKey: "chance")
            encoder.encodeObject(image, forKey: "image")
        }

}