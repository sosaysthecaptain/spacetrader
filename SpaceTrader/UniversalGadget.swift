//
//  UniversalGadget.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/1/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

class UniversalGadget: NSObject, NSCoding {
    var typeIndex: Int = 0          // 0 is weapon, 1 is shield, 2 is gadget
    var wType: WeaponType? = nil
    var sType: ShieldType? = nil
    var gType: GadgetType? = nil
    var weaponItem: Weapon? = nil
    var shieldItem: Shield? = nil
    var gadgetItem: Gadget? = nil
    
    var name: String = ""
    var type: String = ""
    var price: Int = 0
    var sellPrice: Int = 0
    var power: String = ""
    var techLevel: TechLevelType = TechLevelType.techLevel8
    var image: UIImage? = nil
    var blurb: String = ""
    
    init(typeIndex: Int, wType: WeaponType?, sType: ShieldType?, gType: GadgetType?) {
        self.typeIndex = typeIndex
        self.wType = wType
        self.sType = sType
        self.gType = gType
        
        if wType != nil {
            self.weaponItem = Weapon(type: wType!)
            self.name = weaponItem!.name
            self.type = "Weapon"
            self.price = weaponItem!.price
            self.sellPrice = weaponItem!.sellPrice
            self.power = "\(weaponItem!.power)"
            self.techLevel = weaponItem!.techLevel
            self.image = weaponItem!.image
            
            switch weaponItem!.type {
                case WeaponType.pulseLaser:
                    blurb = "The Pulse Laser is the weakest weapon available. Its small size allows only enough energy to build up to emit pulses of light."
                case WeaponType.beamLaser:
                    blurb = "The Beam Laser is larger than the Pulse Laser, so it can build up enough charge to power what are essentially two pulse lasers. The resulting effect appears more like a beam."
                case WeaponType.militaryLaser:
                    blurb = "The Military Laser is the largest commercially available weapon. It can build up enough charge to power three pulse lasers in series, resulting in a more dense and concentrated beam."
                case WeaponType.photonDisruptor:
                    blurb = "The Photon Disruptor is a relatively weak weapon, but has the ability to disable an opponent’s electrical systems, rendering them helpless."
                default:
                    print("error")
            }
        }
        if sType != nil {
            self.shieldItem = Shield(type: sType!)
            self.name = shieldItem!.name
            self.type = "Shield"
            self.price = shieldItem!.price
            self.sellPrice = shieldItem!.sellPrice
            self.power = "\(shieldItem!.power)"
            self.techLevel = shieldItem!.techLevel
            self.image = shieldItem!.image
            
            switch shieldItem!.type {
                case ShieldType.energyShield:
                    blurb = "The Energy Shield is a very basic deflector shield. Its operating principle is to absorb the energy directed at it."
                case ShieldType.reflectiveShield:
                    blurb = "The Reflective Shield is twice as powerful as the Energy Shield. It works by reflecting the energy directed at it instead of absorbing that energy."
                default:
                    print("error")
            }
        }
        if gType != nil {
            self.gadgetItem = Gadget(type: gType!)
            self.name = gadgetItem!.name
            self.type = "Gadget"
            self.price = gadgetItem!.price
            self.sellPrice = gadgetItem!.sellPrice
            self.power = "N/A"
            self.techLevel = gadgetItem!.techLevel
            self.image = gadgetItem!.image
            
            switch gadgetItem!.type {
                case GadgetType.cargoBays:
                    blurb = "Extra Cargo bays to store anything your ship can take on as cargo."
                case GadgetType.autoRepair:
                    blurb = "The Auto-Repair system works to reduce the damage your ship sustains in battle, and repairs some damage in between encounters. It also boosts all other engineering functions."
                case GadgetType.navigation:
                    blurb = "The Navigating System increases the overall Pilot skill of the ship, making it harder to hit in battle, and making it easier to flee an encounter."
                case GadgetType.targeting:
                    blurb = "The Targeting System increases the overall Fighter skill of the ship, which increases the amount of damage done to an opponent in battle."
                case GadgetType.cloaking:
                    blurb = "The Cloaking Device can enable your ship to evade detection by an opponent, but only if the Engineer skill of your ship is greater than that of your opponent. It also makes your ship harder to hit in battle."
                default:
                    print("error")
            }
        }
    }
    
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.typeIndex = decoder.decodeObject(forKey: "typeIndex") as! Int
            self.wType = WeaponType(rawValue: decoder.decodeInteger(forKey: "wType"))!    // optional problem?
            self.sType = ShieldType(rawValue: decoder.decodeInteger(forKey: "sType"))!
            self.gType = GadgetType(rawValue: decoder.decodeInteger(forKey: "gType"))!
            self.weaponItem = decoder.decodeObject(forKey: "weaponItem") as! Weapon?
            self.shieldItem = decoder.decodeObject(forKey: "shieldItem") as! Shield?
            self.gadgetItem = decoder.decodeObject(forKey: "gadgetItem") as! Gadget?
            
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.type = decoder.decodeObject(forKey: "type") as! String
            self.price = decoder.decodeInteger(forKey: "price")
            self.sellPrice = decoder.decodeInteger(forKey: "sellPrice")
            self.power = decoder.decodeObject(forKey: "power") as! String
            self.techLevel = decoder.decodeObject(forKey: "techLevel") as! TechLevelType
            self.image = decoder.decodeObject(forKey: "image") as! UIImage?
            self.blurb = decoder.decodeObject(forKey: "blurb") as! String
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(typeIndex, forKey: "typeIndex")
            encoder.encode(wType?.rawValue, forKey: "wType")
            encoder.encode(sType?.rawValue, forKey: "sType")
            encoder.encode(gType?.rawValue, forKey: "gType")
            encoder.encode(weaponItem, forKey: "weaponItem")
            encoder.encode(shieldItem, forKey: "shieldItem")
            encoder.encode(gadgetItem, forKey: "gadgetItem")
        }
    
}
