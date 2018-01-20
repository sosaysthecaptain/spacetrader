//
//  SpecialEvent.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

// note: alerts are created by first setting specialVCAlert to be the desired alert, and then calling 


class SpecialEvents: NSObject, NSCoding {
    // things referencable from VC
    var special = false
    var specialEventTitle = ""
    var specialEventText = ""
    var yesDismissButtonText = ""
    var noButtonText = ""
    var yesDismissButtonEnabled = true  // assuming this won't be necessary, leaving it here
    var noButtonEnabled = false
    
    // quest strings. One for each quest. addQuestString function takes string and QuestID, appends if it's the first one, replaces if not. Use "" for string to delete quest upon completion.
    var quests: [Quest] = [] {
        didSet {
            for quest in quests {
                if quest.questString == "" {
                    let i = quests.index(of: quest)
                    quests.remove(at: i!)
                }
            }
        }
    }
    
    // state variables (e.g. wildOnBoard, artifactOnBoard), counters (e.g. gemulonInvasionCountdown, experimentCountdown)
    var artifactOnBoard = false
    var wildOnBoard = false
    var reactorOnBoard = false
    var tribblesOnBoard = false
    var marieCelesteStatus = 0 {     // 0 = not happened yet, 1 = not yet apprehended, 2 = over
        didSet {
            //print("marieCelesteStatus changed. Now \(marieCelesteStatus)")
        }
    }
    
    var captainAhabHappened = false
    var captainConradHappened = false
    var captainHuieHappened = false
    
    var experimentCountdown = -1 {
        didSet {
            print("**experimentCountdown = \(experimentCountdown)")
        }
    }
    var jarekElapsedTime = -1 {
        didSet {
            print("**jarekElapsedTime = \(jarekElapsedTime)")
        }
    }
    var gemulonInvasionCountdown = -1 {
        didSet {
            print("**gemulonInvasionCountdown = \(gemulonInvasionCountdown)")
        }
    }
    var reactorElapsedTime = -1 {
        didSet {
            print("**reactorElapsedTime = \(reactorElapsedTime)")
        }
    }
    var wildElapsedTime = -1 {
        didSet {
            print("**wildElapsedTime = \(wildElapsedTime)")
        }
    }
    var princessElapsedTime = -1 {
        didSet {
            print("**princessElapsedTime = \(princessElapsedTime)")
        }
    }
    
    
    // internal
    var currentSpecialEventID: SpecialEventID? = nil
    
    override init() {
        // deliberately empty
    }
    
