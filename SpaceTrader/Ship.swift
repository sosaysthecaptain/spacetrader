//
//  Ship.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

class SpaceShip: NSObject, NSCoding {
    var type: ShipType
    var name: String
    var cargoBays: Int
    var weaponSlots: Int
    var shieldSlots: Int
    var gadgetSlots: Int
    var crewQuarters: Int
    var fuelTanks: Int
    var size: String = ""
    var minTechLevel: TechLevelType
    var costOfFuel: Int
    var price: Int
    var bounty: Int
    var occurance: Int
    var hullStrength: Int
    var disruptedness: Int          // added so disruptors aren't immediately effective
    var police: Int                 // encountered as police with at least this strength
    var pirates: Int
    var traders: Int
    var repairCosts: Int            // cost per one point of damage
    var probabilityOfHit: Int         // scale of 0 to 4, 4 is easiest to hit
    var totalWeapons: Int {
        get {
            var total: Int = 0
            for entry in weapon {
                total += entry.power
            }
            return total
        }
    }
    var photonDisruptor: Bool {
        get {
            var pd = false
            for item in weapon {
                if item.type == WeaponType.photonDisruptor {
                    pd = true
                }
            }
            return pd
        }
    }
    
    var totalShields: Int {
        if shield.count == 0 {
            return 0
        } else {
            var total = 0
            for item in shield {
                total += item.currentStrength
            }
            return total
        }
    }
    
    var totalBays: Int {
        var total = cargoBays
        for item in gadget {
            if item.type == GadgetType.cargoBays {
                total += 5
            }
        }
        return total
    }
    
    var value: Int {
        var total = self.price
        for item in weapon {
            total += Int((Double(item.price) * 0.75))
        }
        for item in shield {
            total += Int((Double(item.price) * 0.75))
        }
        for item in gadget {
            total += Int((Double(item.price) * 0.75))
        }
        
        let valueOfCargoOnBoard = getTotalWorthOfCargo()
        total += valueOfCargoOnBoard
    
        return total
    }
    
    var crewSlotsAvailable: Int {
        return crewQuarters - crew.count - 1
    }
    
    var crewSlotsFilled: Int {
        return crew.count + 1
    }
    
    var cloaked: Bool {                                     // DEBUGGING...
//        for item in gadget {
//            if item.type == GadgetType.Cloaking {
//                return true
//            }
//        }
        return false
    }
    
    var cloakingDevice: Bool {
        
        //print("opponent engineer skill: \(galaxy.currentJourney?.currentEncounter?.opponent.engineer)")
        
        for item in gadget {
            if item.type == GadgetType.cloaking {
                // if cloaking device, player is cloaked only if engineer skill > opponent
                if galaxy.currentJourney?.currentEncounter?.opponent.engineer == nil {
                    return true
                } else if player.engineerSkill > galaxy.currentJourney!.currentEncounter!.opponent.engineer {
                    return true
                }
            }
        }
        return false
    }
    
    var getItemWithLargestQuantity: TradeItemType {
        var runningBestItem = TradeItemType.Water
        var runningBestAmount = 0
        
        let items = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
        
        for item in items {
            let quantityOnBoard = self.getQuantity(item)
            if quantityOnBoard > runningBestAmount {
                runningBestItem = item
                runningBestAmount = quantityOnBoard
            }
        }
        return runningBestItem
    }
    
    var maxCrewPilotSkill: Int {
        var runningMax = 0
        for member in crew {
            if member.pilot > runningMax {
                runningMax = member.pilot
            }
        }
        //print("max opponent pilot skill: \(runningMax)")
        return runningMax
    }
    
    var maxCrewFighterSkill: Int {
        var runningMax = 0
        for member in crew {
            if member.fighter > runningMax {
                runningMax = member.fighter
            }
        }
        //print("max opponent fighter skill: \(runningMax)")
        return runningMax
    }
    
    var maxCrewTraderSkill: Int {
        var runningMax = 0
        for member in crew {
            if member.trader > runningMax {
                runningMax = member.trader
            }
        }
        //print("max opponent trader skill: \(runningMax)")
        return runningMax
    }
    
