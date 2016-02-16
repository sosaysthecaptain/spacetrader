//
//  Commander.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/11/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

class Commander: NSObject, NSCoding {
    var commanderName: String
    var difficulty: DifficultyType
    var commanderShip: SpaceShip
    var credits: Int
    var debt: Int = 0
    var days: Int = 0
    var specialEvents = SpecialEvents()
    
    var remindLoans = true
    var autoFuel = false
    var autoRepair = false
    var autoNewspaper = false
    var ignorePirates = false
    var ignorePolice = false
    var ignoreTraders = false
    var alreadyPaidForNewspaper = false
    var caughtLittering = false
    var portableSingularity = true                  // TESTING ONLY, FIX
    
    var insurance = false
    var noClaim = 0
    var insuranceCost: Int {
        if !insurance {
            return 0
        } else {
            let shipValue = player.commanderShip.value
            var cost = shipValue / 400
            cost = cost - (cost * (noClaim / 100))
            return cost
        }
    }
    var insuredValue: Int {
        return player.commanderShip.value
    }
    
    
    // skills                       DO WE WANT TO DO THIS BY MAX OR TOTAL? SEE WHAT ORIGINAL DOES
    var pilotSkill: Int {
        get {
            var max = initialPilotSkill
            for member in player.commanderShip.crew {
                if member.pilot > max {
                    max = member.pilot
                }
            }
            return max
        }
    }
    var fighterSkill: Int {
        get {
            var max = initialFighterSkill
            for member in player.commanderShip.crew {
                if member.fighter > max {
                    max = member.fighter
                }
            }
            return max
        }
    }
    var traderSkill: Int {
        get {
            var max = initialTraderSkill
            for member in player.commanderShip.crew {
                if member.trader > max {
                    max = member.trader
                }
            }
            if player.commanderShip.jarekHagglingComputerSpecialCargo {
                max += 2
            }
            return max
        }
    }
    var engineerSkill: Int {
        get {
            var max = initialEngineerSkill
            for member in player.commanderShip.crew {
                if member.engineer > max {
                    max = member.engineer
                }
            }
            return max
        }
    }
    
    var initialPilotSkill: Int
    var initialFighterSkill: Int
    var initialTraderSkill: Int
    var initialEngineerSkill: Int
    
    var policeRecord = PoliceRecordType.cleanScore
    var reputation = ReputationType.harmlessRep
    var escapePod = false
    
    var inspected = false
    var wildStatus = false
    
    var pirateKills: Int = 0
    var policeKills: Int = 0
    var traderKills: Int = 0
    
    var endGameType: EndGameStatus = EndGameStatus.GameNotOver
    
    
    var kills: Int {
        return pirateKills + policeKills + traderKills
    }
    
    var netWorth: Int { 
        get {
            return credits - debt + player.commanderShip.value
        }
    }
    
    var difficultyInt: Int {
        get { return getDifficultyInt() }
    }
    
    var policeRecordInt: Int {
        get { return policeRecord.rawValue }
    }
    
    
    
    init(commanderName: String, difficulty: DifficultyType, pilotSkill: Int, fighterSkill: Int, traderSkill: Int, engineerSkill: Int) {
        self.commanderName = commanderName
        self.difficulty = difficulty
//        self.pilotSkill = pilotSkill
//        self.fighterSkill = fighterSkill
//        self.traderSkill = traderSkill
//        self.engineerSkill = engineerSkill
        
        self.initialPilotSkill = pilotSkill
        self.initialFighterSkill = fighterSkill
        self.initialTraderSkill = traderSkill
        self.initialEngineerSkill = engineerSkill
        
        self.credits = 1000
        
        self.commanderShip = SpaceShip(type: ShipType.Gnat, IFFStatus: IFFStatusType.Player)
    }
    
    // current prices
    
