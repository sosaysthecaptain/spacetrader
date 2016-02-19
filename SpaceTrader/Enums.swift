//
//  Enums.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/7/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

enum TechLevelType: String {
    case techLevel0 = "Pre-agricultural"
    case techLevel1 = "Agricultural"
    case techLevel2 = "Medieval"
    case techLevel3 = "Renaissance"
    case techLevel4 = "Early Industrial"
    case techLevel5 = "Industrial"
    case techLevel6 = "Post-industrial"
    case techLevel7 = "Hi-tech"
    case techLevel8 = "Unavailable"
}

enum TradeItemType: String {
    case Water = "Water"
    case Furs = "Furs"
    case Food = "Food"
    case Ore = "Ore"
    case Games = "Games"
    case Firearms = "Firearms"
    case Medicine = "Medicine"
    case Machines = "Machines"
    case Narcotics = "Narcotics"
    case Robots = "Robots"
    case None = "NONE"
}

enum StatusType: String {
    case none = "under no particular pressure"
    case war = "at war"
    case plague = "ravaged by a plague"
    case drought = "suffering from a drought"
    case boredom = "suffering from extreme boredom"
    case cold = "suffering from a cold spell"
    case cropFailure = "suffering from a crop failure"
    case employment = "lacking enough workers"
}

enum PoliceRecordType: Int {
    case psychopathScore = 0
    case villainScore
    case criminalScore
    case crookScore
    case dubiousScore
    case cleanScore
    case lawfulScore
    case trustedScore
    case likedScore
    case heroScore
}

func getPoliceRecordForInt(policeRecord: Int) -> String {
    switch policeRecord {
    case 0:
        return "Psychopath"
    case 1:
        return "Villian"
    case 2:
        return "Criminal"
    case 3:
        return "Crook"
    case 4:
        return "Dubious"
    case 5:
        return "Clean"
    case 6:
        return "Lawful"
    case 7:
        return "Trusted"
    case 8:
        return "Liked"
    case 9:
        return "Hero"
    default:
        return "error"
    }
}

enum ReputationType: Int {
    case harmlessRep = 0
    case mostlyHarmlessRep
    case poorRep
    case averageRep
    case aboveAverageRep
    case competentRep
    case dangerousRep
    case deadlyRep
    case eliteRep
}

func getReputationForInt(reputation: Int) -> String {
    switch reputation {
    case 0:
        return "Harmless"
    case 1:
        return "Mostly Harmless"
    case 2:
        return "Poor"
    case 3:
        return "Average"
    case 4:
        return "Above Average"
    case 5:
        return "Competent"
    case 6:
        return "Dangerous"
    case 7:
        return "Deadly"
    case 8:
        return "Elite"
    default:
        return "error"
    }
}

enum DifficultyType: String {
    case beginner = "Beginner"
    case easy = "Easy"
    case normal = "Normal"
    case hard = "Hard"
    case impossible = "Impossible"
}

enum SpecialResourcesType: String {
    case nothingSpecial = "Nothing special"
    case mineralRich = "Mineral rich"
    case mineralPoor = "Mineral poor"
    case desert = "Desert"
    case lotsOfWater = "Sweetwater oceans"
    case richSoil = "Rich soil"
    case poorSoil = "Poor soil"
    case richFauna = "Rich fauna"
    case lifeless = "Lifeless"
    case weirdMushrooms = "Weird mushrooms"
    case specialHerbs = "Special herbs"
    case artisticPopulace = "Artistic populace"
    case warlikePopulace = "Warlike populace"
    case none = "None in particular"
}

enum Activity: String {
    case absent = "Absent"
    case minimal = "Minimal"
    case few = "Few"
    case some = "Some"
    case moderate = "Moderate"
    case many = "Many"
    case abundant = "Abundant"
    case swarms = "Swarms"
}