    func setSpecialEvent() {
        // this should initialize to the event of the CURRENT system (called upon completion of warp)
        // if nil, special is set to false, and the "Special" button is disabled
        if galaxy.currentSystem!.specialEvent != nil {
            special = true
        } else {
            special = false             // necessary for obvious reasons
        }
        
        
        if special {
            switch galaxy.currentSystem!.specialEvent! {
            // initial
            case SpecialEventID.alienArtifact:
                specialEventTitle = "Alien Artifact"
                specialEventText = "This alien artifact should be delivered to professor Berger, who is currently traveling. You can probably find him at a hi-tech solar system. The alien race which produced this artifact seems keen on getting it back, however, and may hinder the carrier. Are you, for a price, willing to deliver it?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.dragonfly:
                specialEventTitle = "Dragonfly"
                specialEventText = "This is Colonel Jackson of the Space Corps. An experimental ship, code-named \"Dragonfly\", has been stolen. It is equipped with very special, almost indestructible shields. It shouldn't fall into the wrong hands and we will reward you if you destroy it. It has been last seen in the Baratas system."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.dangerousExperiment:
                specialEventTitle = "Dangerous Experiment"
                specialEventText = "While reviewing the plans for Dr. Fehler's new space-warping drive, Dr. Lowenstam discovered a critical error. If you don't go to Daled and stop the experiment within ten days, the time-space continuum itself could be damaged!"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.gemulonInvasion:
                specialEventTitle = "Alien Invasion"
                specialEventText = "We received word that aliens will invade Gemulon seven days from now. We know exactly at which coordinates they will arrive, but we can't warn Gemulon because an ion storm disturbs all forms of communication. We need someone, anyone, to deliver this info to Gemulon within six days."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.japoriDisease:
                specialEventTitle = "Japori Disease"
                specialEventText = "A strange disease has invaded the Japori system. We would like you to deliver these ten canisters of special antidote to Japori. Note that, if you accept, ten of your cargo bays will remain in use on your way to Japori. Do you accept this mission?"
                yesDismissButtonText = "OK"
                noButtonText = "No"
                noButtonEnabled = true

            case SpecialEventID.ambassadorJarek:
                specialEventTitle = "Ambassador Jarek"
                specialEventText = "A recent change in the political climate of this solar system has forced Ambassador Jarek to flee back to his home system, Devidia. Would you be willing to give him a lift?"
                yesDismissButtonText = "OK"
                noButtonText = "Cancel"
                noButtonEnabled = true
                
            case SpecialEventID.princess:
                specialEventTitle = "Kidnapped"
                specialEventText = "A member of the Royal Family of Galvon has been kidnapped! Princess Ziyal was abducted by men while travelling across the planet. They escaped in a hi-tech ship called the Scorpion. Please rescue her! (You'll need to equip your ship with disruptors to be able to defeat the Scorpion without destroying it.) A ship bristling with weapons was blasting out of the system. It's trajectory before going to warp indicates that its destination was Centauri."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.moonForSale:
                specialEventTitle = "Moon for Sale"
                specialEventText = "There is a small but habitable moon for sale in the Utopia system, for the very reasonable sum of half a million credits. If you accept it, you can retire to it and live a peaceful, happy, and wealthy life. Do you wish to buy it?"
                yesDismissButtonText = "OK"
                noButtonText = "No Thanks"
                noButtonEnabled = true
                
            case SpecialEventID.morgansReactor:
                specialEventTitle = "Morgan's Reactor"
                specialEventText = "Galactic criminal Henry Morgan wants this illegal ion reactor delivered to Nix. It's a very dangerous mission! The reactor and its fuel are bulky, taking up 15 bays. Worse, it's not stable -- its resonant energy will weaken your shields and hull strength while it's aboard your ship. Are you willing to deliver it?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.scarabStolen:
                specialEventTitle = "Scarab Stolen"
                specialEventText = "Captain Renwick developed a new organic hull material for his ship which cannot be damaged except by Pulse lasers. While he was celebrating this success, pirates boarded and stole the craft, which they have named the Scarab. Rumors suggest it's being hidden at the exit to a wormhole. Destroy the ship for a reward!"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.sculpture:
                specialEventTitle = "Stolen Sculpture"
                specialEventText = "A hooded figure approaches you and asks if you'd be willing to deliver some recently aquired merchandise to Endor. He's holding a small sculpture of a man holding some kind of light sword that you strongly suspect was stolen. It appears to be made of plastic and not very valuable. \"I'll pay you 2,000 credits now, plus 15,000 on delivery,\" the figure says. After seeing the look on your face he adds, \"It's a collector's item. Will you deliver it or not?\""
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.spaceMonster:
                specialEventTitle = "Space Monster"
                specialEventText = "A space monster has invaded the Acamar system and is disturbing the trade routes. You'll be rewarded handsomely if you manage to destroy it."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.wild:
                specialEventTitle = "Jonathan Wild"
                specialEventText = "Law Enforcement is closing in on notorious criminal kingpin Jonathan Wild. He would reward you handsomely for smuggling him home to Kravat. You'd have to avoid capture by the Police on the way. Are you willing to give him a berth?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.merchantPrice:
                specialEventTitle = "Merchant Prince"
                specialEventText = "A merchant prince offers you a very special and wondrous item for the sum of 1000 credits. Do you accept?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.eraseRecord:
                specialEventTitle = "Erase Record"
                specialEventText = "A hacker conveys to you that he has cracked the passwords to the galaxy-wide police computer network, and that he can erase your police record for the sum of 5000 credits. Do you want him to do that?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.lotteryWinner:
                specialEventTitle = "Lottery Winner"
                specialEventText = "You are lucky! While docking on the space port, you receive a message that you won 1000 credits in a lottery. The prize has been added to your account."
                // set button titles and enabled/disabled status
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.skillIncrease:
                specialEventTitle = "Skill Increase"
                specialEventText = "An alien with a fast-learning machine offers to increase one of your skills for the reasonable sum of 3000 credits. You won't be able to pick that skill, though. Do you accept his offer?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.cargoForSale:
                specialEventTitle = "Cargo For Sale"
                specialEventText = "A trader in second-hand goods offers you 3 sealed cargo canisters for the sum of 1000 credits. It could be a good deal: they could contain robots. Then again, it might just be water. Do you want the canisters?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            // subsequent
            case SpecialEventID.artifactDelivery:
                specialEventTitle = "Artifact Delivery"
                specialEventText = "This is professor Berger. I thank you for delivering the alien artifact to me. I hope the aliens weren't too much of a nuisance. I have transferred 20000 credits to your account, which I assume compensates for your troubles."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.dragonflyBaratas:
                specialEventTitle = "Weird Ship"
                specialEventText = "A small ship of a weird design docked here recently for repairs. The engineer who worked on it said that it had a weak hull, but incredibly strong shields. I heard it took off in the direction of the Melina system."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.dragonflyMelina:
                specialEventTitle = "Lightning Ship"
                specialEventText = "A ship with shields that seemed to be like lightning recently fought many other ships in our system. I have never seen anything like it before. After it left, I heard it went to the Regulas system."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.dragonflyRegulas:
                specialEventTitle = "Strange Ship"
                specialEventText = "A small ship with shields like I have never seen before was here a few days ago. It destroyed at least ten police ships! Last thing I heard was that it went to the Zalkon system."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.dragonflyDestroyed:
                specialEventTitle = "Dragonfly Destroyed"
                specialEventText = "Hello, Commander. This is Colonel Jackson again. On behalf of the Space Corps, I thank you for your valuable assistance in destroying the Dragonfly. As a reward, we will install one of the experimental shields on your ship. Return here for that when you're ready."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.lightningShield:
                specialEventTitle = "Lightning Shield"
                specialEventText = "Colonel Jackson here. Do you want us to install a lightning shield on your current ship?"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.disasterAverted:
                specialEventTitle = "Disaster Averted"
                specialEventText = "Upon your warning, Dr. Fehler calls off the experiment. As your  reward, you are given a Portable Singularity. This device will, for one time only, instantaneously transport you to any system in the galaxy. The Singularity can be accessed by pressing the \"jump\" button on the Galactic Chart."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.experimentFailed:
                specialEventTitle = "Experiment Failed"
                specialEventText = "Dr. Fehler can't understand why the experiment failed. But the failure has had a dramatic and disastrous effect on the fabric of space-time itself. It seems that Dr. Fehler won't be getting tenure any time soon... and you may have trouble when you warp!"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.gemulonInvaded:
                specialEventTitle = "Gemulon Invaded"
                specialEventText = "Alas, Gemulon has been invaded by aliens, which has thrown us back to pre-agricultural times. If only we had known the exact coordinates where they first arrived at our system, we might have prevented this tragedy from happening."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.gemulonRescued:
                specialEventTitle = "Gemulon Rescued"
                specialEventText = "This information of the arrival of the alien invasion force allows us to prepare a defense. You have saved our way of life. As a reward, we have a fuel compactor gadget for you, which will increase the travel distance by 3 parsecs for any ship. Return here to get it installed."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.fuelCompactor:
                specialEventTitle = "Fuel Compactor"
                specialEventText = "Do you wish us to install the fuel compactor on your current ship? (You need a free gadget slot)"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.medicineDelivery:
                specialEventTitle = "Medicine Delivery"
                specialEventText = "Thank you for delivering the medicine to us. We don't have any money to reward you, but we do have an alien fast-learning machine with which we will increase your skills."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.jarekGetsOut:
                specialEventTitle = "Jarek Gets Out"
                specialEventText = "Ambassador Jarek is very grateful to you for delivering him back to Devidia. As a reward, he gives you an experimental handheld haggling computer, which allows you to gain larger discounts when purchasing goods and equipment."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.princessCentauri:
                specialEventTitle = "Dangerous Scorpion"
                specialEventText = "A ship had its shields upgraded to Lighting Shields just two days ago. A shipyard worker overheard one of the crew saying they were headed to Inthara."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.princessInthara:
                specialEventTitle = "Agressive Ship"
                specialEventText = "Just yesterday a ship was seen in docking bay 327. A trader sold goods to a member of the crew, who was a native of Qonos. It's possible that's where they were going next."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.princessRescued:
                specialEventTitle = "Princess Rescued"
                specialEventText = "You land your ship near where the Space Corps has landed with the Scorpion in tow. The Princess is revived from hibernation and you get to see her for the first time. Instead of the spoiled child you were expecting, Ziyal is possibly the most beautiful woman you’ve ever seen. “What took you so long?” she demands. You notice a twinkle in her eye, and then she smiles. Not only is she beautiful, but she’s got a sense of humor. She says, “Thank you for freeing me. I am in your debt.” With that she gives you a kiss on the cheek, then leaves. You hear her mumble, “Now what about a ride home?”"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.princessQonos:
                specialEventTitle = "Royal Rescue"
                specialEventText = "The Galvonian Ambassador to Qonos approaches you. The Princess needs a ride home. Will you take her? I don't think she'll feel safe with anyone else."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.princessReturned:
                specialEventTitle = "Royal Return"
                specialEventText = "The King and Queen are extremely grateful to you for returning their daughter to them. The King says, \"Ziyal is priceless to us, but we feel we must offer you something as a reward. Visit my shipyard captain and he'll install one of our new Quantum Disruptors.\""
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.installQuantumDisruptor:
                specialEventTitle = "Quantum Disruptor"
                specialEventText = "His Majesty's Shipyard: Do you want us to install a quantum disruptor on your current ship?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.retirement:
                specialEventTitle = "Retirement"
                specialEventText = "Welcome to the Utopia system. Your own moon is available for you to retire to it, if you feel inclined to do that. Are you ready to retire and lead a happy, peaceful, and wealthy life?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.reactorDelivered:
                specialEventTitle = "Reactor Delivered"
                specialEventText = "Henry Morgan takes delivery of the reactor with great glee. His men immediately set about stabilizing the fuel system. As a reward, Morgan offers you a special, high-powered laser that he designed. Return with an empty weapon slot when you want them to install it."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.installMorgansLaser:
                specialEventTitle = "Install Morgan's Laser"
                specialEventText = "Morgan's technicians are standing by with something that looks a lot like a military laser -- if you ignore the additional cooling vents and anodized ducts. Do you want them to install Morgan's special laser?"
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.scarabDestroyed:
                specialEventTitle = "Scarab Destroyed"
                specialEventText = "Space Corps is indebted to you for destroying the Scarab and the pirates who stole it. As a reward, we can have Captain Renwick upgrade the hull of your ship. Note that his upgrades won't be transferable if you buy a new ship! Come back with the ship you wish to upgrade."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.upgradeHull:
                specialEventTitle = "Upgrade Hull"
                specialEventText = "The organic hull used in the Scarab is still not ready for day-to-day use. But Captain Renwick can certainly upgrade your hull with some of his retrofit technology. It's light stuff, and won't reduce your ship's range. Should he upgrade your ship?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.sculptureDelivered:
                specialEventTitle = "Sculpture Delivered"
                specialEventText = "Yet another dark, hooded figure approaches. \"Do you have the action fig- umm, the sculpture?\" You hand it over and hear what sounds very much like a giggle from under the hood. \"I know you were promised 15,000 credits on delivery, but I'm strapped for cash right now. However, I have something better for you. I have an acquaintance who can install hidden compartments in your ship.\" Return with an empty gadget slot when you're ready to have it installed."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.installHiddenCompartments:
                specialEventTitle = "Install Hidden Compartments"
                specialEventText = "You're taken to a warehouse and whisked through the door. A grubby alien of some humanoid species - you're not sure which one - approaches. \"So you're the being who needs Hidden Compartments. Should I install them in your ship?\" (It requires a free gadget slot.)"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            case SpecialEventID.monsterKilled:
                specialEventTitle = "Monster Killed"
                specialEventText = "We thank you for destroying the space monster that ircled our system for so long. Please accept 15000 credits as reward for your heroic deed."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.wildGetsOut:
                specialEventTitle = "Wild Gets Out"
                specialEventText = "Jonathan Wild is most grateful to you for spiriting him to safety. As a reward, he has one of his Cyber Criminals hack into the Police Database, and clean up your record. He also offers you the opportunity to take his talented nephew Zeethibal along as a Mercenary with no pay."
                yesDismissButtonText = "OK"
                //noButtonText = ""
                noButtonEnabled = false
                
            case SpecialEventID.tribbleBuyer:
                specialEventTitle = "Tribble Buyer"
                specialEventText = "An eccentric alien billionaire wants to buy your collection of tribbles and offers half a credit for each of them. Do you accept his offer?"
                yesDismissButtonText = "Yes"
                noButtonText = "No"
                noButtonEnabled = true
                
            }
        }
        
    }
    
//    func yesDismissButton() {
//        switch galaxy.currentSystem!.specialEvent! {
//            // initial
//        case SpecialEventID.alienArtifact:
//            addQuestString("Deliver the alien artifact to Professor Berger at some hi-tech system.", ID: QuestID.artifact)
//            player.commanderShip.artifactOnBoard = true
//            // add artifact delivery to some high tech system without a specialEvent set
//            for planet in galaxy.planets {
//                if planet.techLevel == TechLevelType.techLevel7 {
//                    if planet.specialEvent == nil {
//                        galaxy.setSpecial(planet.name, id: SpecialEventID.artifactDelivery)
//                    }
//                }
//            }
//            artifactOnBoard = true
//            
//        case SpecialEventID.dragonfly:
//            addQuestString("Follow the Dragonfly to Melina.", ID: QuestID.dragonfly)
//            galaxy.setSpecial("Melina", id: SpecialEventID.dragonflyMelina)
//            
//        case SpecialEventID.dangerousExperiment:
//            experimentCountdown = 10
//            addQuestString("Stop Dr. Fehler's experiment at Daled within \(experimentCountdown) days.", ID: QuestID.experiment)
//            galaxy.setSpecial("Daled", id: SpecialEventID.disasterAverted)
//            
//        case SpecialEventID.gemulonInvasion:
//            gemulonInvasionCountdown = 7
//            addQuestString("Inform Gemulon about alien invasion within \(gemulonInvasionCountdown) days.", ID: QuestID.gemulon)
//            galaxy.setSpecial("Gemulon", id: SpecialEventID.gemulonRescued)
//            
//        case SpecialEventID.japoriDisease:
//            // player can accept quest only if ship has 10 bays free
//            if player.commanderShip.baysAvailable >= 10 {
//                // quest
//                addQuestString("Deliver antidote to Japori.", ID: QuestID.japori)
//                // create new special in Japori--medicineDelivery
//                galaxy.setSpecial("Japori", id: SpecialEventID.medicineDelivery)
//                player.commanderShip.japoriSpecialCargo = true
//            } else {
//                // if bays not free, create alert, put back special
//                print("error. Not enough bays available. CREATE ALERT.")                // ADD ALERT
//                galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//            
//            
//        case SpecialEventID.ambassadorJarek:
//            
//            
//            jarekElapsedTime = 0
//            addQuestString("Take ambassador Jarek to Devidia.", ID: QuestID.jarek)
//            galaxy.setSpecial("Devidia", id: SpecialEventID.jarekGetsOut)
//            
//            if player.commanderShip.crewSlotsAvailable >= 1 {
//                // take him on
//                let jarek = CrewMember(ID: MercenaryName.jarek, pilot: 1, fighter: 1, trader: 10, engineer: 1)    // are these the numbers we want to use for Jarek? Maybe find out?
//                player.commanderShip.crew.append(jarek)
//            } else {
//                // can't take him on
//                print("error. Not enough crew slots available. CREATE ALERT.")            // ADD ALERT
//                // restore special event at current system
//                galaxy.setSpecial(galaxy.currentSystem!.name, id: SpecialEventID.ambassadorJarek)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//        case SpecialEventID.princess:
//            addQuestString("Follow the Scorpion to Centauri.", ID: QuestID.princess)
//            galaxy.setSpecial("Centauri", id: SpecialEventID.princessCentauri)
//            
//        case SpecialEventID.moonForSale:
//            if player.credits >= 500000 {
//                // go for it
//                player.credits -= 500000
//                addQuestString("Claim your moon at Utopia.", ID: QuestID.moon)
//                galaxy.setSpecial("Utopia", id: SpecialEventID.retirement)
//            } else {
//                // too poor message                                         ALERT
//                // put back special
//                galaxy.setSpecial(galaxy.currentSystem!.name, id: SpecialEventID.moonForSale)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//            
//
//        case SpecialEventID.morgansReactor:
//            
//            if player.commanderShip.baysAvailable >= 10 {
//                // quest
//                addQuestString("Deliver the unstable reactor to Nix for Henry Morgan.", ID: QuestID.reactor)
//                reactorElapsedTime = 0
//                galaxy.setSpecial("Nix", id: SpecialEventID.reactorDelivered)
//                player.commanderShip.reactorSpecialCargo = true
//                player.commanderShip.reactorFuelSpecialCargo = true
//                player.commanderShip.reactorFuelBays = 10
//                
//                // alert
//                specialVCAlert = Alert(ID: AlertID.ReactorOnBoard, passedString1: nil, passedString2: nil, passedString3: nil)
//                NSNotificationCenter.defaultCenter().postNotificationName("generateSpecialAlert", object: NSString(string: "empty"))
//            } else {
//                // if bays not free, create alert, put back special
//                print("error. Not enough bays available. CREATE ALERT.")                // ADD ALERT
//                galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//        case SpecialEventID.scarabStolen:
//            addQuestString("Find and destroy the Scarab (which is hiding at the exit to a wormhole).", ID: QuestID.scarab)
//            // add scarab to some planet with a wormhole
//            for planet in galaxy.planets {
//                if (planet.wormhole == true) && (planet.specialEvent == nil) {
//                    planet.scarabIsHere = true
//                }
//            }
//            // **** UPON DESTRUCTION OF SCARAB, UPDATE QUESTSTRING AND ADD SCARABDESTROYED SPECIAL TO CURRENT SYSTEM
//            
//            
//        case SpecialEventID.sculpture:
//            addQuestString("Deliver the stolen sculpture to Endor.", ID: QuestID.sculpture)
//            galaxy.setSpecial("Endor", id: SpecialEventID.sculptureDelivered)
//            // **** DO WE NEED ALIENS OR ANYTHING HERE?
//            
//        case SpecialEventID.spaceMonster:
//            addQuestString("Kill the space monster at Acamar.", ID: QuestID.spaceMonster)
//            for planet in galaxy.planets {
//                if planet.name == "Acamar" {
//                    planet.spaceMonsterIsHere = true
//                }
//            }
//            
//        case SpecialEventID.wild:
//            // **** MAKE SURE ENOUGH SPACE TO TAKE ON WILD
//            wildOnBoard = true
//            wildElapsedTime = 0
//            addQuestString("Smuggle Jonathan Wild to Kravat", ID: QuestID.wild)
//            galaxy.setSpecial("Kravat", id: SpecialEventID.wildGetsOut)
//            // **** ADD WILD TO CREW, TAKE HIS SKILLS INTO ACCOUNT
//            
//        case SpecialEventID.merchantPrice:
//            player.commanderShip.tribbles = 1       // NEED UPDATETRIBBLE FUNCTION
//            addQuestString("Get rid of those pesky tribbles.", ID: QuestID.tribbles) // is it time for this yet?
//            // add tribble buyer somewhere. **** IS IT TIME FOR THIS YET?
//            for planet in galaxy.planets {
//                if planet.specialEvent == nil {
//                    planet.specialEvent = SpecialEventID.tribbleBuyer
//                }
//            }
//            
//        case SpecialEventID.eraseRecord:
//            if player.credits >= 5000 {
//                player.policeRecord = PoliceRecordType.cleanScore
//                player.credits -= 5000
//            } else {
//                // **** YOU CAN'T AFFORD THIS ALERT
//                // **** REINSTATE SPECIAL EVENT, SINCE WE HAVEN'T USED IT AND DON'T WANT IT GONE
//            }
//            
//            
//        case SpecialEventID.lotteryWinner:
//            player.credits += 1000
//            
//        case SpecialEventID.skillIncrease:
//            if player.credits >= 3000 {
//                player.credits -= 3000
//                increaseRandomSkill()
//            } else {
//                // **** TOO POOR MESSAGE & REINSTATE SPECIAL
//            }
//            
//        case SpecialEventID.cargoForSale:
//            if player.credits >= 1000 {
//                if player.commanderShip.cargoBays >= 3 {
//                    player.credits -= 1000
//                    addRandomCargo()
//                } else {
//                    // **** TOO FEW BAYS MESSAGE
//                }
//            } else {
//                // **** TOO POOR MESSAGE
//            }
//            
//            // subsequent
//        case SpecialEventID.artifactDelivery:
//            artifactOnBoard = false
//            player.commanderShip.artifactOnBoard = false
//            player.credits += 20000
//            addQuestString("", ID: QuestID.artifact)        // close quest
//            
//        case SpecialEventID.dragonflyBaratas:
//            addQuestString("Follow the Dragonfly to Melina.", ID: QuestID.dragonfly)
//            galaxy.setSpecial("Melina", id: SpecialEventID.dragonflyMelina)
//            
//        case SpecialEventID.dragonflyMelina:
//            addQuestString("Follow the Dragonfly to Regulas", ID: QuestID.dragonfly)
//            galaxy.setSpecial("Regulas", id: SpecialEventID.dragonflyRegulas)
//            
//        case SpecialEventID.dragonflyRegulas:
//            addQuestString("Follow the Dragonfly to Zalkon.", ID: QuestID.dragonfly)
//            for planet in galaxy.planets {
//                if planet.name == "Zalkon" {
//                    planet.dragonflyIsHere = true
//                }
//            }
//            // no new special. Will be added at Zalkon when dragonfly is destroyed
//            
//        case SpecialEventID.dragonflyDestroyed:
//            addQuestString("Get your lightning shield at Zalkon.", ID: QuestID.dragonfly)
//            galaxy.setSpecial("Zalkon", id: SpecialEventID.lightningShield)
//            dontDeleteLocalSpecialEvent = true
//            
//        case SpecialEventID.lightningShield:
//            if player.commanderShip.shield.count < player.commanderShip.shieldSlots {
//                // add shield
//                player.commanderShip.shield.append(Shield(type: ShieldType.lightningShield))
//                addQuestString("", ID: QuestID.dragonfly)
//            } else {
//                // **** NOT ENOUGH SHIELD SLOTS MESSAGE
//                galaxy.setSpecial("Zalkon", id: SpecialEventID.lightningShield)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//        case SpecialEventID.disasterAverted:
//            experimentCountdown = -1        // deactivate countdown
//            player.portableSingularity = true
//            addQuestString("", ID: QuestID.experiment)
//            
//        case SpecialEventID.experimentFailed:
//            addQuestString("", ID: QuestID.experiment)
//            // spacetime was already messed up when the timer expired
//            
//        case SpecialEventID.gemulonInvaded:
//            // aliens already appeared when timer expired
//            addQuestString("", ID: QuestID.gemulon)
//            
//        case SpecialEventID.gemulonRescued:
//            gemulonInvasionCountdown = -1   // deactivate countdown
//            addQuestString("", ID: QuestID.gemulon)
//            galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
//            dontDeleteLocalSpecialEvent = true
//            
//        case SpecialEventID.fuelCompactor:
//            if player.commanderShip.gadget.count < player.commanderShip.gadgetSlots {
//                // add gadget
//                player.commanderShip.gadget.append(Gadget(type: GadgetType.FuelCompactor))
//                addQuestString("", ID: QuestID.dragonfly)
//            } else {
//                // **** NOT ENOUGH GADGET SLOTS MESSAGE
//                galaxy.setSpecial("Gemulon", id: SpecialEventID.fuelCompactor)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//        case SpecialEventID.medicineDelivery:
//            player.commanderShip.japoriSpecialCargo = false     // remove special cargo
//            addQuestString("", ID: QuestID.japori)
//            increaseRandomSkill()                               // DO WE WANT AN ALERT HERE?
//            
//        case SpecialEventID.jarekGetsOut:
//            // remove jarek
//            player.commanderShip.removeCrewMember(MercenaryName.jarek)
//            // stop countdown, remove quest string
//            jarekElapsedTime = -1
//            addQuestString("", ID: QuestID.jarek)
//            // add special cargo, if possible
//            if player.commanderShip.baysAvailable >= 1 {
//                player.initialTraderSkill += 2
//                player.commanderShip.jarekHagglingComputerSpecialCargo = true
//                print("haggling computer bool: \(player.commanderShip.jarekHagglingComputerSpecialCargo)")
//            }
//            // I guess otherwise you don't get the bump in trader skill?
//            
//            
//    
//        case SpecialEventID.princessCentauri:
//            addQuestString("Follow the Scorpion to Inthara.", ID: QuestID.princess)
//            galaxy.setSpecial("Inthara", id: SpecialEventID.princessInthara)
//            
//        case SpecialEventID.princessInthara:
//            addQuestString("Follow the Scorpion to Qonos.", ID: QuestID.princess)
//            for planet in galaxy.planets {
//                if planet.name == "Qonos" {
//                    planet.scorpionIsHere = true
//                }
//            }
//            // upon defeat of the scorpion, SpecialEventID.princessQonos will be added
//            
//        case SpecialEventID.princessQonos:
//            
//            addQuestString("Transport Ziyal from Qonos to Galvon.", ID: QuestID.princess)
//            galaxy.setSpecial("Galvon", id: SpecialEventID.princessReturned)
//            
//        case SpecialEventID.princessReturned:
//            princessElapsedTime = -1
//            addQuestString("Get your Quantum Disruptor at Galvon.", ID: QuestID.princess)
//            galaxy.setSpecial("Galvon", id: SpecialEventID.installQuantumDisruptor)
//            
//        case SpecialEventID.installQuantumDisruptor:
//            if player.commanderShip.weapon.count < player.commanderShip.weaponSlots {
//                // add disruptor
//                player.commanderShip.weapon.append(Weapon(type: WeaponType.quantumDisruptor))
//                addQuestString("", ID: QuestID.princess)
//            } else {
//                // **** NOT ENOUGH WEAPON SLOTS MESSAGE                                 ALERT
//                galaxy.setSpecial("Galvon", id: SpecialEventID.installQuantumDisruptor)
//                dontDeleteLocalSpecialEvent = true
//                
//            }
//            
//        case SpecialEventID.retirement:
//            //print("pushed yes on retire screen")
//            addQuestString("", ID: QuestID.moon)
//            // end game
//            player.endGameType = EndGameStatus.BoughtMoon
//            // fire gameOver() in SpecialVC with notificationCenter
//            NSNotificationCenter.defaultCenter().postNotificationName("gameOverFromSpecialVC", object: NSString(string: "empty"))
//            
//        case SpecialEventID.reactorDelivered:
//            reactorElapsedTime = -1
//            addQuestString("Get your special laser at Nix.", ID: QuestID.reactor)
//            galaxy.setSpecial("Nix", id: SpecialEventID.installMorgansLaser)
//            
//        case SpecialEventID.installMorgansLaser:
//            if player.commanderShip.weapon.count < player.commanderShip.weaponSlots {
//                // add laser
//                player.commanderShip.weapon.append(Weapon(type: WeaponType.morgansLaser))
//                addQuestString("", ID: QuestID.reactor)
//                dontDeleteLocalSpecialEvent = true
//            } else {
//                // **** NOT ENOUGH WEAPON SLOTS MESSAGE
//                galaxy.setSpecial("Nix", id: SpecialEventID.installMorgansLaser)
//                dontDeleteLocalSpecialEvent = true
//            }
//            
//        case SpecialEventID.scarabDestroyed:
//            addQuestString("Get your hull upgraded at \(galaxy.currentSystem!.name)", ID: QuestID.scarab)
//            galaxy.setSpecial("\(galaxy.currentSystem!.name)", id: SpecialEventID.upgradeHull)
//            
//        case SpecialEventID.upgradeHull:
//            // **** ANY MESSAGE HERE?
//            player.commanderShip.hullStrength += 150    // hopefully this is the best way to do this?
//            addQuestString("", ID: QuestID.scarab)
//            
//        case SpecialEventID.sculptureDelivered:
//            addQuestString("Have hidden compartments installed at Endor.", ID: QuestID.sculpture)
//            galaxy.setSpecial("Endor", id: SpecialEventID.sculpture)
//            
//        case SpecialEventID.installHiddenCompartments:
//            if player.commanderShip.gadget.count < player.commanderShip.gadgetSlots {
//                // add gadget
//                // **** CREATE HIDDEN COMPARTMENT GADGET
//                //player.commanderShip.gadget.append(Gadget(type: GadgetType.FuelCompactor))
//                addQuestString("", ID: QuestID.dragonfly)
//            } else {
//                // **** NOT ENOUGH GADGET SLOTS MESSAGE
//                galaxy.setSpecial("Endor", id: SpecialEventID.sculpture)
//            }
//            
//        case SpecialEventID.monsterKilled:
//            addQuestString("", ID: QuestID.spaceMonster)
//            player.credits += 15000
//            
//        case SpecialEventID.wildGetsOut:
//            addQuestString("", ID: QuestID.wild)
//            // remove wild from ship
//            player.specialEvents.wildOnBoard = false
//            
//            // reset wild countdown
//            wildElapsedTime = -1
//            
//            let zeethibal = CrewMember(ID: MercenaryName.zeethibal, pilot: 9, fighter: 9, trader: 9, engineer: 9)
//            zeethibal.costPerDay = 0
//            galaxy.currentSystem!.mercenaries.append(zeethibal)
//            
//        case SpecialEventID.tribbleBuyer:
//            addQuestString("", ID: QuestID.tribbles)
//            player.commanderShip.tribbles = 0
//            tribblesOnBoard = false
//        }
//
//    }
//    
//    func noButton() {
//        // I think this function might be unnecessary. No might just need to dismiss the modal.
//        // Do declined quests ever need to go away?
//    }
    
