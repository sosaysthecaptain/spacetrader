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
            if item.type == GadgetType.CargoBays {
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
    
    var raided = false
    //var justLootedMarieCeleste = false
    var cloaked = false
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
//            print("cargo bays: \(cargoBays), totalCargo: \(totalCargo), special: \(baysTakenUpBySpecialCargo)")
            return cargoBays - totalCargo - baysTakenUpBySpecialCargo
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
            case ShipType.Flea:
                self.type = ShipType.Flea
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
            case ShipType.Gnat:
                self.type = ShipType.Gnat
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
            case ShipType.Firefly:
                self.type = ShipType.Firefly
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
            case ShipType.Mosquito:
                self.type = ShipType.Mosquito
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
            case ShipType.Bumblebee:
                self.type = ShipType.Bumblebee
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
            case ShipType.Beetle:
                self.type = ShipType.Beetle
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
            case ShipType.Hornet:
                self.type = ShipType.Hornet
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
            case ShipType.Grasshopper:
                self.type = ShipType.Grasshopper
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
            case ShipType.Termite:
                self.type = ShipType.Termite
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
            case ShipType.Wasp:
                self.type = ShipType.Wasp
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
            case ShipType.Custom:
                // THIS DATA LIFTED FROM WASP. FIX.
                self.type = ShipType.Wasp
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
            case ShipType.SpaceMonster:
                self.type = ShipType.SpaceMonster
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
            case ShipType.Dragonfly:
                self.type = ShipType.Dragonfly
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
            case ShipType.Mantis:
                self.type = ShipType.Mantis
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
            case ShipType.Scarab:
                self.type = ShipType.Scarab
                self.name = "Scarab"
                self.cargoBays = 20
                self.weaponSlots = 2
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
            case ShipType.Scorpion:
                // THIS DATA LIFTED FROM SCARAB. FIX THIS.
                self.type = ShipType.Scarab
                self.name = "Scarab"
                self.cargoBays = 20
                self.weaponSlots = 2
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
            case ShipType.Bottle:
                self.type = ShipType.Bottle
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
        // must presumably still populate weapons, shields, etc on non-player ships. See global.c for info
    }
    
    // THESE ARE THE ONLY METHODS THAT SHOULD DIRECTLY ADD, REMOVE, OR MEASURE AMOUNT OF CARGO************
    
    // addCargo and removeCargo functions assume quantities have been checked, but return false if not
    func addCargo(commodity: TradeItemType, quantity: Int, pricePaid: Int) -> Bool {
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
    
    func removeCargo(commodity: TradeItemType, quantity: Int) -> Bool {
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
    
    func getQuantity(commodity: TradeItemType) -> Int {
        var quantity = 0
        for item in cargo {
            if item.item == commodity {
                quantity = item.quantity
            }
        }
        return quantity
    }
    
    func getPricePaid(commodity: TradeItemType) -> Int {
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
            let salePrice = galaxy.currentSystem!.getSellPrice(commodity)
            let totalSalePrice = salePrice * quantity
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
            if item.type == GadgetType.FuelCompactor {
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
    
    func resetSpecialEquipment(morgansLaser: Bool, fuelCompactor: Bool, lightningShield: Bool) {
        // HANDLE POSSIBILITY OF NOT ALL STUFF BEING TRANSFERRABLE?

        if morgansLaser && (weaponSlots >= 1) {
            let laser = Weapon(type: WeaponType.morgansLaser)
            self.weapon.append(laser)
        }
        if fuelCompactor && (cargoBays >= 1) {
            let compactor = Gadget(type: GadgetType.FuelCompactor)
            self.gadget.append(compactor)
        }
        if lightningShield && (shieldSlots >= 1) {
            let lightning = Shield(type: ShieldType.lightningShield)
            self.shield.append(lightning)
        }
    }
    
    func removeCrewMember(id: MercenaryName) -> Bool {
        var removeIndex: Int?
        var i = 0
        for member in crew {
            if member.ID == id {
                removeIndex = i
            }
            i += 1
        }
        if removeIndex != nil {
            crew.removeAtIndex(removeIndex!)
            return true
        } else {
            return false
        }
    }
    
    func removeWeapon(type: WeaponType) -> Bool {
        // removes one of the weapons of specified type
        var index = 0
        for item in weapon {
            if item.type == type {
                weapon.removeAtIndex(index)
                return true
            }
            index += 1
        }
        return false
    }
    
    func removeShield(type: ShieldType) -> Bool {
        // removes shield of specified type
        var index = 0
        for item in shield {
            if item.type == type {
                shield.removeAtIndex(index)
                return true
            }
            index += 1
        }
        return false
    }
    
     // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.type = ShipType(rawValue: decoder.decodeObjectForKey("type") as! Int!)!
            self.name = decoder.decodeObjectForKey("name") as! String
            self.cargoBays = decoder.decodeObjectForKey("cargoBays") as! Int
            self.weaponSlots = decoder.decodeObjectForKey("weaponSlots") as! Int
            self.shieldSlots = decoder.decodeObjectForKey("shieldSlots") as! Int
            self.gadgetSlots = decoder.decodeObjectForKey("gadgetSlots") as! Int
            self.crewQuarters = decoder.decodeObjectForKey("crewQuarters") as! Int
            self.fuelTanks = decoder.decodeObjectForKey("fuelTanks") as! Int
            self.size = decoder.decodeObjectForKey("size") as! String
            self.minTechLevel = TechLevelType(rawValue: decoder.decodeObjectForKey("minTechLevel") as! String!)!
            self.costOfFuel = decoder.decodeObjectForKey("costOfFuel") as! Int
            self.price = decoder.decodeObjectForKey("price") as! Int
            self.bounty = decoder.decodeObjectForKey("bounty") as! Int
            self.occurance = decoder.decodeObjectForKey("occurance") as! Int
            self.hullStrength = decoder.decodeObjectForKey("hullStrength") as! Int
            self.police = decoder.decodeObjectForKey("police") as! Int
            self.pirates = decoder.decodeObjectForKey("pirates") as! Int
            self.traders = decoder.decodeObjectForKey("traders") as! Int
            self.repairCosts = decoder.decodeObjectForKey("repairCosts") as! Int
            self.probabilityOfHit = decoder.decodeObjectForKey("probabilityOfHit") as! Int
            
            self.raided = decoder.decodeObjectForKey("raided") as! Bool
            //self.justLootedMarieCeleste = decoder.decodeObjectForKey("justLootedMarieCeleste") as! Bool
            self.cloaked = decoder.decodeObjectForKey("cloaked") as! Bool
            self.disabled = decoder.decodeObjectForKey("disabled") as! Bool
            self.IFFStatus = IFFStatusType(rawValue: decoder.decodeObjectForKey("IFFStatus") as! String!)!
            
            self.cargo = decoder.decodeObjectForKey("cargo") as! [TradeItem]
            self.weapon = decoder.decodeObjectForKey("weapon") as! [Weapon]
            self.shield = decoder.decodeObjectForKey("shield") as! [Shield]
            self.gadget = decoder.decodeObjectForKey("gadget") as! [Gadget]
            self.crew = decoder.decodeObjectForKey("crew") as! [CrewMember]
            self.fuel = decoder.decodeObjectForKey("fuel") as! Int
            self.hull = decoder.decodeObjectForKey("hull") as! Int
            self.tribbles = decoder.decodeObjectForKey("tribbles") as! Int
            
            self.waterOnBoard = decoder.decodeObjectForKey("waterOnBoard") as! Int
            self.fursOnBoard = decoder.decodeObjectForKey("fursOnBoard") as! Int
            self.foodOnBoard = decoder.decodeObjectForKey("foodOnBoard") as! Int
            self.oreOnBoard = decoder.decodeObjectForKey("oreOnBoard") as! Int
            self.gamesOnBoard = decoder.decodeObjectForKey("gamesOnBoard") as! Int
            self.firearmsOnBoard = decoder.decodeObjectForKey("firearmsOnBoard") as! Int
            self.medicineOnBoard = decoder.decodeObjectForKey("medicineOnBoard") as! Int
            self.machinesOnBoard = decoder.decodeObjectForKey("machinesOnBoard") as! Int
            self.narcoticsOnBoard = decoder.decodeObjectForKey("narcoticsOnBoard") as! Int
            self.robotsOnBoard = decoder.decodeObjectForKey("robotsOnBoard") as! Int
            
            self.artifactSpecialCargo = decoder.decodeObjectForKey("artifactSpecialCargo") as! Bool
            self.experimentSpecialCargo = decoder.decodeObjectForKey("experimentSpecialCargo") as! Bool
            self.japoriSpecialCargo = decoder.decodeObjectForKey("japoriSpecialCargo") as! Bool
            self.jarekHagglingComputerSpecialCargo = decoder.decodeObjectForKey("jarekHagglingComputerSpecialCargo") as! Bool
            self.reactorSpecialCargo = decoder.decodeObjectForKey("reactorSpecialCargo") as! Bool
            self.sculptureSpecialCargo = decoder.decodeObjectForKey("sculptureSpecialCargo") as! Bool
            self.reactorFuelSpecialCargo = decoder.decodeObjectForKey("reactorFuelSpecialCargo") as! Bool
            self.reactorFuelBays = decoder.decodeObjectForKey("reactorFuelBays") as! Double
            self.upgradedHull = decoder.decodeObjectForKey("upgradedHull") as! Bool
    
            super.init()
        }
    
        func encodeWithCoder(encoder: NSCoder) {
            encoder.encodeObject(type.rawValue, forKey: "type")
            encoder.encodeObject(name, forKey: "name")
            encoder.encodeObject(cargoBays, forKey: "cargoBays")
            encoder.encodeObject(weaponSlots, forKey: "weaponSlots")
            encoder.encodeObject(shieldSlots, forKey: "shieldSlots")
            encoder.encodeObject(gadgetSlots, forKey: "gadgetSlots")
            encoder.encodeObject(crewQuarters, forKey: "crewQuarters")
            encoder.encodeObject(fuelTanks, forKey: "fuelTanks")
            encoder.encodeObject(size, forKey: "size")
            encoder.encodeObject(minTechLevel.rawValue, forKey: "minTechLevel")
            encoder.encodeObject(costOfFuel, forKey: "costOfFuel")
            encoder.encodeObject(price, forKey: "price")
            encoder.encodeObject(bounty, forKey: "bounty")
            encoder.encodeObject(occurance, forKey: "occurance")
            encoder.encodeObject(hullStrength, forKey: "hullStrength")
            encoder.encodeObject(police, forKey: "police")
            encoder.encodeObject(pirates, forKey: "pirates")
            encoder.encodeObject(traders, forKey: "traders")
            encoder.encodeObject(repairCosts, forKey: "repairCosts")
            encoder.encodeObject(probabilityOfHit, forKey: "probabilityOfHit")
            
            encoder.encodeObject(raided, forKey: "raided")
            //encoder.encodeObject(justLootedMarieCeleste, forKey: "justLootedMarieCeleste")
            encoder.encodeObject(cloaked, forKey: "cloaked")
            encoder.encodeObject(disabled, forKey: "disabled")
            encoder.encodeObject(IFFStatus.rawValue, forKey: "IFFStatus")
            
            encoder.encodeObject(cargo, forKey: "cargo")
            encoder.encodeObject(weapon, forKey: "weapon")
            encoder.encodeObject(shield, forKey: "shield")
            encoder.encodeObject(gadget, forKey: "gadget")
            encoder.encodeObject(crew, forKey: "crew")
            encoder.encodeObject(fuel, forKey: "fuel")
            encoder.encodeObject(hull, forKey: "hull")
            encoder.encodeObject(tribbles, forKey: "tribbles")
            
            encoder.encodeObject(waterOnBoard, forKey: "waterOnBoard")
            encoder.encodeObject(fursOnBoard, forKey: "fursOnBoard")
            encoder.encodeObject(foodOnBoard, forKey: "foodOnBoard")
            encoder.encodeObject(oreOnBoard, forKey: "oreOnBoard")
            encoder.encodeObject(gamesOnBoard, forKey: "gamesOnBoard")
            encoder.encodeObject(firearmsOnBoard, forKey: "firearmsOnBoard")
            encoder.encodeObject(medicineOnBoard, forKey: "medicineOnBoard")
            encoder.encodeObject(machinesOnBoard, forKey: "machinesOnBoard")
            encoder.encodeObject(narcoticsOnBoard, forKey: "narcoticsOnBoard")
            encoder.encodeObject(robotsOnBoard, forKey: "robotsOnBoard")
            
            encoder.encodeObject(artifactSpecialCargo, forKey: "artifactSpecialCargo")
            encoder.encodeObject(experimentSpecialCargo, forKey: "experimentSpecialCargo")
            encoder.encodeObject(japoriSpecialCargo, forKey: "japoriSpecialCargo")
            encoder.encodeObject(jarekHagglingComputerSpecialCargo, forKey: "jarekHagglingComputerSpecialCargo")
            encoder.encodeObject(reactorSpecialCargo, forKey: "reactorSpecialCargo")
            encoder.encodeObject(sculptureSpecialCargo, forKey: "sculptureSpecialCargo")
            encoder.encodeObject(reactorFuelSpecialCargo, forKey: "reactorFuelSpecialCargo")
            encoder.encodeObject(reactorFuelBays, forKey: "reactorFuelBays")
            encoder.encodeObject(upgradedHull, forKey: "upgradedHull")
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
        self.name = decoder.decodeObjectForKey("name") as! String
        self.quantity = decoder.decodeObjectForKey("quantity") as! Int
        self.baysTakenUp = decoder.decodeObjectForKey("baysTakenUp") as! Int

        super.init()
    }

    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(name, forKey: "name")
        encoder.encodeObject(quantity, forKey: "quantity")
        encoder.encodeObject(baysTakenUp, forKey: "baysTakenUp")
    }
}