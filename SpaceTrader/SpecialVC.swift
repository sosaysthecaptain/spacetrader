//
//  SpecialVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/3/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class SpecialVC: UIViewController {

    @IBOutlet weak var specialEventTitle: UILabel!
    @IBOutlet weak var specialEventText: UITextView!
    @IBOutlet weak var dismissButtonOutlet: PurpleButtonVanishes!
    @IBOutlet weak var noButtonOutlet: PurpleButtonVanishes!
    
    override func viewDidLoad() {
        // DEBUG
        print("special screen invoked. Special event to load: \(galaxy.currentSystem!.specialEvent)")
        print("title: \(player.specialEvents.specialEventTitle)")
        
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        if player.specialEvents.special {
//            // set font, which apparently we have to do here
//            specialEventText.font = UIFont(name: "AvenirNext-DemiBold", size: 14)!
            
            print("SpecialVC reporting in. specialEventID: \(galaxy.currentSystem!.specialEvent)")
            print("title, from player.specialEvents: \(player.specialEvents.specialEventTitle)")
            
            specialEventTitle.text = player.specialEvents.specialEventTitle
            specialEventText.text = player.specialEvents.specialEventText
            
            // set button texts
            let controlState = UIControlState()
            dismissButtonOutlet.setTitle(player.specialEvents.yesDismissButtonText, for: controlState)
            noButtonOutlet.setTitle(player.specialEvents.noButtonText, for: controlState)
            
            dismissButtonOutlet.isEnabled = player.specialEvents.yesDismissButtonEnabled
            noButtonOutlet.isEnabled = player.specialEvents.noButtonEnabled
        }
    }

    @IBAction func dismissButton(_ sender: AnyObject) {
        // NEW WAY--entire functionality goes here, no further callback to SpecialEvent
        // TODO
        switch galaxy.currentSystem!.specialEvent! {
            // initial
            case SpecialEventID.alienArtifact:
                if player.commanderShip.baysAvailable >= 1 {
                    player.specialEvents.addQuestString("Deliver the alien artifact to Professor Berger at some hi-tech system.", ID: QuestID.artifact)
                    player.commanderShip.artifactSpecialCargo = true
                    // add artifact delivery to some high tech system without a specialEvent set
                    for planet in galaxy.planets {
                        if planet.techLevel == TechLevelType.techLevel7 {
                            if planet.specialEvent == nil {
                                galaxy.setSpecial(planet.name, id: SpecialEventID.artifactDelivery)
                                print("artifact is on \(planet.name)")
                                break
                            }
                        }
                    }
                    player.specialEvents.artifactOnBoard = true         // one of these is redundant
                    generateAlert(Alert(ID: AlertID.artifactOnBoard, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialNotEnoughBays, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            
                
            case SpecialEventID.dragonfly:
                player.specialEvents.addQuestString("Follow the Dragonfly to Baratas.", ID: QuestID.dragonfly)
                galaxy.setSpecial("Baratas", id: SpecialEventID.dragonflyBaratas)
                closeSpecialVC()
                
            case SpecialEventID.dangerousExperiment:
                player.specialEvents.experimentCountdown = 10
                player.specialEvents.addQuestString("Stop Dr. Fehler's experiment at Daled within \(player.specialEvents.experimentCountdown) days.", ID: QuestID.experiment)
                galaxy.setSpecial("Daled", id: SpecialEventID.disasterAverted)
                closeSpecialVC()
                
            case SpecialEventID.gemulonInvasion:
                player.specialEvents.gemulonInvasionCountdown = 7
                player.specialEvents.addQuestString("Inform Gemulon about alien invasion within \(player.specialEvents.gemulonInvasionCountdown) days.", ID: QuestID.gemulon)
                galaxy.setSpecial("Gemulon", id: SpecialEventID.gemulonRescued)
                closeSpecialVC()
                
            case SpecialEventID.japoriDisease:
                // player can accept quest only if ship has 10 bays free
                if player.commanderShip.baysAvailable >= 10 {
                    // quest
                    player.specialEvents.addQuestString("Deliver antidote to Japori.", ID: QuestID.japori)
                    // create new special in Japori--medicineDelivery
                    galaxy.setSpecial("Japori", id: SpecialEventID.medicineDelivery)
                    player.commanderShip.japoriSpecialCargo = true
                    generateAlert(Alert(ID: AlertID.antidoteOnBoard, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialNotEnoughBays, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
                
                
            case SpecialEventID.ambassadorJarek:
                
                
                player.specialEvents.jarekElapsedTime = 0
                player.specialEvents.addQuestString("Take ambassador Jarek to Devidia.", ID: QuestID.jarek)
                galaxy.setSpecial("Devidia", id: SpecialEventID.jarekGetsOut)
                
                if player.commanderShip.crewSlotsAvailable >= 1 {
                    // take him on
                    let jarek = CrewMember(ID: MercenaryName.jarek, pilot: 3, fighter: 1, trader: 10, engineer: 2)
                    player.commanderShip.crew.append(jarek)
                    generateAlert(Alert(ID: AlertID.jarekOnBoard, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    // can't take him on
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialNoQuarters, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.princess:
                player.specialEvents.addQuestString("Follow the Scorpion to Centauri.", ID: QuestID.princess)
                galaxy.setSpecial("Centauri", id: SpecialEventID.princessCentauri)
                closeSpecialVC()
                
            case SpecialEventID.moonForSale:
                if player.credits >= 500000 {
                    // go for it
                    player.credits -= 500000
                    player.specialEvents.addQuestString("Claim your moon at Utopia.", ID: QuestID.moon)
                    galaxy.setSpecial("Utopia", id: SpecialEventID.retirement)
                } else {
                    // too poor message                                         ALERT
                    generateAlert(Alert(ID: AlertID.tooPoorToBuyMoon, passedString1: nil, passedString2: nil, passedString3: nil))
                    // put back special
                    galaxy.setSpecial(galaxy.currentSystem!.name, id: SpecialEventID.moonForSale)
                    dontDeleteLocalSpecialEvent = true
                }
                
                
                
            case SpecialEventID.morgansReactor:
                
                // add special cargo        FIX
                if player.commanderShip.baysAvailable >= 10 {
                    // quest
                    player.specialEvents.addQuestString("Deliver the unstable reactor to Nix for Henry Morgan.", ID: QuestID.reactor)
                    player.specialEvents.reactorElapsedTime = 0
                    galaxy.setSpecial("Nix", id: SpecialEventID.reactorDelivered)
                    player.commanderShip.reactorSpecialCargo = true
                    player.commanderShip.reactorFuelSpecialCargo = true
                    player.commanderShip.reactorFuelBays = 10

                    // ReactorOnBoard alert; close on dismiss
                    generateAlert(Alert(ID: AlertID.reactorOnBoard, passedString1: nil, passedString2: nil, passedString3: nil))
                    
                } else {
                    // if bays not free, don't delete, create alert
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialNotEnoughBays, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.scarabStolen:
                player.specialEvents.addQuestString("Find and destroy the Scarab (which is hiding at the exit to a wormhole).", ID: QuestID.scarab)
                // add scarab to some planet with a wormhole
                for planet in galaxy.planets {
                    if (planet.wormhole == true) && (planet.specialEvent == nil) {
                        planet.scarabIsHere = true
                        print("scarab is at \(planet.name)")
                        break
                    }
                }
                closeSpecialVC()
                
                
            case SpecialEventID.sculpture:
                player.specialEvents.addQuestString("Deliver the stolen sculpture to Endor.", ID: QuestID.sculpture)
                galaxy.setSpecial("Endor", id: SpecialEventID.sculptureDelivered)
                player.commanderShip.sculptureSpecialCargo = true
                closeSpecialVC()
                
            case SpecialEventID.spaceMonster:
                player.specialEvents.addQuestString("Kill the space monster at Acamar.", ID: QuestID.spaceMonster)
                for planet in galaxy.planets {
                    if planet.name == "Acamar" {
                        planet.spaceMonsterIsHere = true
                    }
                }
                closeSpecialVC()
                
            case SpecialEventID.wild:
                var shipHasBeamLaser = false
                for weapon in player.commanderShip.weapon {
                    if weapon.type == WeaponType.beamLaser || weapon.type == WeaponType.morgansLaser || weapon.type == WeaponType.militaryLaser {
                        shipHasBeamLaser = true
                    }
                }
                
                if player.commanderShip.crewSlotsAvailable < 1 {
                    // no quarters
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialNoQuarters, passedString1: nil, passedString2: nil, passedString3: nil))
                } else if !shipHasBeamLaser {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.wildWontBoardLaser, passedString1: nil, passedString2: nil, passedString3: nil))
                } else if player.commanderShip.reactorSpecialCargo {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.wildWontBoardReactor, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    // wild comes aboard
                    player.specialEvents.wildOnBoard = true
                    player.specialEvents.wildElapsedTime = 0
                    player.specialEvents.addQuestString("Smuggle Jonathan Wild to Kravat", ID: QuestID.wild)
                    galaxy.setSpecial("Kravat", id: SpecialEventID.wildGetsOut)
                    // add wild to crew
                    let wild = CrewMember(ID: MercenaryName.wild, pilot: 8, fighter: 10, trader: 4, engineer: 5)
                    wild.costPerDay = 0
                    player.commanderShip.crew.append(wild)
                    player.specialEvents.wildOnBoard = true
                    
                    generateAlert(Alert(ID: AlertID.wildComesAboard, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.merchantPrice:
                if player.credits < 1000 {
                    // can't do it
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialIF, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    player.credits -= 1000
                    player.commanderShip.tribbles = 1
                    player.specialEvents.tribblesOnBoard = true
                    player.specialEvents.addQuestString("Get rid of those pesky tribbles.", ID: QuestID.tribbles)
                    for planet in galaxy.planets {
                        if planet.specialEvent == nil {
                            let random = rand(20)
                            if random == 6 {
                                planet.specialEvent = SpecialEventID.tribbleBuyer
                                print("tribbleBuyer assigned to \(planet.name)")
                                break
                            }
                            
                        }
                    }
                    generateAlert(Alert(ID: AlertID.tribblesOwn, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            
                
            case SpecialEventID.eraseRecord:
                if player.credits >= 5000 {
                    player.policeRecord = PoliceRecordType.cleanScore
                    player.credits -= 5000
                    generateAlert(Alert(ID: AlertID.specialCleanRecord, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.specialIF, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
                
            case SpecialEventID.lotteryWinner:
                player.credits += 1000
                closeSpecialVC()
                
            case SpecialEventID.skillIncrease:
                if player.credits >= 3000 {
                    player.credits -= 3000
                    player.specialEvents.increaseRandomSkill()
                    generateAlert(Alert(ID: AlertID.specialSkillIncrease, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    generateAlert(Alert(ID: AlertID.specialIF, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.cargoForSale:
                if player.credits >= 1000 {
                    if player.commanderShip.cargoBays >= 3 {
                        player.credits -= 1000
                        player.specialEvents.addRandomCargo()
                        generateAlert(Alert(ID: AlertID.specialSealedCanisters, passedString1: nil, passedString2: nil, passedString3: nil))
                    } else {
                        generateAlert(Alert(ID: AlertID.specialNotEnoughBays, passedString1: nil, passedString2: nil, passedString3: nil))
                    }
                } else {
                    generateAlert(Alert(ID: AlertID.specialIF, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
                // subsequent
            case SpecialEventID.artifactDelivery:
                player.specialEvents.artifactOnBoard = false
                player.commanderShip.artifactSpecialCargo = false
                player.credits += 20000
                player.specialEvents.addQuestString("", ID: QuestID.artifact)        // close quest
                closeSpecialVC()
                
            case SpecialEventID.dragonflyBaratas:
                player.specialEvents.addQuestString("Follow the Dragonfly to Melina.", ID: QuestID.dragonfly)
                galaxy.setSpecial("Melina", id: SpecialEventID.dragonflyMelina)
                closeSpecialVC()
                
            case SpecialEventID.dragonflyMelina:
                player.specialEvents.addQuestString("Follow the Dragonfly to Regulas", ID: QuestID.dragonfly)
                galaxy.setSpecial("Regulas", id: SpecialEventID.dragonflyRegulas)
                closeSpecialVC()
                
            case SpecialEventID.dragonflyRegulas:
                player.specialEvents.addQuestString("Follow the Dragonfly to Zalkon.", ID: QuestID.dragonfly)
                for planet in galaxy.planets {
                    if planet.name == "Zalkon" {
                        planet.dragonflyIsHere = true
                    }
                }
                closeSpecialVC()
                // no new special. Will be added at Zalkon when dragonfly is destroyed
                
            case SpecialEventID.dragonflyDestroyed:
                player.specialEvents.addQuestString("Get your lightning shield at Zalkon.", ID: QuestID.dragonfly)
                galaxy.setSpecial("Zalkon", id: SpecialEventID.lightningShield)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.lightningShield:
                if player.commanderShip.shield.count < player.commanderShip.shieldSlots {
                    // add shield
                    player.commanderShip.shield.append(Shield(type: ShieldType.lightningShield))
                    player.specialEvents.addQuestString("", ID: QuestID.dragonfly)
                    generateAlert(Alert(ID: AlertID.equipmentLightningShield, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    galaxy.setSpecial("Zalkon", id: SpecialEventID.lightningShield)
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.equipmentNotEnoughSlots, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.disasterAverted:
                player.specialEvents.experimentCountdown = -1
                player.portableSingularity = true
                player.specialEvents.addQuestString("", ID: QuestID.experiment)
                closeSpecialVC()
                
            case SpecialEventID.experimentFailed:
                player.specialEvents.addQuestString("", ID: QuestID.experiment)
                // spacetime was already messed up when the timer expired
                closeSpecialVC()
                
            case SpecialEventID.gemulonInvaded:
                // aliens already appeared when timer expired
                player.specialEvents.addQuestString("", ID: QuestID.gemulon)
                closeSpecialVC()
                
            case SpecialEventID.gemulonRescued:
                player.specialEvents.gemulonInvasionCountdown = -1   // deactivate countdown
                player.specialEvents.addQuestString("", ID: QuestID.gemulon)
                galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.fuelCompactor:
                if player.commanderShip.gadget.count < player.commanderShip.gadgetSlots {
                    // add gadget
                    player.commanderShip.gadget.append(Gadget(type: GadgetType.fuelCompactor))
                    player.specialEvents.addQuestString("", ID: QuestID.dragonfly)
                    generateAlert(Alert(ID: AlertID.equipmentFuelCompactor, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.equipmentNotEnoughSlots, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.medicineDelivery:
                player.commanderShip.japoriSpecialCargo = false     // remove special cargo
                player.specialEvents.addQuestString("", ID: QuestID.japori)
                player.specialEvents.increaseRandomSkill()
                generateAlert(Alert(ID: AlertID.specialSkillIncrease, passedString1: nil, passedString2: nil, passedString3: nil))
                
            case SpecialEventID.jarekGetsOut:
                // remove jarek
                player.commanderShip.removeCrewMember(MercenaryName.jarek)
                // stop countdown, remove quest string
                player.specialEvents.jarekElapsedTime = -1
                player.specialEvents.addQuestString("", ID: QuestID.jarek)
                
                player.commanderShip.jarekHagglingComputerSpecialCargo = true
                generateAlert(Alert(ID: AlertID.hagglingComputer, passedString1: nil, passedString2: nil, passedString3: nil))
                
            case SpecialEventID.princessCentauri:
                player.specialEvents.addQuestString("Follow the Scorpion to Inthara.", ID: QuestID.princess)
                galaxy.setSpecial("Inthara", id: SpecialEventID.princessInthara)
                closeSpecialVC()
                
            case SpecialEventID.princessInthara:
                player.specialEvents.addQuestString("Follow the Scorpion to Qonos.", ID: QuestID.princess)
                for planet in galaxy.planets {
                    if planet.name == "Qonos" {
                        planet.scorpionIsHere = true
                    }
                }
                closeSpecialVC()
                // upon defeat of the scorpion, SpecialEventID.princessQonos will be added
                
            case SpecialEventID.princessRescued:
                player.specialEvents.addQuestString("Give the Princess a ride home.", ID: QuestID.princess)
                galaxy.setSpecial("Qonos", id: SpecialEventID.princessQonos)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
        
            case SpecialEventID.princessQonos:
                if player.commanderShip.crewSlotsAvailable > 0 {
                    player.specialEvents.addQuestString("Transport Ziyal from Qonos to Galvon.", ID: QuestID.princess)
                    galaxy.setSpecial("Galvon", id: SpecialEventID.princessReturned)
                    // add Ziyal to crew
                    let ziyal = CrewMember(ID: MercenaryName.ziyal, pilot: 4, fighter: 3, trader: 8, engineer: 9)
                    player.commanderShip.crew.append(ziyal)
                    generateAlert(Alert(ID: AlertID.princessComesAboard, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    generateAlert(Alert(ID: AlertID.specialNoQuarters, passedString1: nil, passedString2: nil, passedString3: nil))
                }
            
            case SpecialEventID.princessReturned:
                player.specialEvents.princessElapsedTime = -1
                player.commanderShip.removeCrewMember(MercenaryName.ziyal)
                player.specialEvents.addQuestString("Get your Quantum Disruptor at Galvon.", ID: QuestID.princess)
                galaxy.setSpecial("Galvon", id: SpecialEventID.installQuantumDisruptor)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.installQuantumDisruptor:
                if player.commanderShip.weapon.count < player.commanderShip.weaponSlots {
                    // add disruptor
                    player.commanderShip.weapon.append(Weapon(type: WeaponType.quantumDisruptor))
                    player.specialEvents.addQuestString("", ID: QuestID.princess)
                    generateAlert(Alert(ID: AlertID.equipmentQuantumDisruptor, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.equipmentNotEnoughSlots, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.retirement:
                //print("pushed yes on retire screen")
                player.specialEvents.addQuestString("", ID: QuestID.moon)
                // end game
                var ziyal = false
                for crewMember in player.commanderShip.crew {
                    if crewMember.name == "Ziyal" {
                        ziyal = true
                    }
                }
                if ziyal {
                    player.endGameType = EndGameStatus.boughtMoonGirl
                } else {
                    player.endGameType = EndGameStatus.boughtMoon
                }
                gameOver()
                
            case SpecialEventID.reactorDelivered:
                player.specialEvents.reactorElapsedTime = -1
                player.specialEvents.addQuestString("Get your special laser at Nix.", ID: QuestID.reactor)
                // remove reactor
                player.commanderShip.reactorSpecialCargo = false
                player.commanderShip.reactorFuelSpecialCargo = false
                player.commanderShip.reactorFuelBays = 0
                
                galaxy.setSpecial("Nix", id: SpecialEventID.installMorgansLaser)
                print("special is now \(galaxy.currentSystem!.specialEvent!)")
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.installMorgansLaser:
                if player.commanderShip.weapon.count < player.commanderShip.weaponSlots {
                    // add laser
                    player.commanderShip.weapon.append(Weapon(type: WeaponType.morgansLaser))
                    player.specialEvents.addQuestString("", ID: QuestID.reactor)
                    generateAlert(Alert(ID: AlertID.equipmentMorgansLaser, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    generateAlert(Alert(ID: AlertID.equipmentNotEnoughSlots, passedString1: nil, passedString2: nil, passedString3: nil))
                    galaxy.setSpecial("Nix", id: SpecialEventID.installMorgansLaser)
                    dontDeleteLocalSpecialEvent = true
                }
                
            case SpecialEventID.scarabDestroyed:
                player.specialEvents.addQuestString("Get your hull upgraded at \(galaxy.currentSystem!.name)", ID: QuestID.scarab)
                galaxy.setSpecial("\(galaxy.currentSystem!.name)", id: SpecialEventID.upgradeHull)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.upgradeHull:
                player.commanderShip.hullStrength += 150    // hopefully this is the best way to do this?
                player.specialEvents.addQuestString("", ID: QuestID.scarab)
                // add special cargo
                player.commanderShip.upgradedHull = true
                player.days += 1
                generateAlert(Alert(ID: AlertID.shipHullUpgraded, passedString1: nil, passedString2: nil, passedString3: nil))
                
            case SpecialEventID.sculptureDelivered:
                player.commanderShip.sculptureSpecialCargo = false
                player.specialEvents.addQuestString("Have hidden compartments installed at Endor.", ID: QuestID.sculpture)
                galaxy.setSpecial("Endor", id: SpecialEventID.installHiddenCompartments)
                dontDeleteLocalSpecialEvent = true
                closeSpecialVC()
                
            case SpecialEventID.installHiddenCompartments:
                if player.commanderShip.gadget.count < player.commanderShip.gadgetSlots {
                    // add gadget
                    player.commanderShip.gadget.append(Gadget(type: GadgetType.hBays))
                    player.specialEvents.addQuestString("", ID: QuestID.dragonfly)
                    generateAlert(Alert(ID: AlertID.equipmentHiddenCompartments, passedString1: nil, passedString2: nil, passedString3: nil))
                } else {
                    galaxy.setSpecial("Endor", id: SpecialEventID.sculpture)
                    dontDeleteLocalSpecialEvent = true
                    generateAlert(Alert(ID: AlertID.equipmentNotEnoughSlots, passedString1: nil, passedString2: nil, passedString3: nil))
                }
                
            case SpecialEventID.monsterKilled:
                player.specialEvents.addQuestString("", ID: QuestID.spaceMonster)
                player.credits += 15000
                closeSpecialVC()
                
            case SpecialEventID.wildGetsOut:
                player.specialEvents.addQuestString("", ID: QuestID.wild)
                player.specialEvents.wildOnBoard = false
                player.commanderShip.removeCrewMember(MercenaryName.wild)
                player.specialEvents.wildElapsedTime = -1
                
                let zeethibal = CrewMember(ID: MercenaryName.zeethibal, pilot: 9, fighter: 9, trader: 9, engineer: 9)
                zeethibal.costPerDay = 0
                galaxy.currentSystem!.mercenaries.append(zeethibal)
                // alert: Zeethibal available for hire
                generateAlert(Alert(ID: AlertID.wildZeethibalAvailable, passedString1: nil, passedString2: nil, passedString3: nil))
                
            case SpecialEventID.tribbleBuyer:
                player.specialEvents.addQuestString("", ID: QuestID.tribbles)
                player.commanderShip.tribbles = 0
                player.specialEvents.tribblesOnBoard = false
                player.credits += Int(Double(player.commanderShip.tribbles) * 0.5)
                generateAlert(Alert(ID: AlertID.tribblesGone, passedString1: nil, passedString2: nil, passedString3: nil))
            
        }
        // END yesDismiss FUNCTIONALITY*************************************************************
        
        // OLD WAY--call relevant function in SpecialEvent
        //player.specialEvents.yesDismissButton()
        
        // dismiss and remove special. No button will not remove special, that can be done manually in SpecialEvent
    }
    
    func closeSpecialVC() {
        if player.endGameType == EndGameStatus.gameNotOver {
            self.dismiss(animated: true, completion: nil)
        }
        
        // spare special event if dontDeleteLocalSpecialEvent flag is true
        if !dontDeleteLocalSpecialEvent {
            print("flag not set, deleting special event")
            galaxy.currentSystem!.specialEvent = nil
            player.specialEvents.special = false
        } else {
            print("not deleting special event, as per flag")
            // spare special event. It has been reset to something else, like claim item
            
            // make sure button points to correct special
        }
        dontDeleteLocalSpecialEvent = false
    }

    @IBAction func noButton(_ sender: AnyObject) {
        // for now, I'm going to assume that this will be unnecessary. Maybe I can change the text on it, but I think it will just dismiss the window without taking away the special?
        print("NO BUTTON PRESSED. Should now dismiss and do nothing more.")
        self.dismiss(animated: true, completion: nil)
    }
    
    func gameOver() {
        print("this is the gameOver method in special")
        //performSegueWithIdentifier("gameOverFromSpecial", sender: nil)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "gameOverVC")
        self.present(vc, animated: false, completion: nil)
        
        // this goes to a blank, test VC
//        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("testGameOver")
//        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    func generateAlert(_ alert: Alert) {
        // this is the new version. It's functionality is completely contained within the VC
        
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // if yes pressed, return true
            self.closeSpecialVC()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