    func addQuestString(_ string: String, ID: QuestID) {
        // empty string removes this quest
        var found = false
        for quest in quests {
            if quest.ID == ID {
                found = true
                if string != "" {
                    // update if string
                    quest.questString = string
                } else {
                    // set as completed
                    quest.questString = ""
                    quest.completed = true
                }
            }
        }
        if !found {
            quests.append(Quest(ID: ID, questString: string))
        }
    }
    
    func increaseRandomSkill() {
        var redo = true
        while redo {
            redo = false
            let random = rand(4)
            switch random {
            case 0:
                if player.initialPilotSkill > 7 {
                    redo = true
                } else {
                    player.initialPilotSkill += 2   // **** 2? 1?
                }
            case 1:
                if player.initialFighterSkill > 7 {
                    redo = true
                } else {
                    player.initialFighterSkill += 2
                }
            case 2:
                if player.initialTraderSkill > 7 {
                    redo = true
                } else {
                    player.initialTraderSkill += 2
                }
            case 3:
                if player.initialEngineerSkill > 7 {
                    redo = true
                } else {
                    player.initialEngineerSkill += 2
                }
            default: print("error")
            }
            
            if (player.initialPilotSkill > 7) && (player.initialFighterSkill > 7) && (player.initialTraderSkill > 7) && (player.initialEngineerSkill > 7) {
                redo = false
                player.initialPilotSkill = 9
            }
        }
    }
    
