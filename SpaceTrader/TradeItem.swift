//
//  TradeItem.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

class TradeItem: NSObject, NSCoding {
    let item: TradeItemType
    let name: String
    let techProduction: TechLevelType       // Tech level needed for production
    let techUsage: TechLevelType            // Tech level needed to use
    let techTopProduction: TechLevelType    // Tech level which produces this item the most
    let priceLowTech: Int                   // Medium price at lowest tech level
    let priceIncrease: Int                  // Price increase per tech level
    let variance: Int                       // Max percentage above or below calculated price
    let doublePriceStatus: StatusType       // Price increases considerably when this event occurs
    let cheapResource: SpecialResourcesType // When this resource is available, this trade item is cheap
    let expensiveResource: SpecialResourcesType
    let minTradePrice: Int                  // Minimum price to buy/sell in orbit
    let maxTradePrice: Int                  // Maximum price to buy/sell in orbit
    let roundOff: Int                       // Roundoff price for trade in orbit
    
    var quantity: Int
    var pricePaid: Int
    
    init(item: TradeItemType, quantity: Int, pricePaid: Int) {
        self.item = item
        self.quantity = quantity
        self.pricePaid = pricePaid
        
        switch item {
        case TradeItemType.Water:
            self.name = "Water"
            self.techProduction = TechLevelType.techLevel0
            self.techUsage = TechLevelType.techLevel0
            self.techTopProduction = TechLevelType.techLevel2
            self.priceLowTech = 30
            self.priceIncrease = +3
            self.variance = 4
            self.doublePriceStatus = StatusType.drought
            self.cheapResource = SpecialResourcesType.lotsOfWater
            self.expensiveResource = SpecialResourcesType.desert
            self.minTradePrice = 30
            self.maxTradePrice = 50
            self.roundOff = 1
        case TradeItemType.Furs:
            self.name = "Furs"
            self.techProduction = TechLevelType.techLevel0
            self.techUsage = TechLevelType.techLevel0
            self.techTopProduction = TechLevelType.techLevel0
            self.priceLowTech = 250
            self.priceIncrease = +10
            self.variance = 10
            self.doublePriceStatus = StatusType.cold
            self.cheapResource = SpecialResourcesType.richFauna
            self.expensiveResource = SpecialResourcesType.lifeless
            self.minTradePrice = 230
            self.maxTradePrice = 280
            self.roundOff = 5
        case TradeItemType.Food:
            self.name = "Food"
            self.techProduction = TechLevelType.techLevel1
            self.techUsage = TechLevelType.techLevel0
            self.techTopProduction = TechLevelType.techLevel1
            self.priceLowTech = 100
            self.priceIncrease = +5
            self.variance = 5
            self.doublePriceStatus = StatusType.cropFailure
            self.cheapResource = SpecialResourcesType.richSoil
            self.expensiveResource = SpecialResourcesType.poorSoil
            self.minTradePrice = 90
            self.maxTradePrice = 160
            self.roundOff = 5
        case TradeItemType.Ore:
            self.name = "Ore"
            self.techProduction = TechLevelType.techLevel2
            self.techUsage = TechLevelType.techLevel2
            self.techTopProduction = TechLevelType.techLevel3
            self.priceLowTech = 350
            self.priceIncrease = +20
            self.variance = 10
            self.doublePriceStatus = StatusType.war
            self.cheapResource = SpecialResourcesType.mineralRich
            self.expensiveResource = SpecialResourcesType.mineralPoor
            self.minTradePrice = 350
            self.maxTradePrice = 420
            self.roundOff = 10
        case TradeItemType.Games:
            self.name = "Games"
            self.techProduction = TechLevelType.techLevel3
            self.techUsage = TechLevelType.techLevel1
            self.techTopProduction = TechLevelType.techLevel6
            self.priceLowTech = 250
            self.priceIncrease = -10
            self.variance = 5
            self.doublePriceStatus = StatusType.boredom
            self.cheapResource = SpecialResourcesType.artisticPopulace
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 160
            self.maxTradePrice = 270
            self.roundOff = 5
        case TradeItemType.Firearms:
            self.name = "Firearms"
            self.techProduction = TechLevelType.techLevel3
            self.techUsage = TechLevelType.techLevel1
            self.techTopProduction = TechLevelType.techLevel5
            self.priceLowTech = 1250
            self.priceIncrease = -75
            self.variance = 100
            self.doublePriceStatus = StatusType.war
            self.cheapResource = SpecialResourcesType.warlikePopulace
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 600
            self.maxTradePrice = 1100
            self.roundOff = 25
        case TradeItemType.Medicine:
            self.name = "Medicine"
            self.techProduction = TechLevelType.techLevel4
            self.techUsage = TechLevelType.techLevel1
            self.techTopProduction = TechLevelType.techLevel6
            self.priceLowTech = 650
            self.priceIncrease = -20
            self.variance = 110
            self.doublePriceStatus = StatusType.plague
            self.cheapResource = SpecialResourcesType.specialHerbs
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 400
            self.maxTradePrice = 700
            self.roundOff = 25
        case TradeItemType.Machines:
            self.name = "Machines"
            self.techProduction = TechLevelType.techLevel4
            self.techUsage = TechLevelType.techLevel3
            self.techTopProduction = TechLevelType.techLevel5
            self.priceLowTech = 900
            self.priceIncrease = -30
            self.variance = 5
            self.doublePriceStatus = StatusType.employment
            self.cheapResource = SpecialResourcesType.none
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 600
            self.maxTradePrice = 800
            self.roundOff = 25
        case TradeItemType.Narcotics:
            self.name = "Narcotics"
            self.techProduction = TechLevelType.techLevel5
            self.techUsage = TechLevelType.techLevel0
            self.techTopProduction = TechLevelType.techLevel5
            self.priceLowTech = 3500
            self.priceIncrease = -125
            self.variance = 150
            self.doublePriceStatus = StatusType.boredom
            self.cheapResource = SpecialResourcesType.weirdMushrooms
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 2000
            self.maxTradePrice = 3000
            self.roundOff = 50
        case TradeItemType.Robots:
            self.name = "Robots"
            self.techProduction = TechLevelType.techLevel6
            self.techUsage = TechLevelType.techLevel4
            self.techTopProduction = TechLevelType.techLevel7
            self.priceLowTech = 5000
            self.priceIncrease = -150
            self.variance = 100
            self.doublePriceStatus = StatusType.employment
            self.cheapResource = SpecialResourcesType.none
            self.expensiveResource = SpecialResourcesType.none
            self.minTradePrice = 3500
            self.maxTradePrice = 5000
            self.roundOff = 100
        default:
            self.name = "Water"
            self.techProduction = TechLevelType.techLevel0
            self.techUsage = TechLevelType.techLevel0
            self.techTopProduction = TechLevelType.techLevel2
            self.priceLowTech = 30
            self.priceIncrease = +3
            self.variance = 4
            self.doublePriceStatus = StatusType.drought
            self.cheapResource = SpecialResourcesType.lotsOfWater
            self.expensiveResource = SpecialResourcesType.desert
            self.minTradePrice = 30
            self.maxTradePrice = 50
            self.roundOff = 1
        }
    }
    
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.item = TradeItemType(rawValue: decoder.decodeObjectForKey("item") as! String!)!
            self.name = decoder.decodeObjectForKey("name") as! String
            self.techProduction = TechLevelType(rawValue: decoder.decodeObjectForKey("techProduction") as! String!)!
            self.techUsage = TechLevelType(rawValue: decoder.decodeObjectForKey("techUsage") as! String!)!
            self.techTopProduction = TechLevelType(rawValue: decoder.decodeObjectForKey("techTopProduction") as! String!)!
            self.priceLowTech = decoder.decodeObjectForKey("priceLowTech") as! Int
            self.priceIncrease = decoder.decodeObjectForKey("priceIncrease") as! Int
            self.variance = decoder.decodeObjectForKey("variance") as! Int
            self.doublePriceStatus = StatusType(rawValue: decoder.decodeObjectForKey("doublePriceStatus") as! String!)!
            self.cheapResource = SpecialResourcesType(rawValue: decoder.decodeObjectForKey("cheapResource") as! String!)!
            self.expensiveResource = SpecialResourcesType(rawValue: decoder.decodeObjectForKey("expensiveResource") as! String!)!
            self.minTradePrice = decoder.decodeObjectForKey("minTradePrice") as! Int
            self.maxTradePrice = decoder.decodeObjectForKey("maxTradePrice") as! Int
            self.roundOff = decoder.decodeObjectForKey("roundOff") as! Int
            