    // settings
    
    
//    var Credits: Int
//    var Debt: Int
//    var Days: Int
//    let CurrentSystem: StarSystemID
//    let BuyPrice: Int
//    let SellPrice: Int
//    let ShipPrice: Int
//    let GalacticChartSystem: Int                    // ?
//    let PoliceKills: Int
//    let TraderKills: Int
//    let PirateKills: Int
//    let PoliceRecordScore: Int
//    let AutoFuel: Bool
//    let AutoRepair: Bool
//    let Clicks: Bool                                // ?
//    let EncounterType: EncounterType2               // wtf?
//    let Raided: Bool                                // ?
//    let MonsterStatus: MonsterStatusType
//    let DragonflyStatus: DragonflyStatusType
//    let JaporiDiseaseStatus: JaporiDiseaseStatusType
//    let MoonBought: MoonBoughtStatus
//    let MonsterHull: Int                            // what's this?
//    let NameCommander: String
//    let CurrentForm: Int                            // what's this?
//    let Ship: SpaceShip
//    let Opponent: SpaceShip
//    let Mercenary: [CrewMember]
//    let StarSystem: StarSystemID
//    let EscapePod: Bool
//    let Insurance: Bool
//    let NoClaim: Int                                // what's this?
//    let Inspected: Bool
//    let AlwaysIgnoreTraders: Bool                   // maybe a separate section of settings?
//    let Wormhole: Int                               // NOT INT BUT I HAVE NO IDEA
//    let Difficulty: DifficultyType
//    //let VersionMajor                                // what's this?
//    //let VersionMinor                                // what's this?
//    // buying price is to be included in specific tradeitems? Else must go here.
//    let ArtifactOnBoard: Bool
//    let ReserveMoney: Bool                          // ?
//    let PriceDifferences: Bool                      // ?
//    let APLScreen: Bool                             // ?
//    let LeaveEmpty: Int                             // bays?
//    let TribbleMessage: Bool
//    let AlwaysInfo: Bool
//    let AlwaysIgnorePolice: Bool
//    let AlwaysIgnorePirates: Bool
//    // textual encounters
//    let JarekStatus: JarekStatusType
//    // continuous: bool?
//    let AttackFleeing: Bool
//    let ExperimentAndWildStatus: ExperimentAndWildStatusType
//    let FabricRipProbability: FabricRipProbabilityType
//    let VeryRareEncounter: VeryRareEncounterType
//    // boolean collection?
//    let ReactorStatus: ReactorStatusType
//    let TrackedSystem: StarSystemID
//    let ScarabStatus: ScarabStatusType
//    let AlwaysIgnoreTradeInOrbit: Bool
//    let AlreadyPaidForNewspaper: Bool
//    let GameLoaded: Bool                            // ?
//    let LitterWarning: Bool
//    let SharePreferences: Bool
    
    // preferences
    
//    func buyWater(quantity: Int) {
//        let totalPrice = quantity * currentSystem.waterBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.waterOnBoard += quantity
//            waterPaid = currentSystem.waterBuy
//        }
//    }
//    
//    func buyFurs(quantity: Int) {
//        let totalPrice = quantity * currentSystem.fursBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.fursOnBoard += quantity
//            fursPaid = currentSystem.fursBuy
//        }
//    }
//    
//    func buyFood(quantity: Int) {
//        let totalPrice = quantity * currentSystem.foodBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.foodOnBoard += quantity
//            foodPaid = currentSystem.foodBuy
//        }
//    }
//    
//    func buyOre(quantity: Int) {
//        let totalPrice = quantity * currentSystem.oreBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.oreOnBoard += quantity
//            orePaid = currentSystem.oreBuy
//        }
//    }
//    
//    func buyGames(quantity: Int) {
//        let totalPrice = quantity * currentSystem.gamesBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.gamesOnBoard += quantity
//            gamesPaid = currentSystem.gamesBuy
//        }
//    }
//    
//    func buyFirearms(quantity: Int) {
//        let totalPrice = quantity * currentSystem.firearmsBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.firearmsOnBoard += quantity
//            firearmsPaid = currentSystem.firearmsBuy
//        }
//    }
//    
//    func buyMedicine(quantity: Int) {
//        let totalPrice = quantity * currentSystem.medicineBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.medicineOnBoard += quantity
//            medicinePaid = currentSystem.medicineBuy
//        }
//    }
//    
//    func buyMachines(quantity: Int) {
//        let totalPrice = quantity * currentSystem.machinesBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.machinesOnBoard += quantity
//            machinesPaid = currentSystem.machinesBuy
//        }
//    }
//    
//    func buyNarcotics(quantity: Int) {
//        let totalPrice = quantity * currentSystem.narcoticsBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.narcoticsOnBoard += quantity
//            narcoticsPaid = currentSystem.narcoticsBuy
//        }
//    }
//    
//    func buyRobots(quantity: Int) {
//        let totalPrice = quantity * currentSystem.robotsBuy
//        if player.commanderShip.baysAvailable >= quantity && player.credits >= totalPrice {
//            credits -= totalPrice
//            player.commanderShip.robotsOnBoard += quantity
//            robotsPaid = currentSystem.robotsBuy
//        }
//    }
    
