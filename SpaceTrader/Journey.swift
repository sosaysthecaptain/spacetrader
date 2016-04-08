//
//  Journey.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/12/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation

class Journey: NSObject, NSCoding {
    let origin: StarSystem
    let destination: StarSystem
    var clicks: Int = 20
    
    var pirate = false
    var police = false
    var trader = false
    
    var mantis = false
    var dragonfly = false
    var scorpion = false
    var scarab = false
    var spaceMonster = false
    
    //    var famousCaptain = false
    //    var marieCeleste = false
    //    var bottle = false
    
    // DEBUG -- force very rare encounters
    var veryRareEventOverride = false                     // set to true to test very rare encounters
    var veryRareEncounter = false
    var marieCelesteLootedThisTurn = false
    
    var currentEncounter: Encounter?
    
    var localPolitics = Politics(type: galaxy.targetSystem!.politics)
    
    let strengthPirates: Int
    let strengthPolice: Int
    let strengthTraders: Int
    
    var uneventfulTrip = true
    
    
    init(origin: StarSystem, destination: StarSystem) {
        self.origin = origin
        self.destination = destination
        
        strengthPirates = localPolitics.activityPirates
        strengthPolice = localPolitics.activityPolice
        strengthTraders = localPolitics.activityTraders
    }
    
    func beginJourney() {
        
        // SHORT CIRCUIT, FOR TESTING PURPOSES ONLY
        //completeJourney()
        
        //        print("**************************************************************")
        //        print("WARP SEQUENCE INITIATED")
        
        // go to WarpViewVC, pause momentarily
        
        if !travelBySingularity {
            let passedText = NSString(string: "notification")
            NSNotificationCenter.defaultCenter().postNotificationName("fireWarpViewSegueNotification", object: passedText)
        } else {
            let passedText = NSString(string: "notification")
            NSNotificationCenter.defaultCenter().postNotificationName("singularityWarpSegueNotification", object: passedText)
        }
        
        
        resumeJourney()
        
    }
    
    func resumeJourney() {
        print("resumeJourney called")
        // this fires when an encounter is done. No need to check if open encounter.
        if clicks > 0 {
            executeClick()
        } else {
            completeJourney()
        }
    }
    