enum MercenaryName: String {
    case alyssa = "Alyssa"
    case armatur = "Armatur"
    case bentos = "Bentos"
    case c2u2 = "C2U2"
    case chiti = "Chi'Ti"
    case crystal = "Crystal"
    case dane = "Dane"
    case deirdre = "Deirdre"
    case doc = "Doc"
    case draco = "Draco"
    case iranda = "Iranda"
    case jeremiah = "Jeremiah"
    case jujubal = "Jujubal"
    case krydon = "Krydon"
    case luis = "Luis"
    case mercedez = "Mercedez"
    case milete = "Milete"
    case muril = "Muri-L"
    case mystyc = "Mystyc"
    case nandi = "Nandi"
    case orestes = "Orestes"
    case pancho = "Pancho"
    case ps37 = "PS37"
    case quarck = "Quarck"
    case sosumi = "Sosumi"
    case uma = "Uma"
    case wesley = "Wesley"
    case wonton = "Wonton"
    case yorvick = "Yorvick"
    case zeethibal = "Zeethibal"
    // special
    case jarek = "Jarek"
    case wild = "Jonathan Wild"
    case ziyal = "Princess Ziyal"
    case null = "Null"
}

enum StarSystemID {
    case Acamar
    case Adahn          // The alternate personality for The Nameless One in "Planescape: Torment"
    case Aldea
    case Andevian
    case Antedi
    case Balosnee
    case Baratas
    case Brax			// One of the heroes in Master of Magic
    case Bretel         // This is a Dutch device for keeping your pants up.
    case Calondia
    case Campor
    case Capelle		// The city I lived in while programming this game
    case Carzon
    case Castor         // A Greek demi-god
    case Centauri
    case Cestus
    case Cheron
    case Courteney      // After Courteney Cox...
    case Daled
    case Damast
    case Davlos
    case Deneb
    case Deneva
    case Devidia
    case Draylon
    case Drema
    case Endor
    case Esmee          // One of the witches in Pratchett's Discworld
    case Exo
    case Ferris         // Iron
    case Festen         // A great Scandinavian movie
    case Fourmi         // An ant, in French
    case Frolix         // A solar system in one of Philip K. Dick's novels
    case Gemulon
    case Guinifer		// One way of writing the name of king Arthur's wife
    case Hades          // The underworld
    case Hamlet         // From Shakespeare
    case Helena         // Of Troy
    case Hulst          // A Dutch plant
    case Iodine         // An element
    case Iralius
    case Janus          // A seldom encountered Dutch boy's name
    case Japori
    case Jarada
    case Jason          // A Greek hero
    case Kaylon
    case Khefka
    case Kira			// My dog's name
    case Klaatu         // From a classic SF movie
    case Klaestron
    case Korma          // An Indian sauce
    case Kravat         // Interesting spelling of the French word for "tie"
    case Krios
    case Laertes		// A king in a Greek tragedy
    case Largo
    case Lave			// The starting system in Elite
    case Ligon
    case Lowry          // The name of the "hero" in Terry Gilliam's "Brazil"
    case Magrat         // The second of the witches in Pratchett's Discworld
    case Malcoria
    case Melina
    case Mentar         // The Psilon home system in Master of Orion
    case Merik
    case Mintaka
    case Montor         // A city in Ultima III and Ultima VII part 2
    case Mordan
    case Myrthe         // The name of my daughter
    case Nelvana
    case Nix			// An interesting spelling of a word meaning "nothing" in Dutch
    case Nyle			// An interesting spelling of the great river
    case Odet
    case Og             // The last of the witches in Pratchett's Discworld
    case Omega          // The end of it all
    case Omphalos		// Greek for navel
    case Orias
    case Othello		// From Shakespeare
    case Parade         // This word means the same in Dutch and in English
    case Penthara
    case Picard         // The enigmatic captain from ST:TNG
    case Pollux         // Brother of Castor
    case Quator
    case Rakhar
    case Ran			// A film by Akira Kurosawa
    case Regulas
    case Relva
    case Rhymus
    case Rochani
    case Rubicum		// The river Ceasar crossed to get into Rome
    case Rutia
    case Sarpeidon
    case Sefalla
    case Seltrice
    case Sigma
    case Sol			// That's our own solar system
    case Somari
    case Stakoron
    case Styris
    case Talani
    case Tamus
    case Tantalos		// A king from a Greek tragedy
    case Tanuga
    case Tarchannen
    case Terosa
    case Thera          // A seldom encountered Dutch girl's name
    case Titan          // The largest moon of Saturn
    case Torin          // A hero from Master of Magic
    case Triacus
    case Turkana
    case Tyrus
    case Umberlee		// A god from AD&D, which has a prominent role in Baldur's Gate
    case Utopia         // The ultimate goal
    case Vadera
    case Vagra
    case Vandor
    case Ventax
    case Xenon
    case Xerxes         // A Greek hero
    case Yew			// A city which is in almost all of the Ultima games
    case Yojimbo		// A film by Akira Kurosawa
    case Zalkon
    case Zuul			// From the first Ghostbusters movie
}