    func addRandomCargo() {
        let random = rand(10)
        
        switch random {
        case 0:
            player.commanderShip.addCargo(TradeItemType.Water, quantity: 3, pricePaid: 333)
        case 1:
            player.commanderShip.addCargo(TradeItemType.Furs, quantity: 3, pricePaid: 333)
        case 2:
            player.commanderShip.addCargo(TradeItemType.Food, quantity: 3, pricePaid: 333)
        case 3:
            player.commanderShip.addCargo(TradeItemType.Ore, quantity: 3, pricePaid: 333)
        case 4:
            player.commanderShip.addCargo(TradeItemType.Games, quantity: 3, pricePaid: 333)
        case 5:
            player.commanderShip.addCargo(TradeItemType.Firearms, quantity: 3, pricePaid: 333)
        case 6:
            player.commanderShip.addCargo(TradeItemType.Medicine, quantity: 3, pricePaid: 333)
        case 7:
            player.commanderShip.addCargo(TradeItemType.Machines, quantity: 3, pricePaid: 333)
        case 8:
            player.commanderShip.addCargo(TradeItemType.Narcotics, quantity: 3, pricePaid: 333)
        case 9:
            player.commanderShip.addCargo(TradeItemType.Robots, quantity: 3, pricePaid: 333)
        default: print("error")
        }
    }
    
