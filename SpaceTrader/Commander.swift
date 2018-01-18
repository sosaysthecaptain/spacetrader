//
//  Commander.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/11/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


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
    var hasLitteredThisTrip = false
    var caughtLittering = false
    var permanentPortableSingularity = false                            // FOR TESTING
    var portableSingularity = false {
        didSet {                                                        // implementation of permanent
            if permanentPortableSingularity {
                portableSingularity = true
            }
        }
    }
    
    
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
    
    var creditLimit: Int {
        var limit = 0
        if player.policeRecordInt >= 5 {
            print("at least clean police record")
            limit = max(1000, (player.netWorth / 10))
            limit = min (25000, limit)
            
            // round to 200
            if limit > 1000 {
                limit = limit - (limit % 200)
            }
            
            if limit < 0 {
                limit = 0
            }
            
            return limit
        } else {
            return 500
        }
    }
    
    var debtRatio: Double {
        return Double(debt) / Double(creditLimit)
    }
    
    var grounded: Bool {
        if (debtRatio > 1.5) && (debt > 15000) {
            return true
        }
        return false
    }
    
    
    // skills
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
    
    var policeRecord = PoliceRecordType.cleanScore {
        didSet {
            print("DEBUG: POLICE RECORD SET TO \(policeRecord)")
        }
    }
    var reputation = ReputationType.harmlessRep
    var escapePod = false
    
    var inspected = false
    var wildStatus = false
    
    var pirateKills: Int = 0
    var policeKills: Int = 0
    var traderKills: Int = 0
    
    var endGameType: EndGameStatus = EndGameStatus.gameNotOver
    
    
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
    
    var selectedConstructShipSize = SizeType.Small          // orphan, here for lack of a better place
    var selectedConstructShipName: String = "Demo"          // ditto
    
    
    
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
        
        self.commanderShip = SpaceShip(type: ShipType.gnat, IFFStatus: IFFStatusType.Player)
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
        let newShip = SpaceShip(type: ShipType.flea, IFFStatus: IFFStatusType.Player)
        player.commanderShip = newShip
        player.escapePod = false
    }
    
    func buyFuel(_ units: Int) -> Bool {
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
    
    func buyRepairs(_ price: Int) -> Bool {
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
    
    func getPLString(_ commodity: TradeItemType) -> String {
        let pricePaid = player.commanderShip.getPricePaid(commodity)
        var commodityOnBoard = false
        if player.commanderShip.getQuantity(commodity) != 0 {
            commodityOnBoard = true
        }
        
        if commodityOnBoard {
            let localSellPrice = galaxy.currentSystem!.getSellPrice(commodity)
            let PL = localSellPrice - pricePaid
            
            // TODO: format
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            let PLFormatted = numberFormatter.string(from: NSNumber(value: PL))!
            //let valueFormatted = numberFormatter.string(from: NSNumber(value: player.commanderShip.value))!
            
            if PL >= 0 {
                return "+\(PLFormatted) cr."
            } else {
                let absPLFormatted = numberFormatter.string(from: NSNumber(value: abs(PL)))!
                return "-\(absPLFormatted) cr."
            }
        } else {
            return "--"
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
    
    func getPoliceRecordString(_ record: PoliceRecordType) -> String {
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
    
    func getReputationString(_ reputation: ReputationType) -> String {
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
    
    func getShieldStrengthString(_ ship: SpaceShip) -> String {
        var shieldMaxTotal: Int = 0
        var shieldActualTotal: Int = 0
        for shield in ship.shield {
            shieldMaxTotal += shield.power
            shieldActualTotal += shield.currentStrength
        }
        
        if shieldMaxTotal == 0 {
            return "No shields"
        } else {
            return "Shields at \(Int((Double(shieldActualTotal) / Double(shieldMaxTotal)) * 100))%"
        }
        
    }
    
    func incrementPoliceRecord(_ increaseAsOpposedToDecrease: Bool) {
        if increaseAsOpposedToDecrease {
            if player.policeRecord.rawValue < 8 {
                player.policeRecord = PoliceRecordType(rawValue: self.policeRecordInt + 1)!
            }
        } else {
            if player.policeRecord.rawValue > 0 {
                player.policeRecord = PoliceRecordType(rawValue: self.policeRecordInt - 1)!
            }
        }
    }
    
    // NEW BUY/SELL FUNCTIONS. ALL BUYING AND SELLING SHOULD USE THESE*********************************
    
    func buy(_ commodity: TradeItemType, quantity: Int) -> Bool {
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
    
    func sell(_ commodity: TradeItemType, quantity: Int) -> Bool {
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
    
    func getMax(_ commodity: TradeItemType) -> Int {
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
        self.commanderName = decoder.decodeObject(forKey: "commanderName") as! String
        self.difficulty = DifficultyType(rawValue: decoder.decodeObject(forKey: "difficulty") as! String!)!
        self.commanderShip = decoder.decodeObject(forKey: "commanderShip") as! SpaceShip
        self.credits = decoder.decodeInteger(forKey: "credits")
        self.debt = decoder.decodeInteger(forKey: "debt")
        self.days = decoder.decodeInteger(forKey: "days")
        self.specialEvents = decoder.decodeObject(forKey: "specialEvents") as! SpecialEvents
        
        self.remindLoans = decoder.decodeBool(forKey: "remindLoans")
        self.autoFuel = decoder.decodeBool(forKey: "autoFuel")
        self.autoRepair = decoder.decodeBool(forKey: "autoRepair")
        self.autoNewspaper = decoder.decodeBool(forKey: "autoNewspaper")
        self.ignorePirates = decoder.decodeBool(forKey: "ignorePirates")
        self.ignorePolice = decoder.decodeBool(forKey: "ignorePolice")
        self.ignoreTraders = decoder.decodeBool(forKey: "ignoreTraders")
        
        
        self.alreadyPaidForNewspaper = decoder.decodeBool(forKey: "alreadyPaidForNewspaper")
        self.caughtLittering = decoder.decodeBool(forKey: "caughtLittering")
        self.portableSingularity = decoder.decodeBool(forKey: "portableSingularity")
        
        self.insurance = decoder.decodeBool(forKey: "insurance")
        self.noClaim = decoder.decodeInteger(forKey: "noClaim")
        
        self.initialPilotSkill = decoder.decodeInteger(forKey: "initialPilotSkill")
        self.initialFighterSkill = decoder.decodeInteger(forKey: "initialFighterSkill")
        self.initialTraderSkill = decoder.decodeInteger(forKey: "initialTraderSkill")
        self.initialEngineerSkill = decoder.decodeInteger(forKey: "initialEngineerSkill")
        
        self.policeRecord = PoliceRecordType(rawValue: decoder.decodeInteger(forKey: "policeRecord"))!
        self.reputation = ReputationType(rawValue: decoder.decodeInteger(forKey: "reputation"))!
        self.escapePod = decoder.decodeBool(forKey: "escapePod")
        
        self.inspected = decoder.decodeBool(forKey: "inspected")
        self.wildStatus = decoder.decodeBool(forKey: "wildStatus")
        
        self.pirateKills = decoder.decodeInteger(forKey: "pirateKills")
        self.policeKills = decoder.decodeInteger(forKey: "policeKills")
        self.traderKills = decoder.decodeInteger(forKey: "traderKills")
        
        self.endGameType = EndGameStatus(rawValue: decoder.decodeInteger(forKey: "endGameType"))!
        
        super.init()
    }
    
    // NOTE: enums here are encoded as their rawValue. I think this works on the other end?
    
    func encode(with encoder: NSCoder) {
        encoder.encode(commanderName, forKey: "commanderName")
        encoder.encode(difficulty.rawValue, forKey: "difficulty")         //
        encoder.encode(commanderShip, forKey: "commanderShip")
        encoder.encode(credits, forKey: "credits")
        encoder.encode(debt, forKey: "debt")
        encoder.encode(days, forKey: "days")
        encoder.encode(specialEvents, forKey: "specialEvents")
        
        encoder.encode(remindLoans, forKey: "remindLoans")
        encoder.encode(autoFuel, forKey: "autoFuel")
        encoder.encode(autoRepair, forKey: "autoRepair")
        encoder.encode(autoNewspaper, forKey: "autoNewspaper")
        encoder.encode(ignorePirates, forKey: "ignorePirates")
        encoder.encode(ignorePolice, forKey: "ignorePolice")
        encoder.encode(ignoreTraders, forKey: "ignoreTraders")

        encoder.encode(alreadyPaidForNewspaper, forKey: "alreadyPaidForNewspaper")
        encoder.encode(caughtLittering, forKey: "caughtLittering")
        encoder.encode(portableSingularity, forKey: "portableSingularity")
        
        encoder.encode(insurance, forKey: "insurance")
        encoder.encode(noClaim, forKey: "noClaim")
        
        encoder.encode(initialPilotSkill, forKey: "initialPilotSkill")
        encoder.encode(initialFighterSkill, forKey: "initialFighterSkill")
        encoder.encode(initialTraderSkill, forKey: "initialTraderSkill")
        encoder.encode(initialEngineerSkill, forKey: "initialEngineerSkill")
        
        encoder.encode(policeRecord.rawValue, forKey: "policeRecord")     //
        encoder.encode(reputation.rawValue, forKey: "reputation")         //
        encoder.encode(escapePod, forKey: "escapePod")
        
        encoder.encode(inspected, forKey: "inspected")
        encoder.encode(wildStatus, forKey: "wildStatus")
        
        encoder.encode(pirateKills, forKey: "pirateKills")
        encoder.encode(policeKills, forKey: "policeKills")
        encoder.encode(traderKills, forKey: "traderKills")
        
        encoder.encode(endGameType.rawValue, forKey: "endGameType")
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