    func insurancePayout() {
        player.credits += self.insuredValue
        player.insurance = false
        player.noClaim = 0
    }
    
    func escapedNewFlea() {
        let newShip = SpaceShip(type: ShipType.Flea, IFFStatus: IFFStatusType.Player)
        player.commanderShip = newShip
        player.escapePod = false
    }
    
    func buyFuel(units: Int) -> Bool {
        let cost = units * player.commanderShip.costOfFuel
        if player.credits >= cost {
            player.commanderShip.fuel += units
            player.credits -= cost
            galaxy.getSystemsInRange()
            return true
        }
        return false
    }
    
    func buyMaxFuel() -> Bool {
        let fuelNeeded = player.commanderShip.fuelTanks - player.commanderShip.fuel
        let cost = fuelNeeded * player.commanderShip.costOfFuel
        
        if player.credits >= cost {
            player.commanderShip.fuel += fuelNeeded
            player.credits -= cost
            galaxy.getSystemsInRange()
            return true
        }
        return false
    }
    
    func buyRepairs(price: Int) -> Bool {
        if player.credits >= price {
            let unitsOfRepairs: Int = price / player.commanderShip.repairCosts
            
            player.commanderShip.hullStrength += unitsOfRepairs
            player.credits -= price
            return true
        }
        return false
    }
    
    func buyMaxRepairs() -> Bool {
        let repairsNeeded = player.commanderShip.hull - player.commanderShip.hullStrength
        let cost = repairsNeeded * player.commanderShip.repairCosts
        
        if player.credits >= cost {
            player.commanderShip.hullStrength = player.commanderShip.hull
            player.credits -= cost
            return true
        }
        return false
    }
    

//    func getCargoOnBoard(commodity: TradeItemType) -> (Int, Int) {
//        var total: Int = 0
//        var average: Int = 0
//        for entry in player.commanderShip.cargo {
//            if entry.item == commodity {
//                total += entry.quantity
//                average += (entry.pricePaid * entry.quantity)
//            }
//        }
//        average = average / total
//        return (total, average)
//    }
//    
//    func getCargoQuantity(commodity: TradeItemType) -> Int {
//        var total: Int = 0
//        for entry in player.commanderShip.cargo {
//            if entry.item == commodity {
//                total += entry.quantity
//            }
//        }
//        return total
//    }
//    
//    func getPricePaid(commodity: TradeItemType) -> Int? {
//        var total: Int = 0
//        var average: Int = 0
//        for entry in player.commanderShip.cargo {
//            if entry.item == commodity {
//                total += entry.quantity
//                average += (entry.pricePaid * entry.quantity)
//            }
//        }
//        if average > 0 {
//            average = average / total
//            return average
//        } else {
//            return nil
//        }
//    }
    
    func getPLString(commodity: TradeItemType) -> String {
        let pricePaid = player.commanderShip.getPricePaid(commodity)
        var commodityOnBoard = false
        if player.commanderShip.getQuantity(commodity) != 0 {
            commodityOnBoard = true
        }
        
        if commodityOnBoard {
            let localSellPrice = galaxy.currentSystem!.getSellPrice(commodity)
            let PL = localSellPrice - pricePaid
            if PL >= 0 {
                return "+\(PL)"
            } else {
                return "-\(abs(PL))"
            }
        } else {
            return "---"
        }
    }
    
    func getDifficultyInt() -> Int {
        switch difficulty {
            case .beginner:
                return 0
            case .easy:
                return 1
            case .normal:
                return 2
            case .hard:
                return 3
            case .impossible:
                return 4
        }
    }
    
    func getPoliceRecordString(record: PoliceRecordType) -> String {
        switch record {
            case .psychopathScore: return "Psyco"
            case .villainScore: return "Villain"
            case .criminalScore: return "Criminal"
            case .crookScore: return "Crook"
            case .dubiousScore: return "Dubious"
            case .cleanScore: return "Clean"
            case .lawfulScore: return "Lawful"
            case .trustedScore: return "Trusted"
            case .likedScore: return "Liked"
            case .heroScore: return "Hero"
        }
    }
    
    func getCommanderPoliceRecord() -> String {
        return getPoliceRecordString(player.policeRecord)
    }
    
    func getReputationString(reputation: ReputationType) -> String {
        switch reputation {
            case .harmlessRep: return "Harmless"
            case .mostlyHarmlessRep: return "Mostly Harmless"
            case .poorRep: return "Poor"
            case .averageRep: return "Average"
            case .aboveAverageRep: return "Above average"
            case .competentRep: return "Competent"
            case .dangerousRep: return "Dangerous"
            case .deadlyRep: return "Deadly"
            case .eliteRep: return "Elite"
        }
    }
    
