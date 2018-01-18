//
//  Opponent.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/16/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class Opponent: NSObject, NSCoding {
    var ship: SpaceShip
    var commander: Commander
    var type: IFFStatusType
    
    var pilot: Int {
        var runningBest = commander.initialPilotSkill
        if ship.crew.count > 0 {
            for member in ship.crew {
                if member.pilot > runningBest {
                    runningBest = member.pilot
                }
            }
        }
        return runningBest
    }
    
    var fighter: Int {
        var runningBest = commander.initialFighterSkill
        if ship.crew.count > 0 {
            for member in ship.crew {
                if member.fighter > runningBest {
                    runningBest = member.fighter
                }
            }
        }
        return runningBest
    }
    
    var trader: Int {
        var runningBest = commander.initialTraderSkill
        if ship.crew.count > 0 {
            for member in ship.crew {
                if member.trader > runningBest {
                    runningBest = member.trader
                }
            }
        }
        return runningBest
    }
    
    var engineer: Int {
        var runningBest = commander.initialEngineerSkill
        if ship.crew.count > 0 {
            for member in ship.crew {
                if member.engineer > runningBest {
                    runningBest = member.engineer
                }
            }
        }
        return runningBest
    }
    
    init(type: IFFStatusType) {
        
        self.type = type
        
        // these are placeholders only, because I want to be able to do the instantiating function in multiple pieces
        
        self.commander = Commander(commanderName: "Opponent", difficulty: DifficultyType.easy, pilotSkill: rand(10), fighterSkill: rand(10), traderSkill: rand(10), engineerSkill: rand(10))

        self.ship = SpaceShip(type: ShipType.gnat, IFFStatus: type)
    }
    
    func generateOpponent() {
        //print("generateOpponent called")
        var tries = 1
        let name = "NAME"                           // not sure whether he properly needs a name...
        
        // if famous captain, set up with excellent skills, crew, shields, weapon
        if type == IFFStatusType.FamousCaptain {
            ship = SpaceShip(type: ShipType.wasp, IFFStatus: IFFStatusType.FamousCaptain)
            commander = Commander(commanderName: name, difficulty: DifficultyType.easy, pilotSkill: 9, fighterSkill: 9, traderSkill: 9, engineerSkill: 9)
            
            // max crew
            
            // max shields
            
            // max weapons
            
            // return
        }
        
        // select ship, based on tries
        let shipType = pickShipRandomlyBasedOnOccurance(tries)
        ship = SpaceShip(type: shipType, IFFStatus: type)
        
        if type == .Mantis {
            tries = 1 + player.getDifficultyInt()
        }
        
        // if police, set more tries if Wild on board or player record bad
        if type == IFFStatusType.Police {
            if player.policeRecordInt <= 1 && player.wildStatus {
                tries = 3
            } else if player.policeRecordInt == 0 || player.wildStatus {
                tries = 5
            }
        }
        
        // pirates get better as you get richer
        if type ==  .Pirate {
            tries = 1 + (player.netWorth / 100000)
        }
        
        
        // determine gadgets
        let gadgetSlots = ship.gadgetSlots
        var numberOfGadgets: Int = 0
        
        if player.difficultyInt >= 3 {
            numberOfGadgets = gadgetSlots
        } else {
            numberOfGadgets = Int(arc4random_uniform(UInt32(gadgetSlots + 1)))
            if (numberOfGadgets < gadgetSlots) && tries > 3 {
                numberOfGadgets += 1
            }
        }
        
        for _ in 0..<numberOfGadgets {
            addRandomlyChosenGadget(tries)
        }
        
        // fill cargo bays
        var cargoBays: Int = ship.cargoBays
        for gadget in ship.gadget {
            if gadget.type == GadgetType.cargoBays {
                cargoBays += 5
            }
        }
        
        let m = 3 + rand(cargoBays - 5)
        //print("m = \(m)")
        var sum = min(m, 15)
        //print("first result for sum: \(sum)")
        if player.difficultyInt <= 2 {
            cargoBays = sum
        }
        
        //print("sum before pirate adjustment: \(sum)")
        if ship.IFFStatus == IFFStatusType.Pirate {
            if player.difficultyInt < 2 {
                sum = (sum * 4) / 5
            } else {
                sum = sum / player.difficultyInt
            }
        }
        
        if sum < 1 {
            sum = 1
        }
        
        if ship.IFFStatus == IFFStatusType.Police {
            sum = 0
        }
        
        // populate commodities
        if ship.IFFStatus != IFFStatusType.Police && ship.IFFStatus != IFFStatusType.Mantis && ship.IFFStatus != IFFStatusType.Dragonfly && ship.IFFStatus != IFFStatusType.SpaceMonster && ship.IFFStatus != IFFStatusType.Scarab {
            fillCargoBays()
        }
        
        // fill weapon slots
        let weaponSlots = ship.weaponSlots
        var weaponsToAdd: Int = 0
        if weaponSlots == 0 {
            weaponsToAdd = 0
        } else if weaponSlots == 1 {
            weaponsToAdd = 1
        } else if player.difficultyInt < 3 {        // if less than hard
            weaponsToAdd = 1 + rand(weaponSlots)
            if weaponsToAdd < weaponSlots {
                if tries > 4 {
                    weaponsToAdd += 1
                }
            }
        } else {
            weaponsToAdd = weaponSlots
        }
        
        for _ in 0..<weaponsToAdd {
            addRandomlyChosenWeapon(tries)
        }
        
        // fill shield slots
        let shieldSlots = ship.shieldSlots
        var shieldsToAdd: Int = 0
        if shieldSlots == 0 {
            shieldsToAdd = 0
        } else if player.difficultyInt < 3 {        // if less than hard
            shieldsToAdd = 1 + rand(shieldSlots)
            if shieldsToAdd < shieldSlots {
                if tries > 4 {
                    shieldsToAdd += 1
                }
            }
        } else {
            shieldsToAdd = shieldSlots
        }
        
        for _ in 0..<shieldsToAdd {
            addRandomlyChosenShield(tries)
        }
        
        
        
        // set shield & hull strength
        if ship.shield.count != 0 {
            // if there are shields, hull will likely be in better shape
            if rand(10) <= 7 {
                //print("shields present, setting hull accordingly")
                ship.hullPercentage = 100
            } else {
                //print("no shields, hull more likely to be damaged")
                var maxPercentage: Int = 0
                for _ in 0..<5 {
                    let random = 1 + rand(100)
                    if random > maxPercentage {
                        maxPercentage = random
                    }
                }
                ship.hullPercentage = maxPercentage
            }
        }
        
        for shield in ship.shield {
            // set strength randomly 
            if rand(10) < 7 {
                shield.currentStrength = rand(shield.power)
            }
        }
        
        // special ships get full shields and hull
        // MUST ALSO MAKE SURE THESE SHIPS DO GET SHIELDS. CONFIGURATION MUST BE CUSTOM.
        if type == IFFStatusType.FamousCaptain || type == IFFStatusType.Dragonfly || type == IFFStatusType.Mantis || type == IFFStatusType.Scarab || type == IFFStatusType.SpaceMonster || type == IFFStatusType.Bottle || type == IFFStatusType.Scorpion {
            
            ship.hullPercentage = 100
            for shield in ship.shield {
                shield.currentStrength = shield.power
            }
            
        }

        
        // set crew
        let crewCount = ship.crewQuarters
        
        //print("\(crewCount) crewmembers")
        for _ in 0..<crewCount {
            let pilot = rand(10)
            let fighter = rand(10)
            let trader = rand(10)
            let engineer = rand(10)
            //let newCrewMember = CrewMember(name: "", pilot: pilot, fighter: fighter, trader: trader, engineer: engineer, currentSystem: StarSystemID.Acamar)    // name and SSID don't matter
            let newCrewMember = CrewMember(ID: MercenaryName.null, pilot: pilot, fighter: fighter, trader: trader, engineer: engineer)
            ship.crew.append(newCrewMember)
        }
        
        if (galaxy.targetSystem!.name) == "Kravat" && player.wildStatus && (rand(10) < (player.difficultyInt + 1)) {
            //print("wild status option used")
            ship.crew[0].engineer = 9
        }
        
        
        // NOTE THAT THIS IS NOT QUITE WHAT THE ORIGINAL WAS
        
        // SPECIAL OVERRIDE
        // special ships come loaded, no randomly assigned
        // in every case: shields (set to full), weapons, crew
        
        //let shipType = pickShipRandomlyBasedOnOccurance(tries)
        //ship = SpaceShip(type: shipType, IFFStatus: type)       // BASTARD! Source of trouble right here.
        //ship.type = shipType
        
        // if this is mantis/dragonfly/spaceMonster, etc:
        if type == IFFStatusType.Mantis {
            ship.type = ShipType.mantis
            ship.name = "Mantis"                        // this seems necessary, though a kludge
            // mantises not that strong. No special stuff for them.
        } else if type == IFFStatusType.Dragonfly {
            ship.type = ShipType.dragonfly
            ship.name = "Dragonfly"
            loadGoodShields(false)
            loadGoodWeapons(false, number: 1)
            loadGoodCrew(false)
        } else if type == IFFStatusType.Scarab {
            ship.type = ShipType.scarab
            ship.name = "Scarab"
            //loadGoodShields(false)
            
            let scarabShield = Shield(type: ShieldType.energyShield)
            scarabShield.currentStrength = scarabShield.power
            ship.shield = [scarabShield]
            loadGoodWeapons(false, number: 1)
            loadGoodCrew(false)
        } else if type == IFFStatusType.SpaceMonster {
            ship.type = ShipType.spaceMonster
            ship.name = "Space Monster"
            ship.shield = []                            // space monster doesn't have shields
            loadGoodWeapons(false, number: 1)
            loadGoodCrew(false)
        } else if type == IFFStatusType.Scorpion {
            ship.type = ShipType.scorpion
            ship.name = "Scorpion"
            loadGoodShields(false)
            loadGoodWeapons(false, number: 1)
            loadGoodCrew(false)
        } else if type == IFFStatusType.FamousCaptain {
            ship.type = ShipType.wasp
            ship.name = "Wasp"
            loadGoodShields(true)
            loadGoodWeapons(true, number: 2)
            loadGoodCrew(true)
        } else if type == IFFStatusType.Bottle {
            ship.type = ShipType.bottle
            ship.name = "Bottle"
            
        }
        
        if type == IFFStatusType.MarieCeleste {
            // marie celeste gets 5 bays of narcotics
            ship.addCargo(TradeItemType.Narcotics, quantity: 5, pricePaid: 0)
        }
        
        //displayResults()
    }
    

    
    func loadGoodShields(_ lightning: Bool) {
        var shield = Shield(type: ShieldType.reflectiveShield)
        if lightning {
            shield = Shield(type: ShieldType.lightningShield)
        }
        shield.currentStrength = shield.power
        ship.shield.append(shield)                  // kludge, cuz this was going crazy
        
//        print("DEBUG LOADGOODSHIELDS. sh")
//        for _ in 0..<ship.shieldSlots {
//            print("  loading shield")
//            ship.shield.append(shield)
//        }
        
        print(" ")
        print("LOAD GOOD SHIELDS REPORT:")
        print("  shield slots: \(ship.shieldSlots)")
        print("  shields: ")
        for shield in ship.shield {
            print("    \(shield.name), \(shield.power)")
        }
        print("  totalShields: \(ship.totalShields)")
        print(" ")
    }
    
    func loadGoodWeapons(_ morgan: Bool, number: Int) {
        var weapon = Weapon(type: WeaponType.militaryLaser)
        if morgan {
            weapon = Weapon(type: WeaponType.morgansLaser)
        }
        
        let totalWeapons = min(number, ship.weaponSlots)
        for _ in 0..<totalWeapons {
            ship.weapon.append(weapon)
        }
        
        print(" ")
        print("LOAD GOOD WEAPONS REPORT:")
        print("  weapon slots: \(ship.weaponSlots)")
        print("  weapons: ")
        for weapon in ship.weapon {
            print("    \(weapon.name), \(weapon.power)")
        }
        print("  totalWeapons: \(ship.totalWeapons)")
        print(" ")
    }
    
    func loadGoodCrew(_ excellentNotGood: Bool) {
        var newCrewMember = CrewMember(ID: MercenaryName.alyssa, pilot: 7, fighter: 7, trader: 7, engineer: 7)
        if excellentNotGood {
            newCrewMember = CrewMember(ID: MercenaryName.alyssa, pilot: 10, fighter: 10, trader: 10, engineer: 10)
        }
        ship.crew.append(newCrewMember)
    }
    
    
    
    func pickShipRandomlyBasedOnOccurance(_ tries: Int) -> ShipType {
        let ships: [ShipType] = [ShipType.flea, ShipType.gnat, ShipType.firefly, ShipType.mosquito, ShipType.bumblebee, ShipType.beetle, ShipType.hornet, ShipType.grasshopper, ShipType.termite, ShipType.wasp]
        let chancePerShip: [Int] = [2, 28, 20, 20, 15, 3, 6, 2, 2, 2]       // CHANCES SETTABLE HERE
        var resultRandom: [Int] = []
        

        // maxIndex created outside loop, logs the best ship of all the times the loop runs
        
        // maxIndex should log the index of chancePerShip representing the best so far
        
        var runningBestShipIndex: Int = 0
        for _ in 0...tries {
            var maxIndex: Int = 0
            var max: Int = 0
            resultRandom = []
            for number in chancePerShip {
                let result = Int(arc4random_uniform(UInt32(number)))
                resultRandom.append(result)
            }
            
            //var max: Int = 0

            var j: Int = 0
            for result in resultRandom {
                if result >= max {
                    max = result
                    maxIndex = j
                }
                j += 1
                //print("inside loop, j is \(j), max is \(max), result is \(result), maxIndex is: \(maxIndex)")
            }
            //print("winner is \(ships[maxIndex])")
            if maxIndex > runningBestShipIndex {
                runningBestShipIndex = maxIndex
            }
        }
        return ships[runningBestShipIndex]
    }
    
    func addRandomlyChosenGadget(_ tries: Int) {
        let gadgets: [GadgetType] = [GadgetType.cargoBays, GadgetType.autoRepair, GadgetType.navigation, GadgetType.targeting]
        let chances: [Int] = [35, 20, 20, 20, 5]
        
        var runningBestGadgetIndex: Int = 0
        for _ in 0...tries {
            var max: Int = 0
            var maxIndex: Int = 0
            var randomResults: [Int] = []
            var j = 0
            for chance in chances {
                let result = Int(arc4random_uniform(UInt32(chance)))
                randomResults.append(result)
                if result >= max {
                    max = result
                    maxIndex = j
                }
                j += 1
            }
            if maxIndex > runningBestGadgetIndex {
                runningBestGadgetIndex = maxIndex
            }
        }
        
        // fixing bug that caused occasional crash
        if runningBestGadgetIndex > 3 {
            runningBestGadgetIndex = gadgets.count - 1
        }
        let newGadget = Gadget(type: gadgets[runningBestGadgetIndex])
        ship.gadget.append(newGadget)
    }
    
    func addRandomlyChosenWeapon(_ tries: Int) {
        let weapons: [WeaponType] = [WeaponType.pulseLaser, WeaponType.beamLaser, WeaponType.militaryLaser]
        let chances: [Int] = [50, 35, 15]
        
        var runningBestWeaponIndex: Int = 0
        for _ in 0...tries {
            var max: Int = 0
            var maxIndex: Int = 0
            var randomResults: [Int] = []
            var j = 0
            for chance in chances {
                let result = rand(chance)
                randomResults.append(result)
                if result >= max {
                    max = result
                    maxIndex = j
                }
                j += 1
            }
            if maxIndex > runningBestWeaponIndex {
                runningBestWeaponIndex = maxIndex
            }
        }
        //print("weapon result: \(weapons[runningBestWeaponIndex]) ")
        let newWeapon = Weapon(type: weapons[runningBestWeaponIndex])
        ship.weapon.append(newWeapon)
    }
    
    func addRandomlyChosenShield(_ tries: Int) {
        let shields: [ShieldType] = [ShieldType.energyShield, ShieldType.reflectiveShield]
        let chances: [Int] = [70, 30]
        
        var runningBestShieldIndex: Int = 0
        for _ in 0...tries {
            var max: Int = 0
            var maxIndex: Int = 0
            var randomResults: [Int] = []
            var j = 0
            for chance in chances {
                let result = rand(chance)
                randomResults.append(result)
                if result >= max {
                    max = result
                    maxIndex = j
                }
                j += 1
            }
            if maxIndex > runningBestShieldIndex {
                runningBestShieldIndex = maxIndex
            }
        }
        let newShield = Shield(type: shields[runningBestShieldIndex])
        newShield.currentStrength = newShield.power
        ship.shield.append(newShield)
    }
    
    func fillCargoBays() {
        
        let commodities: [TradeItemType] = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
        
        // choose how many bays will be filled
        var baysToBeFilled = 0
        let totalBays = ship.totalBays
        
        if player.difficulty == DifficultyType.beginner {           // about 80%
            baysToBeFilled = rand(totalBays, min: ((totalBays / 5) * 3))
        } else if player.difficulty == DifficultyType.easy {        // about 60%
            baysToBeFilled = rand(((totalBays / 5) * 4), min: ((totalBays / 5) * 2))
        } else if player.difficulty == DifficultyType.normal {      // 40%
            baysToBeFilled = rand(((totalBays / 5) * 3), min: ((totalBays / 5) * 1))
        } else if player.difficulty == DifficultyType.hard {        // 20%
            baysToBeFilled = rand(((totalBays / 5) * 2), min: 0)
        } else {                                                    // 10%
            baysToBeFilled = rand(((totalBays / 5) * 2), min: 0)
        }
        
        baysToBeFilled + rand(10)
        baysToBeFilled - rand(10)
        if baysToBeFilled > ship.totalBays {
            baysToBeFilled = ship.totalBays
        } else if baysToBeFilled < 0 {
            baysToBeFilled = 0
        }
        
        // *POPULATE*
        // decide how many different items to have
        var uniques = 0
        switch baysToBeFilled {
        case 0..<3:
            uniques = 1
        case 3..<4:
            uniques = 2
        case 4..<9:
            uniques = 3
        case 9..<12:
            uniques = 4
        case 12..<16:
            uniques = 5
        case 16..<20:
            uniques = 6
        case 20..<30:
            uniques = 7
        default:
            uniques = 8
        }
        uniques = uniques + rand(4) - rand(3)
        if baysToBeFilled < 3 {
            uniques = 1
        } else {
            uniques = min(uniques, 8)
            uniques = max(uniques, 2)
        }
        
        // randomly choose that many commodities
        var commoditiesInUse: [TradeItemType] = []
        for _ in 0..<uniques {
            let i = rand(10)
            let commodity = commodities[i]
            commoditiesInUse.append(commodity)
        }
        
        // for each item, randomly assign it to one of these categories, add it
        for _ in 0 ..< baysToBeFilled {
            let index = rand(uniques)
            let item = commoditiesInUse[index]
            ship.addCargo(item, quantity: 1, pricePaid: 0)
        }
    
        
        
//        var i = 0
//        //print("initial sum = \(sum)")
//        while i < sum {
//            let randomIndex = rand(10)
//            let randomCommodity = commodities[randomIndex]
//            var numberToAdd = 1 + rand(10 - randomIndex)
//            if (randomIndex + numberToAdd) > sum {
//                numberToAdd = sum - i
//            }
//            //print("add \(numberToAdd) of commodity \(randomCommodity.rawValue)")
//            i += numberToAdd
//            //print("i = \(i), sum = \(sum)")
//            
//            let cargo = TradeItem(item: randomCommodity, quantity: numberToAdd, pricePaid: 0)
//            ship.cargo.append(cargo)
//        }
    }
    
    func displayResults() {
        print("*****************Results of generateOpponent()********************")
        print("encounter with \(ship.IFFStatus) \(ship.name)")
        print("ship type: \(ship.type)")
        print("GADGETS:")
        var slot = 0
        for gadget in ship.gadget {
            print("slot \(slot): \(gadget.name)")
            slot += 1
        }
        if ship.cargo.count == 0 {
            print("no cargo.")
        } else {
            print("CARGO:")
        }
        for item in ship.cargo {
            print("item: \(item.name), quantity: \(item.quantity)")
        }
        
        //print("fuel: \(ship.fuel)")
        //print("tribbles: \(ship.tribbles)")
        
        print("WEAPONS: \(ship.weaponSlots) weapon slots")
        for weapon in ship.weapon {
            print("weapon: \(weapon.name)")
        }
        
        print("SHIELDS: \(ship.shieldSlots) shield slots")
        for shield in ship.shield {
            print("shield: \(shield.name)")
        }
        
        print("CREW: \(ship.crewQuarters) members")
        var j = 0
        print("commander--pilot: \(commander.pilotSkill), fighter: \(commander.fighterSkill), trader: \(commander.traderSkill), engineer: \(commander.engineerSkill)")
        for person in ship.crew {
            print("crew member \(j)--pilot: \(person.pilot), fighter: \(person.fighter), trader: \(person.trader), engineer: \(person.engineer)")
            j += 1
        }
        
        print("hull situation. hullStrength is \(ship.hullStrength), hull is \(ship.hull), hullPercentage is \(ship.hullPercentage)")
    }
    
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.ship = decoder.decodeObject(forKey: "ship") as! SpaceShip
            self.commander = decoder.decodeObject(forKey: "commander") as! Commander
            self.type = IFFStatusType(rawValue: decoder.decodeObject(forKey: "type") as! String!)!
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(ship, forKey: "ship")
            encoder.encode(commander, forKey: "commander")
            encoder.encode(type.rawValue, forKey: "type")
        }
}