    var maxCrewEngineerSkill: Int {
        var runningMax = 0
        for member in crew {
            if member.engineer > runningMax {
                runningMax = member.engineer
            }
        }
        //print("max opponent engineer skill: \(runningMax)")
        return runningMax
    }
    
    
    var raided = false
    //var justLootedMarieCeleste = false
    var disabled = false
    
    // ALT METHOD: special cargo bools:
    
    var artifactSpecialCargo = false
    var experimentSpecialCargo = false
    var japoriSpecialCargo = false
    var jarekHagglingComputerSpecialCargo = false
    var reactorSpecialCargo = false
    var sculptureSpecialCargo = false
    var reactorFuelSpecialCargo = false
    var upgradedHull = false
    var reactorFuelBays: Double = 0
    
    var noSpecialCargo: Bool {
        get {
            if !artifactSpecialCargo && !experimentSpecialCargo && !japoriSpecialCargo && !jarekHagglingComputerSpecialCargo && !reactorSpecialCargo && !reactorFuelSpecialCargo && !player.portableSingularity && !upgradedHull {
                    return true
            } else {
                return false
            }
        }
    }
    
    var specialCargoStrings: [String] {
        get {
            var returnArray: [String] = []
            if artifactSpecialCargo {
                returnArray.append("An alien artifact.")
            }
            if experimentSpecialCargo {
                returnArray.append("A portable singularity.")
            }
            if japoriSpecialCargo {
                returnArray.append("10 bays of antidote.")
            }
            if jarekHagglingComputerSpecialCargo {
                returnArray.append("A handheld haggling computer.")
                
//                print("haggling computer appended.")
//                print("array now reads:")
//                for item in returnArray {
//                    print("\(item)")
//                }
            }
            if reactorSpecialCargo {
                returnArray.append("An unstable reactor taking up 5 bays.")
            }
            if sculptureSpecialCargo {
                returnArray.append("A stolen plastic sculpture of a man holding some kind of light sword.")
            }
            if reactorFuelSpecialCargo {
                returnArray.append("\(Int(reactorFuelBays)) bays of enriched fuel.")
            }
            if player.portableSingularity {
                returnArray.append("A portable singularity.")
            }
            if tribbles > 0 {
                if tribbles == 1 {
                    returnArray.append("A cute, furry tribble.")
                } else if tribbles < 100000 {
                    returnArray.append("\(tribbles) cute, furry tribbles.")
                } else {
                    returnArray.append("An infestation of tribbles.")
                }
                
            }
            
            if upgradedHull {
                returnArray.append("Upgraded organic hull.")
            }

            if noSpecialCargo {
                returnArray.append("No special items.")
            }
            return returnArray
        }
    }
    
    var baysTakenUpBySpecialCargo: Int {
        get {
            var returnInt = 0
            if artifactSpecialCargo {
                returnInt += 1
            }
            if experimentSpecialCargo {
                returnInt += 1
            }
            if japoriSpecialCargo {
                returnInt += 10
            }
            if jarekHagglingComputerSpecialCargo {
                returnInt += 0
            }
            if reactorSpecialCargo {
                returnInt += 5
            }
            if sculptureSpecialCargo {
                returnInt += 1
            }
            if reactorFuelSpecialCargo {
                returnInt += Int(reactorFuelBays)
            }
            if noSpecialCargo {
                returnInt += 0
            }
            return returnInt
            
        }
    }
    
    var IFFStatus: IFFStatusType    // player, police, pirate, trader
    // image
    // image shielded
    // image damaged
    
    // is this way of doing cargo even still in use? Remove if not...
    var cargo: [TradeItem] = []     // initializing everything empty. Override this if needed.
    var weapon: [Weapon] = []
    var shield: [Shield] = []
    //var shieldStrength: [Int] = []  // these arrays are getting scary
    var gadget: [Gadget] = []
    var crew: [CrewMember] = []
    var fuel: Int
    var hull: Int
    var tribbles: Int = 0
    
    var hullPercentage: Int {
        get {
            return Int(((Double(hull) / Double(hullStrength)) * 100))
        }
        set(newPercentage) {
            hull = newPercentage * (hullStrength / 100)
        }
    }
    
