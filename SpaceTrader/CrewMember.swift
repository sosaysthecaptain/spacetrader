//
//  CrewMember.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

class CrewMember: NSObject, NSCoding {
    var ID: MercenaryName
    var name: String
    var pilot: Int
    var fighter: Int
    var trader: Int
    var engineer: Int
    var costPerDay: Int
    
    
    
    init(ID: MercenaryName, pilot: Int, fighter: Int, trader: Int, engineer: Int) {
        self.ID = ID
        self.name = ID.rawValue
        self.pilot = pilot
        self.fighter = fighter
        self.trader = trader
        self.engineer = engineer
        self.costPerDay = ((pilot + fighter + trader + engineer) * 3)
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.ID = MercenaryName(rawValue: decoder.decodeObjectForKey("ID") as! String!)!
        self.name = decoder.decodeObjectForKey("name") as! String
        self.pilot = decoder.decodeObjectForKey("pilot") as! Int
        self.fighter = decoder.decodeObjectForKey("fighter") as! Int
        self.trader = decoder.decodeObjectForKey("trader") as! Int
        self.engineer = decoder.decodeObjectForKey("engineer") as! Int
        self.costPerDay = decoder.decodeObjectForKey("costPerDay") as! Int

        super.init()
    }
    

    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(ID.rawValue, forKey: "ID")
        encoder.encodeObject(name, forKey: "name")
        encoder.encodeObject(pilot, forKey: "pilot")
        encoder.encodeObject(fighter, forKey: "fighter")
        encoder.encodeObject(trader, forKey: "trader")
        encoder.encodeObject(engineer, forKey: "engineer")
        encoder.encodeObject(costPerDay, forKey: "costPerDay")
    }
}