            self.quantity = decoder.decodeObjectForKey("quantity") as! Int
            self.pricePaid = decoder.decodeObjectForKey("pricePaid") as! Int
            
            super.init()
        }
    
        func encodeWithCoder(encoder: NSCoder) {
            encoder.encodeObject(item.rawValue, forKey: "item")
            encoder.encodeObject(name, forKey: "name")
            encoder.encodeObject(techProduction.rawValue, forKey: "techProduction")
            encoder.encodeObject(techUsage.rawValue, forKey: "techUsage")
            encoder.encodeObject(techTopProduction.rawValue, forKey: "techTopProduction")
            encoder.encodeObject(priceLowTech, forKey: "priceLowTech")
            encoder.encodeObject(priceIncrease, forKey: "priceIncrease")
            encoder.encodeObject(variance, forKey: "variance")
            encoder.encodeObject(doublePriceStatus.rawValue, forKey: "doublePriceStatus")
            encoder.encodeObject(cheapResource.rawValue, forKey: "cheapResource")
            encoder.encodeObject(expensiveResource.rawValue, forKey: "expensiveResource")
            encoder.encodeObject(minTradePrice, forKey: "minTradePrice")
            encoder.encodeObject(maxTradePrice, forKey: "maxTradePrice")
            encoder.encodeObject(roundOff, forKey: "roundOff")
            encoder.encodeObject(quantity, forKey: "quantity")
            encoder.encodeObject(pricePaid, forKey: "pricePaid")
        }
}