    var shieldPercentage: Int {
        get {
            var totalPossible: Double = 0
            var totalShield: Double = 0
            
            for entry in shield {
                totalPossible += Double(entry.power)
                totalShield += Double(entry.currentStrength)
            }
            
            if totalPossible != 0 {
                let percentage = (totalShield / totalPossible) * 100
                return Int(percentage)
            } else {
                return 0
            }
        }
    }
    
    var totalCargo: Int {
        get {
            var totalItems: Int = 0
            for item in cargo {
                totalItems += item.quantity
            }
            return totalItems
        }
    }
    
    var baysAvailable: Int {
        get {
            var totalBays = cargoBays - totalCargo - baysTakenUpBySpecialCargo
            for gadget in gadget {
                if gadget.type == GadgetType.cargoBays {
                    totalBays += 5
                }
            }
            return totalBays
        }
    }
    
    var baysFilled: Int {
        get {
            return totalCargo + baysTakenUpBySpecialCargo
        }
    }
    
    // is this even used
    var waterOnBoard: Int = 0
    var fursOnBoard: Int = 0
    var foodOnBoard: Int = 0
    var oreOnBoard: Int = 0
    var gamesOnBoard: Int = 0
    var firearmsOnBoard: Int = 0
    var medicineOnBoard: Int = 0
    var machinesOnBoard: Int = 0
    var narcoticsOnBoard: Int = 0
    var robotsOnBoard: Int = 0
    
    // escape pod currently is a global, as escape pods are transferred

