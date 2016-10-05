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
        self.ID = MercenaryName(rawValue: decoder.decodeObject(forKey: "ID") as! String!)!
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.pilot = decoder.decodeObject(forKey: "pilot") as! Int
        self.fighter = decoder.decodeObject(forKey: "fighter") as! Int
        self.trader = decoder.decodeObject(forKey: "trader") as! Int
        self.engineer = decoder.decodeObject(forKey: "engineer") as! Int
        self.costPerDay = decoder.decodeObject(forKey: "costPerDay") as! Int

        super.init()
    }
    

    func encode(with encoder: NSCoder) {
        encoder.encode(ID.rawValue, forKey: "ID")
        encoder.encode(name, forKey: "name")
        encoder.encode(pilot, forKey: "pilot")
        encoder.encode(fighter, forKey: "fighter")
        encoder.encode(trader, forKey: "trader")
        encoder.encode(engineer, forKey: "engineer")
        encoder.encode(costPerDay, forKey: "costPerDay")
    }
}
