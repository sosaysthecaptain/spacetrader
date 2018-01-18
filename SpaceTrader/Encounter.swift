//
//  Encounter.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/13/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation

class Encounter: NSObject, NSCoding {
    var type: EncounterType
    let opponent: Opponent
    let clicks: Int
    var encounterText1 = ""
    var encounterText2 = ""
    var button1Text = "button1"
    var button2Text = "button2"
    var button3Text = "button3"
    var button4Text = "button4"

    var alertTitle = ""
    var alertText = ""
    
    var opponentFleeing = false
    var playerFleeing = false
    
    var pilotSkillOpponent: Int = 0
    var fighterSkillOpponent: Int = 0
    var traderSkillOpponent: Int = 0
    var engineerSkillOpponent: Int = 0
    
    var youHitThem = false
    var theyHitYou = false
    
    var scoopableItem: TradeItem?
    
    var warnedYet = false
    
    // thing to call opposing vessel, settable by IFF
    // options:
    var opposingVessel: String {
        get {
            switch opponent.ship.IFFStatus {
                case IFFStatusType.Pirate:
                    return "pirate ship"
                case IFFStatusType.Police:
                    return "police ship"
                case IFFStatusType.Trader:
                    return "trader ship"
                case IFFStatusType.Dragonfly:
                    return "Dragonfly"
                case IFFStatusType.Mantis:
                    return "Mantis"
                case IFFStatusType.Scarab:
                    return "Scarab"
                case IFFStatusType.SpaceMonster:
                    return "Space Monster"
                case IFFStatusType.Scorpion:
                    return "Scorpion"
                case IFFStatusType.FamousCaptain:
                    return "Wasp"
                default:
                    return ""
            }
        }
    }
    
    var modalToCall = "main"
    
    init(type: EncounterType, clicks: Int) {
        self.type = type
        self.clicks = clicks
        
        let IFF = getIFFStatusTypeforEncounterType(type)
        
        // generate opponent
        opponent = Opponent(type: IFF)
        opponent.generateOpponent()
        
        pilotSkillOpponent = max(opponent.commander.pilotSkill, opponent.ship.maxCrewPilotSkill)
        fighterSkillOpponent = max(opponent.commander.fighterSkill, opponent.ship.maxCrewFighterSkill)
        traderSkillOpponent = max(opponent.commander.traderSkill, opponent.ship.maxCrewTraderSkill)
        engineerSkillOpponent = max(opponent.commander.engineerSkill, opponent.ship.maxCrewEngineerSkill)
        
        for crewMember in opponent.ship.crew {
            if crewMember.pilot > pilotSkillOpponent {
                pilotSkillOpponent = crewMember.pilot
            }
            if crewMember.fighter > fighterSkillOpponent {
                fighterSkillOpponent = crewMember.fighter
            }
            if crewMember.trader > traderSkillOpponent {
                traderSkillOpponent = crewMember.trader
            }
            if crewMember.engineer > engineerSkillOpponent {
                engineerSkillOpponent = crewMember.engineer
            }
        }
        
        // kludge override
        if opponent.ship.type == ShipType.scarab {
            pilotSkillOpponent = 7
            fighterSkillOpponent = 7
        } else if opponent.ship.type == ShipType.dragonfly {
            pilotSkillOpponent = 7
            fighterSkillOpponent = 7
        }
    }
    
    func beginEncounter() {
        
        // if this is null, skip right to the end
        if type == EncounterType.nullEncounter {
            concludeEncounter()
        }
        print(" ")
        print("***MATCH REPORT***")
        print("OPPONENT: \(opponent.ship.name)")
        print("  opponent pilot: \(pilotSkillOpponent)")
        print("  opponent fighter: \(fighterSkillOpponent)")
        print("  opponent totalShield: \(opponent.ship.totalShields)")
        print("  opponent hull: \(opponent.ship.hull)")
        print("  opponent total weapons: \(opponent.ship.totalWeapons)")

        print("PLAYER:")
        print("  player pilot: \(player.pilotSkill)")
        print("  player fighter: \(player.fighterSkill)")
        print("  player totalShield: \(player.commanderShip.totalShields)")
        print("  player hull: \(player.commanderShip.hull)")
        print("  player total weapons: \(player.commanderShip.totalWeapons)")
        
        
        setEncounterTextAndButtons()
        fireModal()
    }
    
    
    func concludeEncounter() {
        galaxy.currentJourney!.resumeJourney()
    }
    