    init(type: ShipType, IFFStatus: IFFStatusType) {
        self.type = type
        //self.cargo = []
        self.weapon = []
        self.shield = []
        //self.shieldStrength = []
        self.gadget = []
        self.crew = []
        
        // cargo
        let commodities: [TradeItemType] = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
        for item in commodities {
            let newItem = TradeItem(item: item, quantity: 0, pricePaid: 0)
            self.cargo.append(newItem)
        }

//        print("NEW CARGO INIT**********************************************************************")
//        for item in cargo {
//            print("item: \(item.name), quantity: \(item.quantity)")
//        }
        
        switch type {
            case ShipType.flea:
                self.type = ShipType.flea
                self.name = "Flea"
                self.cargoBays = 10
                self.weaponSlots = 0
                self.shieldSlots = 0
                self.gadgetSlots = 0
                self.crewQuarters = 1
                self.fuelTanks = 20
                self.minTechLevel = TechLevelType.techLevel4
                self.costOfFuel = 1
                self.price = 2000
                self.bounty = 5
                self.occurance = 2
                self.hullStrength = 25
                self.police = -1
                self.pirates = -1
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 0
                self.size = "Tiny"
            case ShipType.gnat:
                self.type = ShipType.gnat
                self.name = "Gnat"
                self.cargoBays = 15
                self.weaponSlots = 1
                self.shieldSlots = 0
                self.gadgetSlots = 1
                self.crewQuarters = 1
                self.fuelTanks = 14
                self.minTechLevel = TechLevelType.techLevel5
                self.costOfFuel = 2
                self.price = 10000
                self.bounty = 50
                self.occurance = 28
                self.hullStrength = 100
                self.police = 0
                self.pirates = 0
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 1
                self.size = "Small"
            case ShipType.firefly:
                self.type = ShipType.firefly
                self.name = "Firefly"
                self.cargoBays = 20
                self.weaponSlots = 1
                self.shieldSlots = 1
                self.gadgetSlots = 1
                self.crewQuarters = 1
                self.fuelTanks = 17
                self.minTechLevel = TechLevelType.techLevel5
                self.costOfFuel = 3
                self.price = 25000
                self.bounty = 75
                self.occurance = 20
                self.hullStrength = 100
                self.police = 0
                self.pirates = 0
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 1
                self.size = "Small"
            case ShipType.mosquito:
                self.type = ShipType.mosquito
                self.name = "Mosquito"
                self.cargoBays = 15
                self.weaponSlots = 2
                self.shieldSlots = 1
                self.gadgetSlots = 1
                self.crewQuarters = 1
                self.fuelTanks = 13
                self.minTechLevel = TechLevelType.techLevel5
                self.costOfFuel = 5
                self.price = 30000
                self.bounty = 100
                self.occurance = 20
                self.hullStrength = 100
                self.police = 0
                self.pirates = 1
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 1
                self.size = "Small"
            case ShipType.bumblebee:
                self.type = ShipType.bumblebee
                self.name = "Bumblebee"
                self.cargoBays = 25
                self.weaponSlots = 1
                self.shieldSlots = 2
                self.gadgetSlots = 2
                self.crewQuarters = 2
                self.fuelTanks = 15
                self.minTechLevel = TechLevelType.techLevel5
                self.costOfFuel = 7
                self.price = 60000
                self.bounty = 125
                self.occurance = 15
                self.hullStrength = 100
                self.police = 1
                self.pirates = 1
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 2
                self.size = "Medium"
            case ShipType.beetle:
                self.type = ShipType.beetle
                self.name = "Beetle"
                self.cargoBays = 50
                self.weaponSlots = 0
                self.shieldSlots = 1
                self.gadgetSlots = 1
                self.crewQuarters = 3
                self.fuelTanks = 14
                self.minTechLevel = TechLevelType.techLevel5
                self.costOfFuel = 10
                self.price = 80000
                self.bounty = 50
                self.occurance = 3
                self.hullStrength = 50
                self.police = -1
                self.pirates = -1
                self.traders = 0
                self.repairCosts = 1
                self.probabilityOfHit = 2
                self.size = "Medium"
            case ShipType.hornet:
                self.type = ShipType.hornet
                self.name = "Hornet"
                self.cargoBays = 20
                self.weaponSlots = 3
                self.shieldSlots = 2
                self.gadgetSlots = 1
                self.crewQuarters = 2
                self.fuelTanks = 16
                self.minTechLevel = TechLevelType.techLevel6
                self.costOfFuel = 15
                self.price = 100000
                self.bounty = 200
                self.occurance = 6
                self.hullStrength = 150
                self.police = 2
                self.pirates = 3
                self.traders = 1
                self.repairCosts = 2
                self.probabilityOfHit = 3
                self.size = "Large"
            case ShipType.grasshopper:
                self.type = ShipType.grasshopper
                self.name = "Grasshopper"
                self.cargoBays = 30
                self.weaponSlots = 2
                self.shieldSlots = 2
                self.gadgetSlots = 3
                self.crewQuarters = 3
                self.fuelTanks = 15
                self.minTechLevel = TechLevelType.techLevel6
                self.costOfFuel = 15
                self.price = 150000
                self.bounty = 300
                self.occurance = 2
                self.hullStrength = 150
                self.police = 3
                self.pirates = 4
                self.traders = 2
                self.repairCosts = 3
                self.probabilityOfHit = 3
                self.size = "Large"
            case ShipType.termite:
                self.type = ShipType.termite
                self.name = "Termite"
                self.cargoBays = 60
                self.weaponSlots = 1
                self.shieldSlots = 3
                self.gadgetSlots = 2
                self.crewQuarters = 3
                self.fuelTanks = 13
                self.minTechLevel = TechLevelType.techLevel7
                self.costOfFuel = 20
                self.price = 225000
                self.bounty = 300
                self.occurance = 2
                self.hullStrength = 200
                self.police = 4
                self.pirates = 5
                self.traders = 3
                self.repairCosts = 4
                self.probabilityOfHit = 4
                self.size = "Huge"
            case ShipType.wasp:
                self.type = ShipType.wasp
                self.name = "Wasp"
                self.cargoBays = 35
                self.weaponSlots = 3
                self.shieldSlots = 2
                self.gadgetSlots = 2
                self.crewQuarters = 3
                self.fuelTanks = 14
                self.minTechLevel = TechLevelType.techLevel7
                self.costOfFuel = 20
                self.price = 300000
                self.bounty = 500
                self.occurance = 2
                self.hullStrength = 200
                self.police = 5
                self.pirates = 6
                self.traders = 4
                self.repairCosts = 5
                self.probabilityOfHit = 4
                self.size = "Huge"
            case ShipType.custom:
                // THIS DATA LIFTED FROM WASP. FIX.
                self.type = ShipType.wasp
                self.name = "Wasp"
                self.cargoBays = 35
                self.weaponSlots = 3
                self.shieldSlots = 2
                self.gadgetSlots = 2
                self.crewQuarters = 3
                self.fuelTanks = 14
                self.minTechLevel = TechLevelType.techLevel7
                self.costOfFuel = 20
                self.price = 300000
                self.bounty = 500
                self.occurance = 2
                self.hullStrength = 200
                self.police = 5
                self.pirates = 6
                self.traders = 4
                self.repairCosts = 5
                self.probabilityOfHit = 4
            case ShipType.spaceMonster:
                self.type = ShipType.spaceMonster
                self.name = "Space Monster"
                self.cargoBays = 0
                self.weaponSlots = 3
                self.shieldSlots = 0
                self.gadgetSlots = 0
                self.crewQuarters = 1
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 500000
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 500
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 4
            case ShipType.dragonfly:
                self.type = ShipType.dragonfly
                self.name = "Dragonfly"
                self.cargoBays = 0
                self.weaponSlots = 2
                self.shieldSlots = 3
                self.gadgetSlots = 2
                self.crewQuarters = 1
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 500000
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 10
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 1
            case ShipType.mantis:
                self.type = ShipType.mantis
                self.name = "Mantis"
                self.cargoBays = 0
                self.weaponSlots = 3
                self.shieldSlots = 1
                self.gadgetSlots = 3
                self.crewQuarters = 3
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 500000
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 300
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 2
            case ShipType.scarab:
                self.type = ShipType.scarab
                self.name = "Scarab"
                self.cargoBays = 20
                self.weaponSlots = 1
                self.shieldSlots = 0
                self.gadgetSlots = 0
                self.crewQuarters = 2
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 500000
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 400
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 3
            case ShipType.scorpion:
                // THIS DATA LIFTED FROM SCARAB. FIX THIS.
                self.type = ShipType.scarab
                self.name = "Scarab"
                self.cargoBays = 20
                self.weaponSlots = 1
                self.shieldSlots = 2
                self.gadgetSlots = 0
                self.crewQuarters = 2
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 500000
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 400
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 3
            case ShipType.bottle:
                self.type = ShipType.bottle
                self.name = "Bottle"
                self.cargoBays = 0
                self.weaponSlots = 0
                self.shieldSlots = 0
                self.gadgetSlots = 0
                self.crewQuarters = 0
                self.fuelTanks = 1
                self.minTechLevel = TechLevelType.techLevel8
                self.costOfFuel = 1
                self.price = 100
                self.bounty = 0
                self.occurance = 0
                self.hullStrength = 10
                self.police = 8
                self.pirates = 8
                self.traders = 8
                self.repairCosts = 1
                self.probabilityOfHit = 1
            default:
                print("error")
        }
        
        self.IFFStatus = IFFStatus
        self.fuel = fuelTanks
        self.hull = hullStrength
        self.disruptedness = hullStrength
        // must presumably still populate weapons, shields, etc on non-player ships. See global.c for info
    }
    