    func scarabDestroyed() {
        // update quest string
        player.specialEvents.addQuestString("Notify the authorities at \(galaxy.currentSystem!.name) that the Scarab has been destroyed.", ID: QuestID.scarab)
        // set special on local system
        galaxy.setSpecial(galaxy.targetSystem!.name, id: SpecialEventID.scarabDestroyed)
        
    }
    
    func spaceMonsterKilled() {
        player.specialEvents.addQuestString("Go to Acamar to collect your reward for killing the space monster.", ID: QuestID.spaceMonster)
        galaxy.setSpecial("Acamar", id: SpecialEventID.monsterKilled)
    }
    
    func dragonflyDestroyed() {
        player.specialEvents.addQuestString("Go to Zalkon to collect your reward for destroying the dragonfly.", ID: QuestID.dragonfly)
        galaxy.setSpecial("Zalkon", id: SpecialEventID.dragonflyDestroyed)
    }
    
    func scorpionDisabled() {
        player.specialEvents.addQuestString("Follow the disabled Scorpion to Qonos.", ID: QuestID.princess)
        galaxy.setSpecial("Qonos", id: SpecialEventID.princessRescued)
    }
    
    func incrementCountdown() {
        // is called every day on warp, decrements each countdown. Checks if they are zero, acts accordingly if so
        
        // experiments
        if experimentCountdown != -1 {
            experimentCountdown -= 1
            
            if experimentCountdown > 1 {
                addQuestString("Stop Dr. Fehler's experiment at Daled within \(experimentCountdown) days.", ID: QuestID.experiment)
            } else if experimentCountdown == 1 {
                addQuestString("Stop Dr. Fehler's experiment at Daled by tomorrow.", ID: QuestID.experiment)
            } else if experimentCountdown == 0 {
                experimentCountdown = -1    // inactivate counter
                addQuestString("", ID: QuestID.experiment)  // inactivate quest
                galaxy.spaceTimeMessedUp = true
                galaxy.setSpecial("Daled", id: SpecialEventID.experimentFailed)
                galaxy.alertsToFireOnArrival.append(AlertID.specialExperimentPerformed)
            }
        }
        
        // jarek
        if jarekElapsedTime != -1 {
            jarekElapsedTime += 1
            
            if jarekElapsedTime == 6 {
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerConcernedJarek)
            }
            
            if jarekElapsedTime == 12 {
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerImpatientJarek)
                // jarek gets less helpful
                addQuestString("Jarek is wondering why the journey is taking so long, and is no longer of much help in negotiating trades.", ID: QuestID.jarek)
                for person in player.commanderShip.crew {
                    if person.ID == MercenaryName.jarek {
                        person.pilot = 1
                        person.fighter = 1
                        person.trader = 1
                        person.engineer = 1
                    }
                }
            }
        }
        
        // gemulon
        if gemulonInvasionCountdown != -1 {
            gemulonInvasionCountdown -= 1
            
            if gemulonInvasionCountdown > 1 {
                addQuestString("Inform Gemulon about alien invasion within \(gemulonInvasionCountdown) days.", ID: QuestID.gemulon)
            } else if gemulonInvasionCountdown == 1 {
                addQuestString("Inform Gemulon about alien invasion by tomorrow.", ID: QuestID.gemulon)
            }
            
            if gemulonInvasionCountdown == 0 {
                gemulonInvasionCountdown == -1              // inactivate countdown
                addQuestString("", ID: QuestID.gemulon)     // inactivate quest
                galaxy.setSpecial("Gemulon", id: SpecialEventID.gemulonInvaded)
                for planet in galaxy.planets {
                    if planet.name == "Gemulon" {
                        planet.swarmingWithAliens = true
                        planet.techLevel = TechLevelType.techLevel0     // invasion sets them back to primitive levels
                    }
                }
            }
        }
        
        // reactor
        if reactorElapsedTime != -1 {
            reactorElapsedTime += 1
            
            if reactorElapsedTime > 0 && reactorElapsedTime < 6 {
                // consume at a slow rate
                player.commanderShip.reactorFuelBays -= 0.25
            } else if reactorElapsedTime < 10 {
                // consume faster
                player.commanderShip.reactorFuelBays -= 0.5
            } else {
                player.commanderShip.reactorFuelBays -= 1
            }
            
            if player.commanderShip.reactorFuelBays < 0 {
                player.commanderShip.reactorFuelBays = 0
            }
            
            if reactorElapsedTime == 6 {
                print("time for ReactorWarningFuel")
                galaxy.alertsToFireOnArrival.append(AlertID.reactorWarningFuel)
            } else if reactorElapsedTime == 12 {
                print("ReactorWarningFuelGone")
                galaxy.alertsToFireOnArrival.append(AlertID.reactorWarningFuelGone)
            } else if reactorElapsedTime == 14 {
                print("ReactorWarningTemp")
                galaxy.alertsToFireOnArrival.append(AlertID.reactorWarningTemp)
            } else if reactorElapsedTime == 16 {
                galaxy.meltdownOnArrival = true
            }
        }
        
        // wild
        if wildElapsedTime != -1 {
            wildElapsedTime += 1
            
            if wildElapsedTime == 6 {
                // mildly annoyed
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerConcernedWild)
            }
            if wildElapsedTime == 12 {
                // annoyed, stops helping
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerImpatientWild)
                
                for person in player.commanderShip.crew {
                    if person.ID == MercenaryName.wild {
                        person.pilot = 1
                        person.fighter = 1
                        person.trader = 1
                        person.engineer = 1
                    }
                }
                addQuestString("Wild is getting impatient, and will no longer aid your crew along the way.", ID: QuestID.wild)
            }
            
            if wildElapsedTime == 14 {
                // gets out
                addQuestString("", ID: QuestID.wild)
                player.specialEvents.wildOnBoard = false
                wildElapsedTime = -1
                galaxy.alertsToFireOnArrival.append(AlertID.wildLeavesShip)
            }
        }
        
        // princess
        if princessElapsedTime != -1 {
            princessElapsedTime += 1
            
            if princessElapsedTime == 8 {
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerImpatientPrincess)
                addQuestString("Return Ziyal to Galvon.", ID: QuestID.princess)
                
            }
            if princessElapsedTime == 16 {
                galaxy.alertsToFireOnArrival.append(AlertID.specialPassengerConcernedPrincess)
                addQuestString("Return Ziyal to Galvon. She is becoming anxious to arrive at home, and is no longer of any help in engineering functions.", ID: QuestID.princess)
                // PRINCESS NEEDS TO BE PROPERLY IN CREW
                for person in player.commanderShip.crew {
                    if person.ID == MercenaryName.ziyal {
                        person.pilot = 1
                        person.fighter = 1
                        person.trader = 1
                        person.engineer = 1
                    }
                }
            }
        }
        
        // tribbles
        if tribblesOnBoard {
            // increment number of tribbles
            player.commanderShip.tribbles += 50 + Int(Double(player.commanderShip.tribbles) * 0.3)
            print("new number of tribbles: \(player.commanderShip.tribbles)")
            
            // if food on board, more tribbles, tribbles eat food, alert
            if player.commanderShip.foodOnBoard >= 1 {
                let oldFood = player.commanderShip.foodOnBoard      // DEBUG ONLY
                player.commanderShip.tribbles += player.commanderShip.foodOnBoard * 400
                player.commanderShip.foodOnBoard -= Int(Double(player.commanderShip.foodOnBoard) * 0.3)
                galaxy.alertsToFireOnArrival.append(AlertID.tribblesAteFood)
                print("tribbles ate food. Food was \(oldFood), now \(player.commanderShip.foodOnBoard), tribbles now \(player.commanderShip.tribbles).")
            }
            
            // if narcotics on board, fewer tribbles, tribbles eat narcotics, alert
            if player.commanderShip.narcoticsOnBoard >= 1 {
                let oldNarc = player.commanderShip.narcoticsOnBoard         // DEBUG ONLY
                player.commanderShip.tribbles -= player.commanderShip.narcoticsOnBoard * 400
                player.commanderShip.narcoticsOnBoard -= Int(Double(player.commanderShip.narcoticsOnBoard) * 0.3)
                galaxy.alertsToFireOnArrival.append(AlertID.tribblesMostDead)
                print("tribbles ate narcotics. Food was \(oldNarc), now \(player.commanderShip.narcoticsOnBoard), tribbles now \(player.commanderShip.tribbles).")
            }
            
            // if over 100k, cap
            if player.commanderShip.tribbles > 100000 {
                player.commanderShip.tribbles = 100000
            }
        }
        
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.special = decoder.decodeBool(forKey: "special")
        self.specialEventTitle = decoder.decodeObject(forKey: "specialEventTitle") as! String
        self.specialEventText = decoder.decodeObject(forKey: "specialEventText") as! String
        self.yesDismissButtonText = decoder.decodeObject(forKey: "yesDismissButtonText") as! String
        self.noButtonText = decoder.decodeObject(forKey: "noButtonText") as! String
        self.yesDismissButtonEnabled = decoder.decodeBool(forKey: "yesDismissButtonEnabled")
        self.noButtonEnabled = decoder.decodeBool(forKey: "noButtonEnabled")
        
        self.quests = decoder.decodeObject(forKey: "quests") as! [Quest]
        
        self.artifactOnBoard = decoder.decodeBool(forKey: "artifactOnBoard")
        self.wildOnBoard = decoder.decodeBool(forKey: "wildOnBoard")
        self.reactorOnBoard = decoder.decodeBool(forKey: "reactorOnBoard")
        self.tribblesOnBoard = decoder.decodeBool(forKey: "tribblesOnBoard")
        
        self.experimentCountdown = decoder.decodeInteger(forKey: "experimentCountdown")
        self.jarekElapsedTime = decoder.decodeInteger(forKey: "jarekElapsedTime")
        self.gemulonInvasionCountdown = decoder.decodeInteger(forKey: "gemulonInvasionCountdown")
        self.reactorElapsedTime = decoder.decodeInteger(forKey: "reactorElapsedTime")
        self.wildElapsedTime = decoder.decodeInteger(forKey: "wildElapsedTime")
        self.princessElapsedTime = decoder.decodeInteger(forKey: "princessElapsedTime")
        self.marieCelesteStatus = decoder.decodeInteger(forKey: "marieCelesteStatus")
        
        if let currentSpecialEventIDRaw = decoder.decodeObject(forKey: "currentSpecialEventID") {
            self.currentSpecialEventID = SpecialEventID(rawValue: currentSpecialEventIDRaw as! Int)
        }
        
        self.captainAhabHappened = decoder.decodeBool(forKey: "captainAhabHappened")
        self.captainConradHappened = decoder.decodeBool(forKey: "captainConradHappened")
        self.captainHuieHappened = decoder.decodeBool(forKey: "captainHuieHappened")

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(special, forKey: "special")
        encoder.encode(specialEventTitle, forKey: "specialEventTitle")
        encoder.encode(specialEventText, forKey: "specialEventText")
        encoder.encode(yesDismissButtonText, forKey: "yesDismissButtonText")
        encoder.encode(noButtonText, forKey: "noButtonText")
        encoder.encode(yesDismissButtonEnabled, forKey: "yesDismissButtonEnabled")
        encoder.encode(noButtonEnabled, forKey: "noButtonEnabled")
        
        encoder.encode(quests, forKey: "quests")
        
        encoder.encode(artifactOnBoard, forKey: "artifactOnBoard")
        encoder.encode(wildOnBoard, forKey: "wildOnBoard")
        encoder.encode(reactorOnBoard, forKey: "reactorOnBoard")
        encoder.encode(tribblesOnBoard, forKey: "tribblesOnBoard")
        
        encoder.encode(experimentCountdown, forKey: "experimentCountdown")
        encoder.encode(jarekElapsedTime, forKey: "jarekElapsedTime")
        encoder.encode(gemulonInvasionCountdown, forKey: "gemulonInvasionCountdown")
        encoder.encode(reactorElapsedTime, forKey: "reactorElapsedTime")
        encoder.encode(wildElapsedTime, forKey: "wildElapsedTime")
        encoder.encode(princessElapsedTime, forKey: "princessElapsedTime")
        encoder.encode(marieCelesteStatus, forKey: "marieCelesteStatus")
        
        encoder.encode(currentSpecialEventID?.rawValue, forKey: "currentSpecialEventID")
        
        encoder.encode(captainAhabHappened, forKey: "captainAhabHappened")
        encoder.encode(captainConradHappened, forKey: "captainConradHappened")
        encoder.encode(captainHuieHappened, forKey: "captainHuieHappened")
    }
    
}


