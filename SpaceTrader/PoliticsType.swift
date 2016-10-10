//
//  PoliticsType.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

class Politics: NSObject, NSCoding {
    let type: PoliticsType
    let name: String
    let reactionIllegal: Int    // reaction level to illegal goods. 0 = total acceptance
    let activityPolice: Int     // occurance rate of police. 0 = no police
    let activityPirates: Int    // occurance rate of pirates. 0 = no pirates
    let activityTraders: Int    // occurance rate of traders. 0 = no traders
    let minTech: TechLevelType  // minimum tech level needed
    let maxTech: TechLevelType  // maximum tech level where this is found
    let bribeLevel: Int         // indicates how easily police can be bribed. 0 = unbribable/high bribe costs
    let drugsOk: Bool           // drugs can be traded (if not, people aren't interested or the governemnt is too strict)
    let firearmsOk: Bool        // firearms can be traded (if not, people aren't interested or the governemnt is too strict)
    let wanted: TradeItemType            // Tradeitem requested in particular in this type of government
    
    init(type: PoliticsType){
        self.type = type
        
        switch type {
        case PoliticsType.anarchy:
            self.name = "Anarchy"
            self.reactionIllegal = 0
            self.activityPolice = 0
            self.activityPirates = 7
            self.activityTraders = 1
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel5
            self.bribeLevel = 7
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Food
        case PoliticsType.capitalist:
            self.name = "Capitalist State"
            self.reactionIllegal = 2
            self.activityPolice = 3
            self.activityPirates = 2
            self.activityTraders = 7
            self.minTech = TechLevelType.techLevel4
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 1
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Ore
        case PoliticsType.communist:
            self.name = "Communist State"
            self.reactionIllegal = 6
            self.activityPolice = 6
            self.activityPirates = 4
            self.activityTraders = 4
            self.minTech = TechLevelType.techLevel1
            self.maxTech = TechLevelType.techLevel5
            self.bribeLevel = 5
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.None
        case PoliticsType.confederacy:
            self.name = "Confederacy"
            self.reactionIllegal = 5
            self.activityPolice = 4
            self.activityPirates = 3
            self.activityTraders = 5
            self.minTech = TechLevelType.techLevel1
            self.maxTech = TechLevelType.techLevel6
            self.bribeLevel = 3
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Games
        case PoliticsType.corporate:
            self.name = "Corporate State"
            self.reactionIllegal = 2
            self.activityPolice = 6
            self.activityPirates = 2
            self.activityTraders = 7
            self.minTech = TechLevelType.techLevel4
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 2
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Robots
        case PoliticsType.cybernetic:
            self.name = "Cybernetic State"
            self.reactionIllegal = 0
            self.activityPolice = 7
            self.activityPirates = 7
            self.activityTraders = 5
            self.minTech = TechLevelType.techLevel6
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 0
            self.drugsOk = false
            self.firearmsOk = false
            self.wanted = TradeItemType.Ore
        case PoliticsType.democracy:
            self.name = "Democracy"
            self.reactionIllegal = 4
            self.activityPolice = 3
            self.activityPirates = 2
            self.activityTraders = 5
            self.minTech = TechLevelType.techLevel3
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 2
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Games
        case PoliticsType.dictatorship:
            self.name = "Dictatorship"
            self.reactionIllegal = 3
            self.activityPolice = 4
            self.activityPirates = 5
            self.activityTraders = 3
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 2
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.None
        case PoliticsType.fascist:
            self.name = "Fascist State"
            self.reactionIllegal = 7
            self.activityPolice = 7
            self.activityPirates = 7
            self.activityTraders = 1
            self.minTech = TechLevelType.techLevel4
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 0
            self.drugsOk = false
            self.firearmsOk = true
            self.wanted = TradeItemType.Machines
        case PoliticsType.feudal:
            self.name = "Feudal State"
            self.reactionIllegal = 1
            self.activityPolice = 1
            self.activityPirates = 6
            self.activityTraders = 2
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel3
            self.bribeLevel = 6
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Firearms
        case PoliticsType.military:
            self.name = "Military State"
            self.reactionIllegal = 7
            self.activityPolice = 7
            self.activityPirates = 0
            self.activityTraders = 6
            self.minTech = TechLevelType.techLevel2
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 0
            self.drugsOk = false
            self.firearmsOk = true
            self.wanted = TradeItemType.Robots
        case PoliticsType.monarchy:
            self.name = "Monarchy"
            self.reactionIllegal = 3
            self.activityPolice = 4
            self.activityPirates = 3
            self.activityTraders = 4
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel5
            self.bribeLevel = 4
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Medicine
        case PoliticsType.pacifist:
            self.name = "Pacifist State"
            self.reactionIllegal = 7
            self.activityPolice = 2
            self.activityPirates = 1
            self.activityTraders = 5
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel3
            self.bribeLevel = 1
            self.drugsOk = true
            self.firearmsOk = false
            self.wanted = TradeItemType.None
        case PoliticsType.socialist:
            self.name = "Socialist State"
            self.reactionIllegal = 4
            self.activityPolice = 2
            self.activityPirates = 5
            self.activityTraders = 3
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel5
            self.bribeLevel = 6
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.None
        case PoliticsType.satori:
            self.name = "State of Satori"
            self.reactionIllegal = 4
            self.activityPolice = 2     // THESE ARE BOTH VERY SUSPICIOUS VALUES
            self.activityPirates = 5    //
            self.activityTraders = 3
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel1
            self.bribeLevel = 0
            self.drugsOk = false
            self.firearmsOk = false
            self.wanted = TradeItemType.None
        case PoliticsType.technocracy:
            self.name = "Technocracy"
            self.reactionIllegal = 1
            self.activityPolice = 6
            self.activityPirates = 3
            self.activityTraders = 6
            self.minTech = TechLevelType.techLevel4
            self.maxTech = TechLevelType.techLevel7
            self.bribeLevel = 2
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Water
        case PoliticsType.theocracy:
            self.name = "Theocracy"
            self.reactionIllegal = 5
            self.activityPolice = 6
            self.activityPirates = 1
            self.activityTraders = 4
            self.minTech = TechLevelType.techLevel0
            self.maxTech = TechLevelType.techLevel4
            self.bribeLevel = 0
            self.drugsOk = true
            self.firearmsOk = true
            self.wanted = TradeItemType.Narcotics
        }
    }
    
     // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.type = PoliticsType(rawValue: decoder.decodeObject(forKey: "type") as! String!)!
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.reactionIllegal = decoder.decodeInteger(forKey: "reactionIllegal")
            self.activityPolice = decoder.decodeInteger(forKey: "activityPolice")
            self.activityPirates = decoder.decodeInteger(forKey: "activityPirates")
            self.activityTraders = decoder.decodeInteger(forKey: "activityTraders")
            self.minTech = TechLevelType(rawValue: decoder.decodeObject(forKey: "minTech") as! String!)!
            self.maxTech = TechLevelType(rawValue: decoder.decodeObject(forKey: "maxTech") as! String!)!
            self.bribeLevel = decoder.decodeInteger(forKey: "bribeLevel")
            self.drugsOk = decoder.decodeBool(forKey: "drugsOk")
            self.firearmsOk = decoder.decodeBool(forKey: "firearmsOk")
            self.wanted = TradeItemType(rawValue: decoder.decodeObject(forKey: "wanted") as! String!)!
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(type.rawValue, forKey: "type")
            encoder.encode(name, forKey: "name")
            encoder.encode(reactionIllegal, forKey: "reactionIllegal")
            encoder.encode(activityPolice, forKey: "activityPolice")
            encoder.encode(activityPirates, forKey: "activityPirates")
            encoder.encode(activityTraders, forKey: "activityTraders")
            encoder.encode(minTech.rawValue, forKey: "minTech")
            encoder.encode(maxTech.rawValue, forKey: "maxTech")
            encoder.encode(bribeLevel, forKey: "bribeLevel")
            encoder.encode(drugsOk, forKey: "drugsOk")
            encoder.encode(firearmsOk, forKey: "firearmsOk")
            encoder.encode(wanted.rawValue, forKey: "wanted")
        }
}