    func executeClick() {
        var encounterThisClick = false
        
        var encounterTest = Int(arc4random_uniform(UInt32(44 - (2 * player.getDifficultyInt()))))
        
        // encounters are half as likely if you're in a flea
        if player.commanderShip.type == ShipType.Flea {
            encounterTest = encounterTest / 2
        }
        
        // engineer may do some repairs
        let engineerSkill = UInt32(player.engineerSkill)
        let repairs = Int(arc4random_uniform(engineerSkill)) / 2     // BUG DANGER THIS FAILED ONCE
        player.commanderShip.hull += repairs
        if player.commanderShip.hull >= player.commanderShip.hullStrength {
            player.commanderShip.hull = player.commanderShip.hullStrength
        }
        
        // slowly heal shields
        for shield in player.commanderShip.shield {
            shield.currentStrength += repairs
            if shield.currentStrength >= shield.power {
                shield.currentStrength = shield.power
            }
        }
        
        // if reactor is on board, do damage--MAYBE MOVE THIS TO ONCE PER WARP?
        if player.commanderShip.reactorSpecialCargo {
            // assigns damage appropriately to player.
            let amountOfDamage = 1
            var remainingDamage = amountOfDamage
            if player.commanderShip.shield.count != 0 {
                var i = 0
                for shield in player.commanderShip.shield {
                    shield.currentStrength -= remainingDamage
                    remainingDamage = 0
                    if shield.currentStrength < 0 {
                        remainingDamage = abs(shield.currentStrength)
                        shield.currentStrength = 0
                    }
                    i += 1
                }
            } else {
                remainingDamage = amountOfDamage
            }
            player.commanderShip.hull -= remainingDamage
        }
        
        // Special, specific encounter?
        // encounter with space monster at acamar?
        if galaxy.targetSystem!.spaceMonsterIsHere {
            if clicks == 2 {
                spaceMonster = true
                encounterThisClick = true
            }
        }
        
        // encounter with stolen scarab?
        if galaxy.targetSystem!.scarabIsHere {
            if clicks == 2 {
                print("SCARAB IS HERE. Time for encounter, at 2 clicks")
                encounterThisClick = true
                scarab = true
            }
        }
        
        // encounter with scorpion at qonos?
        if galaxy.targetSystem!.scorpionIsHere {
            if clicks == 2 {
                print("SCORPION IS HERE. Time for encounter, at 2 clicks")
                encounterThisClick = true
                scorpion = true
            }
        }
        
        // encounter with stolen dragonfly?
        if galaxy.targetSystem!.dragonflyIsHere {
            if clicks == 2 {
                print("DRAGONFLY IS HERE. Time for encounter, at 2 clicks")
                encounterThisClick = true
                dragonfly = true
            }
        }
        
        // encounter with alien mantis at Gemulon if invasion happened?
        if galaxy.targetSystem!.swarmingWithAliens {
            let random = rand(10)
            if random > 3 {
                print("TIME FOR MANTIS ENCOUNTER")
                mantis = true
                encounterThisClick = true
            }
        }
        
        // post marie celeste encounter--must go here, to preempt other things
        if !encounterThisClick && player.specialEvents.marieCelesteStatus == 1 {
            let narcoticsQuantity = player.commanderShip.getQuantity(TradeItemType.Narcotics)
            if narcoticsQuantity != 0 {
                
                // this should be chance-based, if still probable
                let random = rand(8)
                if random < 2 {
                    veryRareEncounter = true
                    encounterThisClick = true
                    player.specialEvents.marieCelesteStatus = 2         // won't happen again
                    currentEncounter = Encounter(type: EncounterType.postMariePoliceEncounter, clicks: clicks)
                    currentEncounter!.beginEncounter()
                }
                
                
            }
        }
        
        // ELSE, check if it is time for an encounter
        if !dragonfly && !scorpion && !scarab && !spaceMonster && !mantis && !encounterThisClick {
            print("at \(clicks) clicks, eligible for an encounter")
            // determine if there will be an encounter, and with whom
            if (encounterTest < strengthPirates) && !player.commanderShip.raided {
                pirate = true
                encounterThisClick = true
            } else if encounterTest < (strengthPirates + strengthPolice) {
                police = true
                encounterThisClick = true
            } else if encounterTest < (strengthTraders + ((strengthPolice + strengthPirates) / 2)) {       // OVER 2 | not orthodox, but this seemed high
                // properly, strengthPirates + strengthPolice + strengthTraders
                trader = true
                encounterThisClick = true
            } // else if Wild status/Kravat...
            
            if !pirate && !police && !trader {
                if player.commanderShip.artifactSpecialCargo && (arc4random_uniform(20) <= 3) {
                    // mantis
                    print("TIME FOR MANTIS ENCOUNTER")
                    mantis = true
                    encounterThisClick = true
                }
            }
        }
        
        // create encounter
        var encounterType = EncounterType.pirateAttack      // holder, will be updated
        
        print("NEW ENCOUNTER****************************************************************")
        print("creating encounter. Type: \(encounterType). Pirate? \(pirate), Police? \(police), Trader? \(trader)")
        print("mantis? \(mantis)")
        print("encounterThisClick? \(encounterThisClick)")
        
        if pirate {
            encounterType = EncounterType.pirateAttack      // default
            //            print("pirate encounter. Default is attack.")
            
            // if you're cloaked, they ignore you
            if player.commanderShip.cloaked {
                encounterType = EncounterType.pirateIgnore
            }
            
            // Pirates will mostly attack, but they are cowardly: if your rep is too high, they tend to flee
            // how to store pirate commander info?
            
            // if pirates are in a better ship, they won't flee no matter how scary you are
            // also need pirate ship instantiated to do this
            
            // If they ignore you or flee and you can't see them, the encounter doesn't take place
            if encounterType == EncounterType.pirateIgnore && player.commanderShip.cloaked {
                encounterType = EncounterType.nullEncounter
            }
            
            // handle cloaking logic
            if player.commanderShip.cloakingDevice {
                
                // all pirate encounters become pirateCloaked
                if (encounterType == EncounterType.pirateAttack) || (encounterType == EncounterType.pirateFlee) || (encounterType == EncounterType.pirateAttack) || (encounterType == EncounterType.pirateIgnore) {
                    
                    encounterType = EncounterType.pirateCloaked
                }
            }
            
            currentEncounter = Encounter(type: encounterType, clicks: clicks)
            currentEncounter!.beginEncounter()
        } else if police {
            //            print("default police interaction is ignore")
            encounterType = EncounterType.policeIgnore      // default
            // if you are cloaked, they won't see you
            if player.commanderShip.cloaked {
                print("police are ignoring you because you're cloaked")
                encounterType = EncounterType.policeIgnore
            } else if player.policeRecord.rawValue < 4 {
                //                print("you are a criminal. Entering that clause...")
                // if you're a criminal, the police will tend to attack
                
                // if you are heavily armed, something
                
                // unless you're impressive, they'll attack
                if player.reputation.rawValue < 3 {
                    //                    print("you are a criminal, and not impressive enough for the police to be scared")
                    encounterType = EncounterType.policeAttack
                } else if Int(arc4random_uniform(8)) > (player.reputation.rawValue) { // rep / (1 + opponent.type) ?
                    //                    print("you are moderately scary, but dice roll determined they will attack you anyway")
                    encounterType = EncounterType.policeAttack
                } else if player.commanderShip.cloaked {
                    print("you are a criminal, but cloaked. Police ignoring.")
                    encounterType = EncounterType.policeIgnore
                } else {
                    //                    print("you are a scary criminal. Police fleeing")
                    encounterType = EncounterType.policeFlee
                }
                // if dubious police will inspect you
            } else if player.policeRecord.rawValue <= 4 {
                //                print("your police record is dubious, so you are getting inspected")
                encounterType = EncounterType.policeInspection
                player.inspected = true
                // if clean but not as high as lawful, 10% chance of inspection on normal
            } else if player.policeRecord.rawValue == 5 {
                // clean police record gets 50% chance of inspection
                //                print("your police record is clean. 50% chance of inspection.")
                if (arc4random_uniform(10) < 5) && !player.inspected {
                    encounterType = EncounterType.policeInspection
                    player.inspected = true
                }
            } else if player.policeRecord.rawValue < 5 {
                
                //                print("your police record is lawful. 10% chance of inspection")
                if (Int(arc4random_uniform(UInt32(12 - player.getDifficultyInt()))) < 1) && !player.inspected {
                    encounterType = EncounterType.policeInspection
                    player.inspected = true
                }
            } else {
                if (arc4random_uniform(40) == 1) && !player.inspected {
                    //                    print("your police record is great, but you're getting inspected anyway, on a 1 in 40 chance")
                    encounterType = EncounterType.policeInspection
                    player.inspected = true
                }
            }
            // if you're impressive but suddenly stuck in a crappy ship, police won't flee even if your reputation if fearsome
            // IMPLEMENT LATER, MUST INSTANTIATE OPPONENT SHIP HERE TO DO THAT
            
            if encounterType == EncounterType.policeIgnore && player.commanderShip.cloaked {
            //print("you are cloaked and the police are ignoring you. Encounter won't happen")
                encounterType = EncounterType.nullEncounter
            }
            
            // if the police are after you but your police record is less than criminal, they'll hail you to surrender instead of attacking
            if encounterType == EncounterType.policeAttack && player.policeRecord.rawValue > 2 {
                //                print("police not attacking you because you're only a small time crook")
                encounterType = EncounterType.policeSurrenderDemand
            }
            
            // honor autoIgnore and autoFlee, both of which have yet to be implemented
            
            // instantiate the encounter we've set up, with encounterType.
            // skip if it's an ignore encounter and you've turned off that kind
            if encounterType == EncounterType.policeIgnore {
                if player.ignorePolice {
                    encounterType = EncounterType.nullEncounter
                    encounterThisClick = false
                    print("player opted out of police ignore encounter")
                }
            }
            
            if encounterType == EncounterType.pirateIgnore {
                if player.ignorePirates {
                    encounterType = EncounterType.nullEncounter
                    encounterThisClick = false
                    print("player opted out of pirate ignore encounter")
                }
            }
            
            if encounterType == EncounterType.traderIgnore {
                if player.ignoreTraders {
                    encounterType = EncounterType.nullEncounter
                    encounterThisClick = false
                    print("player opted out of trader ignore encounter")
                }
            }
            
            // handle cloaking logic
            if player.commanderShip.cloakingDevice {
                
                // all police encounters become policeCloaked
                if  (encounterType == EncounterType.policeInspection) || (encounterType == EncounterType.policeIgnore) || (encounterType == EncounterType.postMariePoliceEncounter) {
                    encounterType = EncounterType.policeCloaked
                }
                
//                // all pirate encounters become pirateCloaked
//                if (encounterType == EncounterType.pirateAttack) || (encounterType == EncounterType.pirateFlee) || (encounterType == EncounterType.pirateAttack) || (encounterType == EncounterType.pirateIgnore) {
//                    
//                    encounterType = EncounterType.pirateCloaked
//                }
//                
//                // all trader encounters become traderCloaked
//                if (encounterType == EncounterType.traderBuy) || (encounterType == EncounterType.traderSell) || (encounterType == EncounterType.traderIgnore) {
//                    
//                    encounterType = EncounterType.traderCloaked
//                }
            }
            
            encounterThisClick = true
            currentEncounter = Encounter(type: encounterType, clicks: clicks)
            currentEncounter!.beginEncounter()
        //} else if trader && !encounterThisClick {
        } else if trader {
            var tradeInOrbit = false
            encounterThisClick = true
            
            // DETERMINING SORT OF TRADER ENCOUNTER
            if player.commanderShip.cloaked {
                
                // if cloaked, traderIgnore
                //print("trader ignoring cuz you're cloaked")
                encounterType = EncounterType.traderIgnore
            } else if (player.policeRecordInt < 3) && (rand(100) <= (player.reputation.rawValue * 10)) {
                
                // If you're a criminal, traders tend to flee if you've got at least some reputation
                //print("trader fleeing cuz you're scary")
                encounterType = EncounterType.traderFlee
            } else {
                // eligible for trade encounter. Determine whether trade in orbit at all
                if rand(100) > 50 {                                 // SET CHANCE OF TRADE IN ORBIT HERE
                    //print("trade in orbit!")
                    tradeInOrbit = true
                } else {
                    //print("no trade in orbit!")
                    encounterType = EncounterType.traderIgnore
                }
            }
            
            // if trade is to proceed, determine whether will be traderBuy or traderSell based on how many bays the player has available
            if tradeInOrbit {
                // figure out how many bays the player has full
                let baysFull = player.commanderShip.cargoBays - player.commanderShip.baysAvailable
                
                // if player has more bays full than not, will be traderBuy. Else, traderSell
                print("baysFull: \(baysFull), baysAvailable: \(player.commanderShip.baysAvailable)")
                if baysFull > player.commanderShip.baysAvailable {
                    print("player has more bays full, encounter will be traderBuy")
                    encounterType = EncounterType.traderBuy
                } else {
                    print("player has more bays empty, encounter will be traderSell")
                    encounterType = EncounterType.traderSell
                }
            }
            
            // handle cloaking logic
            if player.commanderShip.cloakingDevice {

                // all trader encounters become traderCloaked
                if (encounterType == EncounterType.traderBuy) || (encounterType == EncounterType.traderSell) || (encounterType == EncounterType.traderIgnore) {
                    
                    encounterType = EncounterType.traderCloaked
                }
            }
            
            // take into account user's preferences as to ignoring traders, ignoring trade in orbit
            if player.ignoreTraders {
                encounterType = EncounterType.nullEncounter
            }
            
            
            
            // type determined, instantiate encounter
            currentEncounter = Encounter(type: encounterType, clicks: clicks)
            currentEncounter!.beginEncounter()
            
        } else if mantis {                          // && !encounterThisClick
            print("MANTIS ENCOUNTER...")            // WE SEEM TO NEVER BE MAKING IT HERE
            encounterThisClick = true
            print("set encounterThisClick to true")
            currentEncounter = Encounter(type: EncounterType.mantisAttack, clicks: clicks)
            print("about to begin mantisAttack encounter...passing control to Encounter")
            currentEncounter!.beginEncounter()
        } else if dragonfly && !encounterThisClick {
            encounterThisClick = true
            currentEncounter = Encounter(type: EncounterType.dragonflyAttack, clicks: clicks)
            currentEncounter!.beginEncounter()
        } else if scorpion && !encounterThisClick {
            encounterThisClick = true
            currentEncounter = Encounter(type: EncounterType.scorpionAttack, clicks: clicks)
            currentEncounter!.beginEncounter()
        } else if spaceMonster && !encounterThisClick {
            encounterThisClick = true
            currentEncounter = Encounter(type: EncounterType.spaceMonsterAttack, clicks: clicks)
            currentEncounter!.beginEncounter()
        } else if scarab && !encounterThisClick {
            encounterThisClick = true
            currentEncounter = Encounter(type: EncounterType.scarabAttack, clicks: clicks)
            currentEncounter!.beginEncounter()
        }
        
        // very rare event. veryRareOverride used to make this happen more often for testing
        // (it asks if !veryRareEncounter to handle postMarieCelesteEncounter scenario)
        if !pirate && !police && !trader && !mantis && !veryRareEncounter {
            if (player.days > 10) && (arc4random_uniform(1000) < 5) || veryRareEventOverride {
                print("VERY RARE ENCOUNTER")
                // not setting veryRareEncounter flag to true, since marie celeste can still opt out
                let random = rand(5)
                if random < 2 {
                    // marie celeste, if it hasn't already happened
                    print("MARIE CELESTE TIME")
                    print("marieCelesteStatus: \(player.specialEvents.marieCelesteStatus)")
                    if player.specialEvents.marieCelesteStatus == 0 {
                        veryRareEncounter = true
                        encounterThisClick = true
                        print("marie celeste: inside if condition, event should fire now")
                        player.specialEvents.marieCelesteStatus = 1     // set status to 1, to prompt police inspection
                        currentEncounter = Encounter(type: EncounterType.marieCelesteEncounter, clicks: clicks)
                        currentEncounter!.beginEncounter()
                    }
                } else if random == 2 {
                    // three possible famous captain encounters. Choose one
                    let random = rand(3)
                    switch random {
                        case 0:
                            // player needs a reflective shield for this to happen
                            if !player.specialEvents.captainAhabHappened && (player.commanderShip.getShieldStatus(ShieldType.reflectiveShield) == true) {
                                player.specialEvents.captainAhabHappened = true
                                veryRareEncounter = true
                                encounterThisClick = true
                                currentEncounter = Encounter(type: EncounterType.famousCaptainAhab, clicks: clicks)
                                currentEncounter!.beginEncounter()
                            }
                        case 1:
                            // player needs a military laser for this to happen
                            if !player.specialEvents.captainConradHappened && (player.commanderShip.getWeaponStatus(WeaponType.militaryLaser)) {
                                player.specialEvents.captainConradHappened = true
                                veryRareEncounter = true
                                encounterThisClick = true
                                currentEncounter = Encounter(type: EncounterType.famousCaptainConrad, clicks: clicks)
                                currentEncounter!.beginEncounter()
                            }
                        case 2:
                            // player needs a military laser for this to happen
                            if !player.specialEvents.captainHuieHappened && (player.commanderShip.getWeaponStatus(WeaponType.militaryLaser)) {
                                player.specialEvents.captainHuieHappened = true
                                veryRareEncounter = true
                                encounterThisClick = true
                                currentEncounter = Encounter(type: EncounterType.famousCaptainHuie, clicks: clicks)
                                currentEncounter!.beginEncounter()
                            }
                        default:
                            print("error")
                    }
                    
                } else if random == 3 {
                    veryRareEncounter = true
                    encounterThisClick = true
                    print("bottleOld @ \(clicks) clicks")
                    currentEncounter = Encounter(type: EncounterType.bottleOldEncounter, clicks: clicks)
                    currentEncounter!.beginEncounter()
                } else if random == 4 {
                    veryRareEncounter = true
                    encounterThisClick = true
                    print("bottleGood @ \(clicks) clicks")
                    currentEncounter = Encounter(type: EncounterType.bottleGoodEncounter, clicks: clicks)
                    currentEncounter!.beginEncounter()
                }
                
            }
        }
        
        if pirate || police || trader || mantis || dragonfly || spaceMonster || scarab || scorpion || veryRareEncounter {
            uneventfulTrip = false
            encounterThisClick = true
        }
        
        pirate = false
        police = false
        trader = false
        mantis = false
        dragonfly = false
        spaceMonster = false
        scarab = false
        scorpion = false
        veryRareEncounter = false
        //        famousCaptain = false
        //        marieCeleste = false
        //        bottle = false
        
        clicks -= 1
        
        if !encounterThisClick {
            if clicks > 0 {
                executeClick()
            } else {
                completeJourney()
            }
            
        }
    }
    
    
    func completeJourney() {            // accomplishes warp, decrements fuel, updates galaxy
        let journeyDistance = galaxy.getDistance(galaxy.currentSystem!, system2: galaxy.targetSystem!)
        let oldSystem = galaxy.currentSystem
        
        // recharge shields the rest of the way
        for shield in player.commanderShip.shield {
            shield.currentStrength = shield.power
        }
        
        // marie celeste: if player has gotten away with it, he's in the clear
        if player.specialEvents.marieCelesteStatus == 1 {
            player.specialEvents.marieCelesteStatus = 2
        }
        
        if !galaxy.spaceTimeMessedUp {
            galaxy.currentSystem = galaxy.targetSystem
        } else {
            // if spacetime is messed up, possibility of ending up somewhere else
            // in this case, arrival alert SpecialSpacetimeFabricRip
            let random = rand(100)
            if random > 70 {
                galaxy.alertsToFireOnArrival.append(AlertID.SpecialSpacetimeFabricRip)
                // randomly choose planet
                let randomPlanetIndex = rand(galaxy.planets.count)
                galaxy.currentSystem = galaxy.planets[randomPlanetIndex]
                
            } else {
                // no rip drama
                galaxy.currentSystem = galaxy.targetSystem
            }
        }
        
        galaxy.currentSystem!.visited = true
        galaxy.getSystemsInRange()
        galaxy.updateGalaxy()          // increments days and runs shuffleStatus
        galaxy.updateQuantities()      // reset quantities with time
        
        var travelByWormhole = false
        if oldSystem!.wormhole {
            if galaxy.currentSystem!.name == oldSystem!.wormholeDestination!.name {
                travelByWormhole = true
            }
        }
        if !travelByWormhole && !travelBySingularity {
            player.commanderShip.fuel -= journeyDistance
        }
        
        travelBySingularity = false
        
        // untrack system upon arrival
        //        print("seeing if system needs to be untracked.")
        //        print("trackedSystem: \(galaxy.trackedSystem)")
        if galaxy.currentSystem == galaxy.trackedSystem {
            //            print("arriving at tracked system. Untracking system.")
            galaxy.trackedSystem = nil
        }
        
        galaxy.getSystemsInRange()
        
        // houskeeping things
        player.specialEvents.incrementCountdown()
        
        // fire segue back to sell (or something else later)
        var passedText = NSString(string: "done")
        NSNotificationCenter.defaultCenter().postNotificationName("encounterModalFireNotification", object: passedText)
        
        // increment no-claim
        if player.insurance {
            if player.noClaim < 30 {
                player.noClaim += 1
            }
        }
        
        // flag
        galaxy.journeyJustFinished = true
        
        // if uneventful trip, fire alert
        if uneventfulTrip {
            galaxy.alertsToFireOnArrival.append(AlertID.TravelUneventfulTrip)
        }
        
        // DEBT NOTIFICATIONS
        
        // intermittantly remind player he has debt
        if (player.debt > 0) && (player.days & 3 == 0) && (player.remindLoans) {
            galaxy.alertsToFireOnArrival.append(AlertID.DebtReminder)
        }
        
        // autofuel, if appropriate
        if player.autoFuel {
            let cost = player.commanderShip.costOfFuel
            if cost <= player.credits {
                player.buyMaxFuel()
            } else {
                // too broke message
                galaxy.alertsToFireOnArrival.append(AlertID.ArrivalIFFuel)
            }
        }
        
        // auto repair, if appropriate
        if player.autoRepair {
            let cost = player.commanderShip.repairCosts
            if cost <= player.credits {
                player.buyMaxRepairs()
            } else {
                // too broke message
                galaxy.alertsToFireOnArrival.append(AlertID.ArrivalIFRepairs)
            }
        }
        
        // auto buy newspaper, if appropriate
        if player.autoNewspaper {
            let cost = galaxy.currentSystem!.costOfNewspaper
            if cost <= player.credits {
                galaxy.currentSystem!.newspaper.generatePaper()
                player.alreadyPaidForNewspaper = true
            } else {
                // too broke message
                galaxy.alertsToFireOnArrival.append(AlertID.ArrivalIFNewspaper)
            }
        }
    }
    