    func getCommanderReputation() -> String {
        return getReputationString(player.reputation)
    }
    
    func getShieldStrengthString(ship: SpaceShip) -> String {
        var shieldMaxTotal: Int = 0
        var shieldActualTotal: Int = 0
        for shield in ship.shield {
            shieldMaxTotal += shield.power
            shieldActualTotal += shield.currentStrength
        }
        
        if shieldMaxTotal == 0 {
            return "No Shields"
        } else {
            return "Shields at \(Int((Double(shieldActualTotal) / Double(shieldMaxTotal)) * 100))%"
        }
        
    }
    
    // NEW BUY/SELL FUNCTIONS. ALL BUYING AND SELLING SHOULD USE THESE*********************************
    
    func buy(commodity: TradeItemType, quantity: Int) -> Bool {
        let unitPrice = galaxy.currentSystem!.getBuyPrice(commodity)
        let buyPrice = quantity * unitPrice
        // see if transaction can go through
        if (player.commanderShip.baysAvailable < quantity) || (player.credits < buyPrice) || (player.credits < buyPrice) {
            
            return false
        }
        // verify there is enough on hand at current system
        if galaxy.currentSystem?.getQuantityAvailable(commodity) < quantity {
            return false
        }
        
        // add cargo, take money, remove from local system amount
        player.commanderShip.addCargo(commodity, quantity: quantity, pricePaid: unitPrice)
        player.credits -= buyPrice
        
        // decrement system
        galaxy.currentSystem!.modifyQuantities(commodity, quantity: quantity, addAsOpposedToRemove: false)
        
        return true
    }
    
    func sell(commodity: TradeItemType, quantity: Int) -> Bool {
        // see if enough available
        if (player.commanderShip.getQuantity(commodity) < quantity) {
            return false
        }
        
        // remove cargo, add money
        player.commanderShip.removeCargo(commodity, quantity: quantity)
        let unitPrice = galaxy.currentSystem!.getSellPrice(commodity)
        player.credits += (unitPrice * quantity)
        
        // DOES SELLING ADD THIS QUANTITY TO THE LOCAL TRADE ECONOMY?
        
        return true
    }
    
    func getMax(commodity: TradeItemType) -> Int {
        let credits = player.credits
        let unitCost = galaxy.currentSystem!.getBuyPrice(commodity)
        
        var maxCanAfford: Int = 0
        // make sure item is for sale, else we're diving by zero
        if unitCost != 0 {
            maxCanAfford = credits / unitCost
        }
        let baysAvailable = player.commanderShip.baysAvailable
        let amountForSale = galaxy.currentSystem!.getQuantityAvailable(commodity)

        return min(maxCanAfford, baysAvailable, amountForSale)
    }
    
    // END BUY/SELL FUNCTIONS**************************************************************************
    
    // NSCODING METHODS
    
    required init(coder decoder: NSCoder) {
        self.commanderName = decoder.decodeObjectForKey("commanderName") as! String
        self.difficulty = DifficultyType(rawValue: decoder.decodeObjectForKey("difficulty") as! String!)!
        self.commanderShip = decoder.decodeObjectForKey("commanderShip") as! SpaceShip
        self.credits = decoder.decodeObjectForKey("credits") as! Int
        self.debt = decoder.decodeObjectForKey("debt") as! Int
        self.days = decoder.decodeObjectForKey("days") as! Int
        self.specialEvents = decoder.decodeObjectForKey("specialEvents") as! SpecialEvents
        
        self.remindLoans = decoder.decodeObjectForKey("remindLoans") as! Bool
        self.autoFuel = decoder.decodeObjectForKey("autoFuel") as! Bool
        self.autoRepair = decoder.decodeObjectForKey("autoRepair") as! Bool
        self.autoNewspaper = decoder.decodeObjectForKey("autoNewspaper") as! Bool
        self.ignorePirates = decoder.decodeObjectForKey("ignorePirates") as! Bool
        self.ignorePolice = decoder.decodeObjectForKey("ignorePolice") as! Bool
        self.ignoreTraders = decoder.decodeObjectForKey("ignoreTraders") as! Bool
        
        
        self.alreadyPaidForNewspaper = decoder.decodeObjectForKey("alreadyPaidForNewspaper") as! Bool
        self.caughtLittering = decoder.decodeObjectForKey("caughtLittering") as! Bool
        self.portableSingularity = decoder.decodeObjectForKey("portableSingularity") as! Bool
        
        self.insurance = decoder.decodeObjectForKey("insurance") as! Bool
        self.noClaim = decoder.decodeObjectForKey("noClaim") as! Int
        
        self.initialPilotSkill = decoder.decodeObjectForKey("initialPilotSkill") as! Int
        self.initialFighterSkill = decoder.decodeObjectForKey("initialFighterSkill") as! Int
        self.initialTraderSkill = decoder.decodeObjectForKey("initialTraderSkill") as! Int
        self.initialEngineerSkill = decoder.decodeObjectForKey("initialEngineerSkill") as! Int
        
        self.policeRecord = PoliceRecordType(rawValue: decoder.decodeObjectForKey("policeRecord") as! Int!)!
        self.reputation = ReputationType(rawValue: decoder.decodeObjectForKey("reputation") as! Int!)!
        self.escapePod = decoder.decodeObjectForKey("escapePod") as! Bool
        
        self.inspected = decoder.decodeObjectForKey("inspected") as! Bool
        self.wildStatus = decoder.decodeObjectForKey("wildStatus") as! Bool
        
        self.pirateKills = decoder.decodeObjectForKey("pirateKills") as! Int
        self.policeKills = decoder.decodeObjectForKey("policeKills") as! Int
        self.traderKills = decoder.decodeObjectForKey("traderKills") as! Int
        
        self.endGameType = EndGameStatus(rawValue: decoder.decodeObjectForKey("endGameType") as! Int!)!
        
        super.init()
    }
    