    // THESE ARE THE ONLY METHODS THAT SHOULD DIRECTLY ADD, REMOVE, OR MEASURE AMOUNT OF CARGO************
    
    // addCargo and removeCargo functions assume quantities have been checked, but return false if not
    func addCargo(_ commodity: TradeItemType, quantity: Int, pricePaid: Int) -> Bool {
        // fail if not enough space
        if baysAvailable < quantity {
            return false
        }
        
        // get present quantity and pricePaid
        //var presentQuantity = 0
        //var oldPricePaid = 0
        for item in cargo {
            if item.item == commodity {
                let presentQuantity = item.quantity
                let oldPricePaid = item.pricePaid
                
                var newAverage = 0
                if presentQuantity != 0 {
                    newAverage = ((presentQuantity * oldPricePaid) + (quantity * pricePaid)) / (presentQuantity + quantity)
                } else {
                    newAverage = pricePaid
                }
                
                item.quantity += quantity
                item.pricePaid = newAverage
            }
        }
        
        return true
    }
    
    func removeCargo(_ commodity: TradeItemType, quantity: Int) -> Bool {
        // returns false if not that many on ship
        for item in cargo {
            if item.item == commodity {
                if item.quantity < quantity {
                    return false
                } else {
                    item.quantity -= quantity
                    // not really necessary
                    if item.quantity == 0 {
                        item.pricePaid = 0
                    }
                }
            }
        }
        
        return true
    }
    
    func getQuantity(_ commodity: TradeItemType) -> Int {
        var quantity = 0
        for item in cargo {
            if item.item == commodity {
                quantity = item.quantity
            }
        }
        return quantity
    }
    