    func getBounty() -> Int {
        var bounty = opponent.ship.price / 200
        if bounty <= 0 {
            bounty = 25
        } else if bounty > 2500 {
            bounty = 2500
        }
        return bounty
    }
    
    func setEncounterTextAndButtons() {                 // should only be used initially
        if type == EncounterType.pirateAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Surrender"
            button4Text = ""
            
            encounterText2 = "The pirate ship attacks."

        } else if type == EncounterType.pirateSurrender {
            button1Text = "Attack"
            button2Text = "Plunder"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "Your opponent hails that he surrenders to you."

        } else if type == EncounterType.pirateIgnore {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "It ignores you."

        } else if type == EncounterType.pirateFlee {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "Your opponent is fleeing."

        } else if type == EncounterType.policeInspection {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Submit"
            button4Text = "Bribe"
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "The police summon you to submit to an inspection."

        } else if type == EncounterType.policeFlee {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "Your opponent is fleeing."

        } else if type == EncounterType.policeAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Surrender"
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "The police ship attacks."

        } else if type == EncounterType.policeIgnore {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "It ignores you."

        } else if type == EncounterType.policeSurrenderDemand {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Surrender"
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "The police hail that they want you to surrender."

        } else if type == EncounterType.postMariePoliceEncounter {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Yield"
            button4Text = "Bribe"
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "We know you removed illegal goods from the Marie Celeste. You must give them up at once!"

        } else if type == EncounterType.pirateIgnore {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "It ignores you."

        } else if type == EncounterType.pirateFlee {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "Your opponent is fleeing."

        } else if type == EncounterType.marieCelesteEncounter {
            button1Text = "Board"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the a trader ship, the Marie Celeste"
            encounterText2 = "The Marie Celeste appears to be completely abandoned."
        } else if type == EncounterType.traderBuy {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Trade"
            button4Text = ""
            
            encounterText2 = "You are hailed with an offer to trade goods."
            
        } else if type == EncounterType.traderSell {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Trade"
            button4Text = ""
            
            encounterText2 = "You are hailed with an offer to trade goods."
        } else if type == EncounterType.traderIgnore {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText2 = "It ignores you."
        } else if type == EncounterType.traderFlee {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText2 = "The trader ship is fleeing."
            
            encounterText2 = "Your opponent is fleeing."
        } else if type == EncounterType.traderSurrender {
            button1Text = "Attack"
            button2Text = "Plunder"
            button3Text = ""
            button4Text = ""
            
            encounterText2 = "Your opponent hails that he surrenders to you."
        } else if type == EncounterType.traderAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = ""
            button4Text = ""
            
            encounterText2 = "The trader ship attacks."
        } else if type == EncounterType.scarabAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the Scarab."
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.famousCapAttack {
            button1Text = ""
            button2Text = ""
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "THIS IS ATTACK. REPLACE THIS."
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.spaceMonsterAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "" 
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the Space Monster."
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.dragonflyAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the Dragonfly."
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.spaceMonsterIgnore {
            button1Text = ""
            button2Text = ""
            button3Text = ""
            button4Text = ""
            
            encounterText1 = ""
            encounterText2 = "It ignores you."
        } else if type == EncounterType.dragonflyIgnore {
            button1Text = ""
            button2Text = ""
            button3Text = ""
            button4Text = ""
            
            encounterText1 = ""
            encounterText2 = "It ignores you."
        } else if type == EncounterType.scarabIgnore {
            button1Text = ""
            button2Text = ""
            button3Text = ""
            button4Text = ""
            
            encounterText1 = ""
            encounterText2 = "It ignores you."
        } else if type == EncounterType.bottleGoodEncounter {
            button1Text = "Pick It Up"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a drifting bottle."
            encounterText2 = "It appears to be a rare bottle of Captain Marmoset's Skill Tonic!"
        } else if type == EncounterType.bottleOldEncounter {
            button1Text = "Pick It Up"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a drifting bottle."
            encounterText2 = "It appears to be a rare bottle of Captain Marmoset's Skill Tonic!"
        } else if type == EncounterType.mantisAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Surrender"
            button4Text = ""
            
            encounterText1 = ""
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.scorpionAttack {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the Scorpion."
            encounterText2 = "Your opponent attacks."
        } else if type == EncounterType.famousCaptainAhab {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Accept"
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the famous captain Ahab."
            encounterText2 = "The captain requests a brief meeting with you."
        } else if type == EncounterType.famousCaptainConrad {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Accept"
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the famous captain Conrad."
            encounterText2 = "The captain requests a brief meeting with you."
        } else if type == EncounterType.famousCaptainHuie {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Accept"
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter the famous captain Huie."
            encounterText2 = "The captain requests a brief meeting with you."
        } else if type == EncounterType.policeCloaked {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a police \(opponent.ship.name)."
            encounterText2 = "It doesn't notice you."
        } else if type == EncounterType.pirateCloaked {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a pirate \(opponent.ship.name)."
            encounterText2 = "It doesn't notice you."
        } else if type == EncounterType.traderCloaked {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
            
            encounterText1 = "At \(clicks) clicks from \(galaxy.targetSystem!.name) you encounter a trader \(opponent.ship.name)."
            encounterText2 = "It doesn't notice you."
        }
    }
    
    func setButtons(_ buttonSet: String) {
        // used for follow up screens, not initially
        // possible strings are: Attack, IgnoreFlee, Surrender, Inspection, PostMarieInspection, MarieCeleste, Trader, AttackNoSurrender
        if buttonSet == "Attack" {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Surrender"
            button4Text = ""
        } else if buttonSet == "IgnoreFlee" {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
        } else if buttonSet == "Surrender" {
            button1Text = "Attack"
            button2Text = "Plunder"
            button3Text = ""
            button4Text = ""
        } else if buttonSet == "Inspection" {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Yield"
            button4Text = "Bribe"
        } else if buttonSet == "PostMarieInspection" {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = "Yield"
            button4Text = "Bribe"
        } else if buttonSet == "MarieCeleste" {
            button1Text = "Board"
            button2Text = "Ignore"
            button3Text = ""
            button4Text = ""
        } else if buttonSet == "Trader" {
            button1Text = "Attack"
            button2Text = "Ignore"
            button3Text = "Trade"
            button4Text = ""
        } else if buttonSet == "AttackNoSurrender" {
            button1Text = "Attack"
            button2Text = "Flee"
            button3Text = ""
            button4Text = ""
        } else {
//            print("buttonSet not recognized")
        }
    }
    
    func fireModal() {          // LAUNCHES AN ENCOUNTER VIEW
        
        var passedText = NSString(string: "")
        if modalToCall == "main" {
            passedText = NSString(string: "main")
        } else if modalToCall == "notification" {
            passedText = NSString(string: "notification")
        }

        //print("FIREMODAL CALLING NOTIFICATIONCENTER NOW")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterModalFireNotification"), object: passedText)
    }
    
    func attack() -> String {
        //print("player's weapon power: \(player.commanderShip.totalWeapons)")
        //print("opponent's weapon power: \(opponent.ship.totalWeapons)")
        
        var outcome = ""
        
        // if opponent is fleeing, harder to hit them
        var opponentFleeingMarksmanshipPenalty = 0
        if opponentFleeing {
            opponentFleeingMarksmanshipPenalty = 2
        }
        
        // player shoots at target. Determine if hit...
        if rand(player.fighterSkill) + opponent.ship.probabilityOfHit > rand(pilotSkillOpponent) + opponentFleeingMarksmanshipPenalty {
            youHitThem = true
            
            // opponent is hit. Determine damage.    MAYBE IF OPPONENT DISABLED, DO SOMETHING DIFFERENT?
            let damageToOpponent = rand((player.commanderShip.totalWeapons) * (100 + (2 * engineerSkillOpponent)) / 100)
            damageOpponent(damageToOpponent)
            
            // PHOTON DISRUPTOR ACTION GOES HERE************************************************
            if opponent.ship.totalShields == 0 && player.commanderShip.photonDisruptor {
                if opponent.ship.type != ShipType.mantis {      // mantises can't be disabled
                    opponent.ship.disabled = true
                }
                
                // quantum disruptor does more?
            }
            
        } else {
            //print("player misses target")
            youHitThem = false
        }
        
        // opponent shoots at player. Determine if hit...
        if !opponentFleeing && !opponent.ship.disabled {
            var playerFleeingMarksmanshipPenalty = 0
            
            if playerFleeing {
                playerFleeingMarksmanshipPenalty = 2
            }
            
            if rand(fighterSkillOpponent) + player.commanderShip.probabilityOfHit > rand(player.pilotSkill) + playerFleeingMarksmanshipPenalty {
                theyHitYou = true
//                print("OPPONENT HITS PLAYER")                                       // REMOVE
                
                // player is hit. Determine damage
//                print("OPPONENT SHIP TOTAL WEAPONS: \(opponent.ship.totalWeapons)") // REMOVE
                let damageToPlayer = rand((opponent.ship.totalWeapons) * (100 + (2 * player.engineerSkill)) / 100)
                damagePlayer(damageToPlayer)
//                print("DAMAGE TO PLAYER: \(damageToPlayer)")                        // REMOVE
            } else {
                theyHitYou = false
            }
        }
        
        // determine outcome
        // default
        outcome = "fightContinues"
        
        
        if outcome == "fightContinues" {
            // if opponent is already fleeing, determine if he gets away
            if opponentFleeing {
                if rand(10) < pilotSkillOpponent + 1 {
                    outcome = "opponentGetsAway"
                }
            }
        }
        
        if outcome == "fightContinues" {        // ADD SURRENDER HERE
            // determine if opponent will flee--maybe do this by opponent type?
            if opponent.ship.hullPercentage < 10 {
                if rand(10) > 3 {
                    opponentFleeing = true
                    outcome = "opponentFlees"
                } else if (rand(10) > 3) && (opponent.ship.IFFStatus != IFFStatusType.Police) {
                    // police shouldn't ever surrender, though they can be disabled
                    outcome = "opponentSurrenders"
                }
            }
        }
        
        if opponent.ship.disabled {
            outcome = "opponentDisabled"
        }
        
        
        // if player is destroyed
        if player.commanderShip.hullPercentage <= 0 {
            if player.escapePod {
//                print("selecting escape pod")
                outcome = "playerDestroyedEscapes"
            } else {
//                print("selecting no escape pod")
                outcome = "playerDestroyedKilled"
            }
        }
        
        // if opponent is destroyed
        if opponent.ship.hullPercentage <= 0 {
            outcome = "opponentDestroyed"
        }
        
        return outcome
    }
    
    func fleeAttack() -> String {
        var outcome = "fightContinues"
        // opponent gets a shot at you while you're fleeing
        
        let playerFleeingMarksmanshipPenalty = 2
        
        if rand(fighterSkillOpponent) + player.commanderShip.probabilityOfHit > rand(player.pilotSkill) + playerFleeingMarksmanshipPenalty {
            theyHitYou = true
            
            // player is hit. Determine damage
            let damageToPlayer = rand((opponent.ship.totalWeapons) * (100 + (2 * player.engineerSkill)) / 100)
            damagePlayer(damageToPlayer)
        } else {
            theyHitYou = false
        }
        
        // handle player getting killed
        if player.commanderShip.hullPercentage <= 0 {
            if player.escapePod {
                outcome = "playerDestroyedEscapes"
            } else {
                outcome = "playerDestroyedKilled"
            }
        } else {
            outcome = "fightContinues"
        }
        
        return outcome
    }
    
    func flee() {
        // determine whether you'll escape
        var escape = false
        if player.difficulty == DifficultyType.beginner {
            escape = true
        } else {
            if ((rand(7) + player.pilotSkill)/3 * 2) >= (rand(opponent.commander.pilotSkill) * (2 + player.difficultyInt)) {
                escape = true
            } else {
                escape = false
            }
        }
        
        
        // display escaped alert
        if escape {
            alertTitle = "Escaped"
            alertText = "You have managed to escape your opponent."
            let stringToPass = NSString(string: "simple")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        } else {
            outcomeOpponentPursues()
        }
    }
    
    func ignore() {
        concludeEncounter()
    }
    
    func plunder() {
//        print("plunder called")
    }
    
    func surrender() {
//        print("surrender called")
    }
    
    func submit() {
        let stringToPass = NSString(string: "submit")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        
    }
    
    func bribe() {
//        print("bribe called")
    }
    
    func trade() {
//        print("trade called")
    }
    
    func board() {
//        print("board called")
    }
    
    func yield() {
//        print("yield called")
    }
    
    func damagePlayer(_ amountOfDamage: Int) {
        // assigns damage appropriately to player.
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
        
        if player.commanderShip.hull <= 0 {
            if player.escapePod {
//                print("redundant killed function")
                //print("ship destroyed. PLAYER HAS ESCAPE POD")
                //outcomePlayerDestroyedEscapes()
            } else {
//                print("redundant killed function")
                //print("ship destroyed. NO ESCAPE POD")
                //outcomePlayerDestroyedKilled()
            }
        }
        
    }
    
    func damageOpponent(_ amountOfDamage: Int) {
        var remainingDamage = amountOfDamage
        if opponent.ship.shield.count != 0 {
            for shield in opponent.ship.shield {
                shield.currentStrength -= remainingDamage
                remainingDamage = 0
                if shield.currentStrength < 0 {
                    remainingDamage = abs(shield.currentStrength)
                    shield.currentStrength = 0
                }
            }
        } else {
            remainingDamage = amountOfDamage
        }
        
        // scarab's hull is only damaged by laser. Adjust remainingDamage accordingly.
        if opponent.type == IFFStatusType.Scarab {
            // if player has pulse laser
            var pulseLaserCount = 0
            for weapon in player.commanderShip.weapon {
                if weapon.type == WeaponType.pulseLaser {
                    pulseLaserCount += 1
                }
            }

            
            // do max 12 damage
            remainingDamage = (12 * pulseLaserCount)
            
        }
        
        // damage opponent's hull
        if opponent.ship.totalShields == 0 {
            opponent.ship.hull -= remainingDamage
        }
        
    }
    
    // OUTCOME FUNCTIONS
    
    func outcomeFightContinues() {
        // report who hit whom
        var reportString1 = ""
        var reportString2 = ""
        if youHitThem {
            reportString1 = "You hit the \(opposingVessel).\n"
        } else {
            reportString1 = "You missed the \(opposingVessel).\n"
        }
        if theyHitYou {
            reportString2 = "The \(opposingVessel) hits you."
        } else {
            reportString2 = "The \(opposingVessel) misses you."
        }
        encounterText1 = reportString1 + reportString2

        switch opponent.ship.IFFStatus {
            case IFFStatusType.Pirate:
                type = EncounterType.pirateAttack
            case IFFStatusType.Police:
                type = EncounterType.policeAttack
            case IFFStatusType.Trader:
                type = EncounterType.policeAttack
            case IFFStatusType.Dragonfly:
                type = EncounterType.dragonflyAttack
            case IFFStatusType.Mantis:
                type = EncounterType.mantisAttack
            case IFFStatusType.Scarab:
                type = EncounterType.scarabAttack
            case IFFStatusType.SpaceMonster:
                type = EncounterType.spaceMonsterAttack
            default:
                type = EncounterType.pirateAttack   // this is a failure mode
        }
        
        let stringToPass = NSString(string: "dismissViewController")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        setEncounterTextAndButtons()
        fireModal()
    }
    