    // NOTE: enums here are encoded as their rawValue. I think this works on the other end?
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(commanderName, forKey: "commanderName")
        encoder.encodeObject(difficulty.rawValue, forKey: "difficulty")         //
        encoder.encodeObject(commanderShip, forKey: "commanderShip")
        encoder.encodeObject(credits, forKey: "credits")
        encoder.encodeObject(debt, forKey: "debt")
        encoder.encodeObject(days, forKey: "days")
        encoder.encodeObject(specialEvents, forKey: "specialEvents")
        
        encoder.encodeObject(remindLoans, forKey: "remindLoans")
        encoder.encodeObject(autoFuel, forKey: "autoFuel")
        encoder.encodeObject(autoRepair, forKey: "autoRepair")
        encoder.encodeObject(autoNewspaper, forKey: "autoNewspaper")
        encoder.encodeObject(ignorePirates, forKey: "ignorePirates")
        encoder.encodeObject(ignorePolice, forKey: "ignorePolice")
        encoder.encodeObject(ignoreTraders, forKey: "ignoreTraders")

        encoder.encodeObject(alreadyPaidForNewspaper, forKey: "alreadyPaidForNewspaper")
        encoder.encodeObject(caughtLittering, forKey: "caughtLittering")
        encoder.encodeObject(portableSingularity, forKey: "portableSingularity")
        
        encoder.encodeObject(insurance, forKey: "insurance")
        encoder.encodeObject(noClaim, forKey: "noClaim")
        
        encoder.encodeObject(initialPilotSkill, forKey: "initialPilotSkill")
        encoder.encodeObject(initialFighterSkill, forKey: "initialFighterSkill")
        encoder.encodeObject(initialTraderSkill, forKey: "initialTraderSkill")
        encoder.encodeObject(initialEngineerSkill, forKey: "initialEngineerSkill")
        
        encoder.encodeObject(policeRecord.rawValue, forKey: "policeRecord")     //
        encoder.encodeObject(reputation.rawValue, forKey: "reputation")         //
        encoder.encodeObject(escapePod, forKey: "escapePod")
        
        encoder.encodeObject(inspected, forKey: "inspected")
        encoder.encodeObject(wildStatus, forKey: "wildStatus")
        
        encoder.encodeObject(pirateKills, forKey: "pirateKills")
        encoder.encodeObject(policeKills, forKey: "policeKills")
        encoder.encodeObject(traderKills, forKey: "traderKills")
        
        encoder.encodeObject(endGameType.rawValue, forKey: "endGameType")
    }
    
// NSCODING METHODS
//    required init(coder decoder: NSCoder) {
//        self.commanderName = decoder.decodeObjectForKey("commanderName") as! String
//        self.reputation = ReputationType(rawValue: decoder.decodeObjectForKey("reputation") as! Int!)!
//
//        super.init()
//    }
    
//    func encodeWithCoder(encoder: NSCoder) {
//        encoder.encodeObject(planets, forKey: "planets")
//    }
}