enum SizeType: String {
    case Tiny = "Tiny"
    case Small = "Small"
    case Medium = "Medium"
    case Large = "Large"
    case Huge = "Huge"
}

//enum SpecialEventType: String {
//    case QuestDragonflyDestroyed = "Dragonfly Destroyed"
//    case QuestWeirdShip = "Weird Ship"
//    case QuestLightningShip = "Lightning Ship"
//    case QuestStrangeShip = "Strange Ship"
//    case QuestMonsterKilled = "Monster Killed"
//    case 

//    { "Dragonfly Destroyed",	QuestDragonflyDestroyedString,		0, 0, true },
//    { "Weird Ship",				QuestWeirdShipString,				0, 0, true },
//    { "Lightning Ship",			QuestLightningShipString,			0, 0, true },
//    { "Strange Ship",			QuestStrangeShipString,				0, 0, true },
//    { "Monster Killed", 		QuestMonsterKilledString, 	   -15000, 0, true },
//    { "Medicine Delivery", 		QuestMedicineDeliveredString,		0, 0, true },
//    { "Retirement",     		QuestRetirementString,				0, 0, false },
//    { "Moon For Sale",  		QuestMoonForSaleString, 	 COSTMOON, 4, false },
//    { "Skill Increase", 		QuestSkillIncreaseString,		 3000, 3, false },
//    { "Merchant Prince",		QuestMerchantPrinceString,		 1000, 1, false },
//    { "Erase Record",   		QuestEraseRecordString,			 5000, 3, false },
//    { "Tribble Buyer",  		QuestTribbleBuyerString, 			0, 3, false },
//    { "Space Monster",  		QuestSpaceMonsterString, 			0, 1, true },
//    { "Dragonfly",      		QuestDragonflyString, 				0, 1, true },
//    { "Cargo For Sale", 		QuestCargoForSaleString, 	 	 1000, 3, false },
//    { "Lightning Shield", 		QuestLightningShieldString,	 		0, 0, false },
//    { "Japori Disease", 		QuestJaporiDiseaseString, 			0, 1, false },
//    { "Lottery Winner", 		QuestLotteryWinnerString, 		-1000, 0, true },
//    { "Artifact Delivery", 		QuestArtifactDeliveryString,	-20000, 0, true },
//    { "Alien Artifact", 		QuestAlienArtifactString, 			0, 1, false },
//    { "Ambassador Jarek", 		QuestAmbassadorJarekString,		 	0, 1, false },
//    { "Alien Invasion",			QuestAlienInvasionString,		 	0, 0, true },
//    { "Gemulon Invaded", 		QuestGemulonInvadedString, 			0, 0, true },
//    { "Fuel Compactor", 		QuestFuelCompactorString, 			0, 0, false },
//    { "Dangerous Experiment",   QuestDangerousExperimentString,		0, 0, true },
//    { "Jonathan Wild",  		QuestJonathanWildString, 			0, 1, false },
//    { "Morgan's Reactor",  		QuestMorgansReactorString,	 		0, 0, false },
//    { "Install Morgan's Laser", QuestInstallMorgansLaserString,	 	0, 0, false },
//    { "Scarab Stolen", 		QuestScarabStolenString,		 	0, 1, true},
//    { "Upgrade Hull", 			QuestUpgradeHullString, 			0, 0, false},
//    { "Scarab Destroyed", 	QuestScarabDestroyedString,	 	0, 0, true},
//    { "Reactor Delivered",  	QuestReactorDeliveredString, 		0, 0, true },
//    { "Jarek Gets Out",			QuestJarekGetsOutString, 			0, 0, true },
//    { "Gemulon Rescued", 		QuestGemulonRescuedString,	 		0, 0, true },
//    { "Disaster Averted",		QuestDisasterAvertedString,			0, 0, true },
//    { "Experiment Failed",		QuestExperimentFailedString, 		0, 0, true },
//    { "Wild Gets Out",          QuestWildGetsOutString,