    //    func generateEncounters() {         // OLD, but with useful code
    //
    //
    //        // handle possibility of spacetime rip
    //
    //        while clicks > 0 {
    //
    //        }
    //
    //        // arrive
    //        if uneventfulTrip {
    //            print("After an uneventful trip, you arrive at your destination")
    //            uneventfulTrip = true
    //        } else {
    //            print("Arrival alert goes here.")
    //        }
    //
    //        if player.debt > 75000 {
    //            print("LARGE DEBT WARNING")
    //        }
    //
    //        if player.debt > 0 && player.remindLoans && (player.days % 5 == 0) {
    //            print("LOAN REMINDER")
    //        }
    //
    //        // if arrived at tracked system, set tracked system to nil
    //
    //        // autofuel & autorepair
    //
    //        // Og system lightning shield easter egg?
    //    }
    
    // NSCODING METHODS
    
    required init(coder decoder: NSCoder) {
        self.origin = decoder.decodeObjectForKey("origin") as! StarSystem
        self.destination = decoder.decodeObjectForKey("destination") as! StarSystem
        self.clicks = decoder.decodeObjectForKey("clicks") as! Int
        self.pirate = decoder.decodeObjectForKey("pirate") as! Bool
        self.police = decoder.decodeObjectForKey("police") as! Bool
        self.trader = decoder.decodeObjectForKey("trader") as! Bool
        self.mantis = decoder.decodeObjectForKey("mantis") as! Bool
        self.currentEncounter = decoder.decodeObjectForKey("currentEncounter") as! Encounter?
        self.localPolitics = decoder.decodeObjectForKey("localPolitics") as! Politics
        self.strengthPirates = decoder.decodeObjectForKey("strengthPirates") as! Int
        self.strengthPolice = decoder.decodeObjectForKey("strengthPolice") as! Int
        self.strengthTraders = decoder.decodeObjectForKey("strengthTraders") as! Int
        self.uneventfulTrip = decoder.decodeObjectForKey("uneventfulTrip") as! Bool
        
        super.init()
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(origin, forKey: "origin")
        encoder.encodeObject(destination, forKey: "destination")
        encoder.encodeObject(clicks, forKey: "clicks")
        encoder.encodeObject(pirate, forKey: "pirate")
        encoder.encodeObject(police, forKey: "police")
        encoder.encodeObject(trader, forKey: "trader")
        encoder.encodeObject(mantis, forKey: "mantis")
        encoder.encodeObject(currentEncounter, forKey: "currentEncounter")
        encoder.encodeObject(localPolitics, forKey: "localPolitics")
        encoder.encodeObject(strengthPirates, forKey: "strengthPirates")
        encoder.encodeObject(strengthPolice, forKey: "strengthPolice")
        encoder.encodeObject(strengthTraders, forKey: "strengthTraders")
        encoder.encodeObject(uneventfulTrip, forKey: "uneventfulTrip")
    }
}