    func getPricePaid(_ commodity: TradeItemType) -> Int {
        var pricePaid = 0
        for item in cargo {
            if item.item == commodity {
                pricePaid = item.pricePaid
            }
        }
        return pricePaid
    }
    
    func getTotalCargo() -> Int {
        var total = 0
        for item in cargo {
            total += item.quantity
        }
        return total
    }
    
    // END CARGO METHODS********************************************************************************
    
//    func sellAllCargo() {
//        let commodities: [TradeItemType] = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
//        
//        for commodity in commodities {
//            let quantity = player.commanderShip.getQuantity(commodity)
//            player.sell(commodity, quantity: quantity)
//        }
//    }
    
    func getTotalWorthOfCargo() -> Int {
        var total = 0
        
        let commodities: [TradeItemType] = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
        
        for commodity in commodities {
            let quantity = player.commanderShip.getQuantity(commodity)
            let salePrice = galaxy.currentSystem?.getSellPrice(commodity)
            var totalSalePrice = 0
            if salePrice != nil {
                totalSalePrice = salePrice! * quantity
            }
            
            total += totalSalePrice
        }
        
        return total
    }
    
    func getMorgansLaserStatus() -> Bool {
        var status = false
        for item in weapon {
            if item.type == WeaponType.morgansLaser {
                status = true
            }
        }
        return status
    }
    
    func getFuelCompactorStatus() -> Bool {
        var status = false
        for item in gadget {
            if item.type == GadgetType.fuelCompactor {
                status = true
            }
        }
        return status
    }
    
    func getLightningShieldStatus() -> Bool {
        var status = false
        for item in shield {
            if item.type == ShieldType.lightningShield {
                status = true
            }
        }
        return status
    }
    
    func getWeaponStatus(_ type: WeaponType) -> Bool {
        for item in weapon {
            if item.type == type {
                return true
            }
        }
        return false
    }
    
    func getShieldStatus(_ type: ShieldType) -> Bool {
        for item in shield {
            if item.type == type {
                return true
            }
        }
        return false
    }
    
    func resetSpecialEquipment(_ morgansLaser: Bool, fuelCompactor: Bool, lightningShield: Bool) {
        // HANDLE POSSIBILITY OF NOT ALL STUFF BEING TRANSFERRABLE?

        if morgansLaser && (weaponSlots >= 1) {
            let laser = Weapon(type: WeaponType.morgansLaser)
            self.weapon.append(laser)
        }
        if fuelCompactor && (cargoBays >= 1) {
            let compactor = Gadget(type: GadgetType.fuelCompactor)
            self.gadget.append(compactor)
        }
        if lightningShield && (shieldSlots >= 1) {
            let lightning = Shield(type: ShieldType.lightningShield)
            self.shield.append(lightning)
        }
    }
    
    func removeCrewMember(_ id: MercenaryName) -> Bool {
        var removeIndex: Int?
        var i = 0
        for member in crew {
            if member.ID == id {
                removeIndex = i
            }
            i += 1
        }
        if removeIndex != nil {
            crew.remove(at: removeIndex!)
            return true
        } else {
            return false
        }
    }
    
    func removeWeapon(_ type: WeaponType) -> Bool {
        // removes one of the weapons of specified type
        var index = 0
        for item in weapon {
            if item.type == type {
                weapon.remove(at: index)
                return true
            }
            index += 1
        }
        return false
    }
    
    func removeShield(_ type: ShieldType) -> Bool {
        // removes shield of specified type
        var index = 0
        for item in shield {
            if item.type == type {
                shield.remove(at: index)
                return true
            }
            index += 1
        }
        return false
    }
    