enum MonsterStatusType {
    
}

enum DragonflyStatusType {
    
}

enum JaporiDiseaseStatusType {
    
}

enum MoonBoughtStatus {
    // only needed if more than one possibility
}

enum JarekStatusType {
    
}

enum ExperimentAndWildStatusType {
    
}

enum FabricRipProbabilityType {
    
}

enum VeryRareEncounterType {

}

enum ReactorStatusType {
    
}

enum ScarabStatusType {
    
}

enum ShipType: Int {
    case Flea = 0
    case Gnat
    case Firefly
    case Mosquito
    case Bumblebee
    case Beetle
    case Hornet
    case Grasshopper
    case Termite
    case Wasp
    case Custom
    // non-player ships
    case SpaceMonster
    case Dragonfly
    case Mantis
    case Scarab
    case Scorpion
    case Bottle
}

enum EndGameStatus: Int {
    case GameNotOver = 0
    case Killed
    case Retired
    case BoughtMoon
    case BoughtMoonGirl
}

enum IFFStatusType: String {
    case Player = "player"
    case Police = "police"
    case Pirate = "pirate"
    case Trader = "trader"
    case Mantis = "mantis"
    case Dragonfly = "dragonfly"
    case SpaceMonster = "space monster"
    case Scarab = "scarab"
    case Scorpion = "scorpion"
    case MarieCeleste = "Marie Celeste"
    case FamousCaptain = "famous captain"
    case Bottle = "bottle"
    case Null = "null"
}

enum GadgetType: Int {
    case CargoBays = 0
    case AutoRepair
    case Navigation
    case Targeting
    case Cloaking
    // not for sale:
    case FuelCompactor
    case HBays
}

enum WeaponType: Int {
    case pulseLaser = 0
    case beamLaser
    case militaryLaser
    case morgansLaser
    case photonDisruptor
    case quantumDisruptor
}

enum ShieldType: Int {
    case energyShield = 0
    case reflectiveShield
    // not for sale:
    case lightningShield
}

// Hi! I'm a kludge!
enum UniversalGadgetType {
    case pulseLaser
    case beamLaser
    case militaryLaser
    case morgansLaser       // not for sale
    case photonDisruptor
    case CargoBays
    case AutoRepair
    case Navigation
    case Targeting
    case Cloaking
    case FuelCompactor      // not for sale
    case energyShield
    case reflectiveShield
    case lightningShield    // not for sale
}

enum PoliticsType: String {
    case anarchy = "Anarchy"
    case capitalist = "Capitalist State"
    case communist = "Communist State"
    case confederacy = "Confederacy"
    case corporate = "Corporate State"
    case cybernetic = "Cybernetic State"
    case democracy = "Democracy"
    case dictatorship = "Dictatorship"
    case fascist = "Fascist State"
    case feudal = "Feudal State"
    case military = "Military State"
    case monarchy = "Monarchy"
    case pacifist = "Pacifist State"
    case socialist = "Socialist State"
    case satori = "State of Satori"
    case technocracy = "Technocracy"
    case theocracy = "Theocracy"
}