enum SpecialEventID: Int {
    // to be distributed at new game
    case alienArtifact = 0
    case dragonfly
    case dangerousExperiment
    case gemulonInvasion
    case japoriDisease
    case ambassadorJarek
    case princess
    case moonForSale
    case morgansReactor
    case scarabStolen
    case sculpture
    case spaceMonster
    case wild
    case merchantPrice
    case eraseRecord
    case lotteryWinner      // for initial system on beginner
    case skillIncrease      // multiple?
    case cargoForSale       // multiple?
    
    
    // subsequent
    case artifactDelivery
    case dragonflyBaratas
    case dragonflyMelina
    case dragonflyRegulas
    case dragonflyDestroyed
    case lightningShield
    case disasterAverted
    case experimentFailed
    case gemulonInvaded
    case gemulonRescued
    case fuelCompactor
    case medicineDelivery
    case jarekGetsOut
    case princessCentauri
    case princessInthara
    case princessRescued
    case princessQonos
    case princessReturned
    case installQuantumDisruptor
    case retirement
    case reactorDelivered
    case installMorgansLaser
    case scarabDestroyed
    case upgradeHull
    case sculptureDelivered
    case installHiddenCompartments
    case monsterKilled
    case wildGetsOut
    case tribbleBuyer
}

enum QuestID: Int {
    case artifact = 0
    case dragonfly
    case experiment
    case gemulon
    case japori
    case jarek
    case princess
    case moon
    case reactor
    case scarab
    case sculpture
    case spaceMonster
    case tribbles
    case wild
}

class Quest: NSObject, NSCoding {
    let ID: QuestID
    var questString: String
    var completed = false
    
    init(ID: QuestID, questString: String) {
        self.ID = ID
        self.questString = questString
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.ID = QuestID(rawValue: decoder.decodeInteger(forKey: "ID"))!
        self.questString = decoder.decodeObject(forKey: "questString") as! String
        self.completed = decoder.decodeBool(forKey: "completed")

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(ID.rawValue, forKey: "ID")
        encoder.encode(questString, forKey: "questString")
        encoder.encode(completed, forKey: "completed")
    }
}