//    func outcomeOpponentGetsAway() {
//        alertTitle = "Opponent Escapes"
//        alertText = "Your opponent has gotten away."
//        let stringToPass = NSString(string: "simple")
//        NSNotificationCenter.defaultCenter().postNotificationName("encounterNotification", object: stringToPass)
//    }
    
    func outcomeOpponentFlees() {
        
    }
    
    func outcomePlayerDestroyedEscapes() {                  // THIS ISN'T OBSOLETE
        // dismiss encounter without triggering the next
        let stringToPass = NSString(string: "dismiss")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        
        // launch call playerDestroyedEscapes sequence in WarpViewVC
        let string = NSString(string: "playerDestroyedEscapes")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterModalFireNotification"), object: string)
    }
    
    func outcomePlayerDestroyedKilled() {
        // obsolete
        
        alertTitle = "You Lose"
        alertText = "Your ship has been destroyed by your opponent."
        
        let stringToPass = NSString(string: "playerKilled")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
    }
    
    func outcomeOpponentDestroyed() {
        if opponent.ship.IFFStatus == IFFStatusType.Pirate {
            player.pirateKills += 1
            // pirate ships get their own special function, as there is the possibility of scoop
            let stringToPass = NSString(string: "pirateDestroyed")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
            
        } else if opponent.ship.IFFStatus == IFFStatusType.Trader {
            player.traderKills += 1
            let stringToPass = NSString(string: "pirateDestroyed")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        } else {
            if opponent.ship.IFFStatus == IFFStatusType.Police {
                player.policeKills += 1
            }
            
            // use the standard modal function if not a pirate or trader
            alertTitle = "Opponent Destroyed"
            alertText = "Your opponent has been destroyed."
            let stringToPass = NSString(string: "simple")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "encounterNotification"), object: stringToPass)
        }
    }
    
    func outcomeOpponentSurrenders() {
        // STILL UNTESTED
        type = EncounterType.pirateSurrender     // just need this for the buttons. Setting text seperately
            
        encounterText2 = "The \(opponent.ship.IFFStatus.rawValue) ship hails that they wish to surrender to you."
        setEncounterTextAndButtons()
        fireModal()
    }
    
    func outcomeOpponentPursues() {
//        print("opponent in pursuit")
        encounterText1 = "The \(opponent.ship.IFFStatus.rawValue) \(opponent.ship.name) is still following you."
        switch opponent.ship.IFFStatus {
            case IFFStatusType.Pirate:
                type = EncounterType.pirateAttack
            case IFFStatusType.Police:
                type = EncounterType.policeAttack
            case IFFStatusType.Trader:
                type = EncounterType.policeAttack
            case IFFStatusType.Dragonfly:
                type = EncounterType.dragonflyAttack
            case IFFStatusType.Mantis:
                type = EncounterType.mantisAttack
            case IFFStatusType.Scarab:
                type = EncounterType.scarabAttack
            case IFFStatusType.SpaceMonster:
                type = EncounterType.spaceMonsterAttack
            default:
                type = EncounterType.pirateAttack   // this is a failure mode
        }
        setEncounterTextAndButtons()
        fireModal()
    }
    
    // NSCODING METHODS
    
        required init(coder decoder: NSCoder) {
            //self.commanderName = decoder.decodeObjectForKey("commanderName") as! String
            self.type = decoder.decodeObject(forKey: "type") as! EncounterType
            self.opponent = decoder.decodeObject(forKey: "opponent") as! Opponent
            self.clicks = decoder.decodeInteger(forKey: "clicks")
            self.encounterText1 = decoder.decodeObject(forKey: "encounterText1") as! String
            self.encounterText2 = decoder.decodeObject(forKey: "encounterText2") as! String
            self.button1Text = decoder.decodeObject(forKey: "button1Text") as! String
            self.button2Text = decoder.decodeObject(forKey: "button2Text") as! String
            self.button3Text = decoder.decodeObject(forKey: "button3Text") as! String
            self.button4Text = decoder.decodeObject(forKey: "button4Text") as! String
            
            self.alertTitle = decoder.decodeObject(forKey: "alertTitle") as! String
            self.alertText = decoder.decodeObject(forKey: "alertText") as! String
            
            self.opponentFleeing = decoder.decodeBool(forKey: "opponentFleeing")
            self.playerFleeing = decoder.decodeBool(forKey: "playerFleeing")
            
            self.pilotSkillOpponent = decoder.decodeInteger(forKey: "pilotSkillOpponent")
            self.fighterSkillOpponent = decoder.decodeInteger(forKey: "fighterSkillOpponent")
            self.traderSkillOpponent = decoder.decodeInteger(forKey: "traderSkillOpponent")
            self.engineerSkillOpponent = decoder.decodeInteger(forKey: "engineerSkillOpponent")
            
            self.youHitThem = decoder.decodeBool(forKey: "youHitThem")
            self.theyHitYou = decoder.decodeBool(forKey: "theyHitYou")
            
            self.scoopableItem = decoder.decodeObject(forKey: "scoopableItem") as! TradeItem?
            
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(type.rawValue, forKey: "type")
            encoder.encode(opponent, forKey: "opponent")
            encoder.encode(clicks, forKey: "clicks")
            encoder.encode(encounterText1, forKey: "encounterText1")
            encoder.encode(encounterText2, forKey: "encounterText2")
            encoder.encode(button1Text, forKey: "button1Text")
            encoder.encode(button2Text, forKey: "button2Text")
            encoder.encode(button3Text, forKey: "button3Text")
            encoder.encode(button4Text, forKey: "button4Text")
            
            encoder.encode(alertTitle, forKey: "alertTitle")
            encoder.encode(alertText, forKey: "alertText")
            
            encoder.encode(opponentFleeing, forKey: "opponentFleeing")
            encoder.encode(playerFleeing, forKey: "playerFleeing")
            
            encoder.encode(pilotSkillOpponent, forKey: "pilotSkillOpponent")
            encoder.encode(fighterSkillOpponent, forKey: "fighterSkillOpponent")
            encoder.encode(traderSkillOpponent, forKey: "traderSkillOpponent")
            encoder.encode(engineerSkillOpponent, forKey: "engineerSkillOpponent")
            
            encoder.encode(youHitThem, forKey: "youHitThem")
            encoder.encode(theyHitYou, forKey: "theyHitYou")
            
            encoder.encode(scoopableItem, forKey: "scoopableItem")
        }
    
}