enum EncounterType: Int {           // needs a raw value for NSCoding
    case policeInspection = 0
    case postMariePoliceEncounter
    case policeFlee
    case traderFlee
    case pirateFlee
    case pirateAttack
    case policeAttack
    case policeSurrenderDemand
    case scarabAttack
    case famousCapAttack
    case spaceMonsterAttack
    case dragonflyAttack
    case traderIgnore
    case traderAttack
    case policeIgnore
    case pirateIgnore
    case spaceMonsterIgnore
    case dragonflyIgnore
    case scarabIgnore
    case traderSurrender
    case pirateSurrender
    case marieCelesteEncounter
    case bottleGoodEncounter
    case bottleOldEncounter
    case traderSell
    case traderBuy
    case mantisAttack
    case nullEncounter
}

enum ShipyardID: String {
    case NA = "N/A"
    case corellian = "Corellian Industries"
    case incom = "Incom Corporation"
    case kuat = "Kuat Drive Yards"
    case sienar = "Sienar Fleet Systems"
    case sorosuub = "Sorosuub Engineering"
}

enum SpecialCargo: String {
    case artifact = "An alien artifact."
    case experiment = "A portable singularity."
    case japori = "10 bays of antidote."
    case jarek = "A portable haggling computer."
    case none = "No special items."
    case reactor = "An unstable reactor taking up 5 bays."
    case sculpture = "A stolen plastic sculpture of a man holding some kind of light sword."
    case reactorBays = "**** bays of enriched fuel."
    case tribblesInfestation = "An infestation of tribbles."
    case tribblesCute = "cute, furry tribble"
}

func getIFFStatusTypeforEncounterType(encounterType: EncounterType) -> IFFStatusType {
    if (encounterType == EncounterType.policeAttack) || (encounterType == EncounterType.policeFlee) || (encounterType == EncounterType.policeIgnore) || (encounterType == EncounterType.policeInspection) || (encounterType == EncounterType.policeSurrenderDemand) {
        return IFFStatusType.Police
    } else if (encounterType == EncounterType.pirateAttack) || (encounterType == EncounterType.pirateFlee) || (encounterType == EncounterType.pirateIgnore) || (encounterType == EncounterType.pirateSurrender) {
        return IFFStatusType.Pirate
    } else if (encounterType == EncounterType.traderBuy) || (encounterType == EncounterType.traderFlee) || (encounterType == EncounterType.traderIgnore) || (encounterType == EncounterType.traderSell) || (encounterType == EncounterType.traderSurrender) {
        return IFFStatusType.Trader
    } else if (encounterType == EncounterType.mantisAttack) {
        return IFFStatusType.Mantis
    } else if (encounterType == EncounterType.dragonflyAttack) || (encounterType == EncounterType.dragonflyIgnore) {
        return IFFStatusType.Dragonfly
    } else if (encounterType == EncounterType.spaceMonsterAttack) || (encounterType == EncounterType.spaceMonsterIgnore) {
        return IFFStatusType.SpaceMonster
    } else if (encounterType == EncounterType.dragonflyAttack) || (encounterType == EncounterType.dragonflyIgnore) {
        return IFFStatusType.Dragonfly
    } else if (encounterType == EncounterType.scarabAttack) || (encounterType == EncounterType.scarabIgnore) {
        return IFFStatusType.Scarab
    } else if (encounterType == EncounterType.marieCelesteEncounter) {
        return IFFStatusType.MarieCeleste
    } else if (encounterType == EncounterType.famousCapAttack) { // really all?
        return IFFStatusType.FamousCaptain
    } else if (encounterType == EncounterType.bottleGoodEncounter) || (encounterType == EncounterType.bottleOldEncounter) {
        return IFFStatusType.Bottle
    } else {
        return IFFStatusType.Null
    }
}

