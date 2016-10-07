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
            self.type = ShieldType(rawValue: decoder.decodeInteger(forKey: "type"))!
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.power = decoder.decodeInteger(forKey: "power")
            self.currentStrength = decoder.decodeInteger(forKey: "currentStrength")
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
            encoder.encode(power, forKey: "power")
            encoder.encode(currentStrength, forKey: "currentStrength")
            encoder.encode(price, forKey: "price")
            encoder.encode(sellPrice, forKey: "sellPrice")
            encoder.encode(techLevel.rawValue, forKey: "techLevel")
            encoder.encode(chance, forKey: "chance")
            encoder.encode(image, forKey: "image")
        }

}