     // NSCODING METHODS
    // first one decodes, second one encodes
        required init(coder decoder: NSCoder) {
            self.type = ShipType(rawValue: decoder.decodeInteger(forKey: "type"))!
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.cargoBays = decoder.decodeInteger(forKey: "cargoBays")
            self.weaponSlots = decoder.decodeInteger(forKey: "weaponSlots")
            self.shieldSlots = decoder.decodeInteger(forKey: "shieldSlots")
            self.gadgetSlots = decoder.decodeInteger(forKey: "gadgetSlots")
            self.crewQuarters = decoder.decodeInteger(forKey: "crewQuarters")
            self.fuelTanks = decoder.decodeInteger(forKey: "fuelTanks")
            self.size = decoder.decodeObject(forKey: "size") as! String
            self.minTechLevel = TechLevelType(rawValue: decoder.decodeObject(forKey: "minTechLevel") as! String!)!
            self.costOfFuel = decoder.decodeInteger(forKey: "costOfFuel")
            self.price = decoder.decodeInteger(forKey: "price")
            self.bounty = decoder.decodeInteger(forKey: "bounty")
            self.occurance = decoder.decodeInteger(forKey: "occurance")
            self.hullStrength = decoder.decodeInteger(forKey: "hullStrength")
            if self.hullStrength < 5 {
                self.hullStrength = 5
            }
            
            self.disruptedness = decoder.decodeInteger(forKey: "disruptedness")
            self.police = decoder.decodeInteger(forKey: "police")
            self.pirates = decoder.decodeInteger(forKey: "pirates")
            self.traders = decoder.decodeInteger(forKey: "traders")
            self.repairCosts = decoder.decodeInteger(forKey: "repairCosts")
            self.probabilityOfHit = decoder.decodeInteger(forKey: "probabilityOfHit")
            
            self.raided = decoder.decodeBool(forKey: "raided")
            //self.justLootedMarieCeleste = decoder.decodeObjectForKey("justLootedMarieCeleste") as! Bool
            self.disabled = decoder.decodeBool(forKey: "disabled")
            self.IFFStatus = IFFStatusType(rawValue: decoder.decodeObject(forKey: "IFFStatus") as! String!)!
            
            self.cargo = decoder.decodeObject(forKey: "cargo") as! [TradeItem]
            self.weapon = decoder.decodeObject(forKey: "weapon") as! [Weapon]
            self.shield = decoder.decodeObject(forKey: "shield") as! [Shield]
            self.gadget = decoder.decodeObject(forKey: "gadget") as! [Gadget]
            self.crew = decoder.decodeObject(forKey: "crew") as! [CrewMember]
            self.fuel = decoder.decodeInteger(forKey: "fuel")
            self.hull = decoder.decodeInteger(forKey: "hull")
            self.tribbles = decoder.decodeInteger(forKey: "tribbles")
            
            self.waterOnBoard = decoder.decodeInteger(forKey: "waterOnBoard")
            self.fursOnBoard = decoder.decodeInteger(forKey: "fursOnBoard")
            self.foodOnBoard = decoder.decodeInteger(forKey: "foodOnBoard")
            self.oreOnBoard = decoder.decodeInteger(forKey: "oreOnBoard")
            self.gamesOnBoard = decoder.decodeInteger(forKey: "gamesOnBoard")
            self.firearmsOnBoard = decoder.decodeInteger(forKey: "firearmsOnBoard")
            self.medicineOnBoard = decoder.decodeInteger(forKey: "medicineOnBoard")
            self.machinesOnBoard = decoder.decodeInteger(forKey: "machinesOnBoard")
            self.narcoticsOnBoard = decoder.decodeInteger(forKey: "narcoticsOnBoard")
            self.robotsOnBoard = decoder.decodeInteger(forKey: "robotsOnBoard")
            
            self.artifactSpecialCargo = decoder.decodeBool(forKey: "artifactSpecialCargo")
            self.experimentSpecialCargo = decoder.decodeBool(forKey: "experimentSpecialCargo")
            self.japoriSpecialCargo = decoder.decodeBool(forKey: "japoriSpecialCargo")
            self.jarekHagglingComputerSpecialCargo = decoder.decodeBool(forKey: "jarekHagglingComputerSpecialCargo")
            self.reactorSpecialCargo = decoder.decodeBool(forKey: "reactorSpecialCargo")
            self.sculptureSpecialCargo = decoder.decodeBool(forKey: "sculptureSpecialCargo")
            self.reactorFuelSpecialCargo = decoder.decodeBool(forKey: "reactorFuelSpecialCargo")
            self.reactorFuelBays = decoder.decodeDouble(forKey: "reactorFuelBays")
            self.upgradedHull = decoder.decodeBool(forKey: "upgradedHull")
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(type.rawValue, forKey: "type")
            encoder.encode(name, forKey: "name")
            encoder.encode(cargoBays, forKey: "cargoBays")
            encoder.encode(weaponSlots, forKey: "weaponSlots")
            encoder.encode(shieldSlots, forKey: "shieldSlots")
            encoder.encode(gadgetSlots, forKey: "gadgetSlots")
            encoder.encode(crewQuarters, forKey: "crewQuarters")
            encoder.encode(fuelTanks, forKey: "fuelTanks")
            encoder.encode(size, forKey: "size")
            encoder.encode(minTechLevel.rawValue, forKey: "minTechLevel")
            encoder.encode(costOfFuel, forKey: "costOfFuel")
            encoder.encode(price, forKey: "price")
            encoder.encode(bounty, forKey: "bounty")
            encoder.encode(occurance, forKey: "occurance")
            encoder.encode(hullStrength, forKey: "hullStrength")
            encoder.encode(disruptedness, forKey: "disruptedness")
            encoder.encode(police, forKey: "police")
            encoder.encode(pirates, forKey: "pirates")
            encoder.encode(traders, forKey: "traders")
            encoder.encode(repairCosts, forKey: "repairCosts")
            encoder.encode(probabilityOfHit, forKey: "probabilityOfHit")
            
            encoder.encode(raided, forKey: "raided")
            //encoder.encodeObject(justLootedMarieCeleste, forKey: "justLootedMarieCeleste")
            encoder.encode(disabled, forKey: "disabled")
            encoder.encode(IFFStatus.rawValue, forKey: "IFFStatus")
            
            encoder.encode(cargo, forKey: "cargo")
            encoder.encode(weapon, forKey: "weapon")
            encoder.encode(shield, forKey: "shield")
            encoder.encode(gadget, forKey: "gadget")
            encoder.encode(crew, forKey: "crew")
            encoder.encode(fuel, forKey: "fuel")
            encoder.encode(hull, forKey: "hull")
            encoder.encode(tribbles, forKey: "tribbles")
            
            encoder.encode(waterOnBoard, forKey: "waterOnBoard")
            encoder.encode(fursOnBoard, forKey: "fursOnBoard")
            encoder.encode(foodOnBoard, forKey: "foodOnBoard")
            encoder.encode(oreOnBoard, forKey: "oreOnBoard")
            encoder.encode(gamesOnBoard, forKey: "gamesOnBoard")
            encoder.encode(firearmsOnBoard, forKey: "firearmsOnBoard")
            encoder.encode(medicineOnBoard, forKey: "medicineOnBoard")
            encoder.encode(machinesOnBoard, forKey: "machinesOnBoard")
            encoder.encode(narcoticsOnBoard, forKey: "narcoticsOnBoard")
            encoder.encode(robotsOnBoard, forKey: "robotsOnBoard")
            
            encoder.encode(artifactSpecialCargo, forKey: "artifactSpecialCargo")
            encoder.encode(experimentSpecialCargo, forKey: "experimentSpecialCargo")
            encoder.encode(japoriSpecialCargo, forKey: "japoriSpecialCargo")
            encoder.encode(jarekHagglingComputerSpecialCargo, forKey: "jarekHagglingComputerSpecialCargo")
            encoder.encode(reactorSpecialCargo, forKey: "reactorSpecialCargo")
            encoder.encode(sculptureSpecialCargo, forKey: "sculptureSpecialCargo")
            encoder.encode(reactorFuelSpecialCargo, forKey: "reactorFuelSpecialCargo")
            encoder.encode(reactorFuelBays, forKey: "reactorFuelBays")
            encoder.encode(upgradedHull, forKey: "upgradedHull")
        }
}

class SpecialCargoItem: NSObject, NSCoding {
    var name: String
    var quantity: Int
    var baysTakenUp: Int
    
    init(name: String, quantity: Int, baysTakenUp: Int) {
        self.name = name
        self.quantity = quantity
        self.baysTakenUp = baysTakenUp
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.quantity = decoder.decodeInteger(forKey: "quantity")
        self.baysTakenUp = decoder.decodeInteger(forKey: "baysTakenUp")

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(name, forKey: "name")
        encoder.encode(quantity, forKey: "quantity")
        encoder.encode(baysTakenUp, forKey: "baysTakenUp")
    }
}
