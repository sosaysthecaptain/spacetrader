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
        self.pilot = decoder.decodeInteger(forKey: "pilot")
        self.fighter = decoder.decodeInteger(forKey: "fighter")
        self.trader = decoder.decodeInteger(forKey: "trader")
        self.engineer = decoder.decodeInteger(forKey: "engineer")
        self.costPerDay = decoder.decodeInteger(forKey: "costPerDay")

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
