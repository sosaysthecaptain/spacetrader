//
//  StarSystem.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/6/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import Foundation

// NOT DONE, COMMENTED OUT SO WON'T INTERFERE

class StarSystem: NSObject, NSCoding {
    var name: String
    var techLevel: TechLevelType
    var politics: PoliticsType
    var status: StatusType
    var xCoord: Int = 0 
    var yCoord: Int = 0
    var specialResources: SpecialResourcesType
    var size: SizeType
    // trade items?
    var countdown: Int = 1                  // does this need a special initializer?
    var visited: Bool = false
    var wormhole: Bool = false
    var wormholeDestination: StarSystem? = nil
    var indexNumber: Int = 200
    //var special: SpecialEventType
    var mercenaries: [CrewMember] = []
    var newspaper: Newspaper = Newspaper()
    var newsItemDropBox: NewsItemID?
    
    var shipyard: ShipyardID = ShipyardID.NA
    var shipyardEngineer: ShipyardEngineers = ShipyardEngineers.na
    var shipyardSkill: ShipyardSkills = ShipyardSkills.na
    var shipyardSizeSpecialty: SizeType = SizeType.Small
    
    var specialEvent: SpecialEventID? {
        didSet {
            print("\(name)'s specialEvent set to \(specialEvent)")
        }
    }
    
    var costOfNewspaper: Int {
        return player.difficultyInt + 1
    }
    
    var locationChecked = false
    
    var scarabIsHere = false
    var dragonflyIsHere = false
    var swarmingWithAliens = false
    var spaceMonsterIsHere = false
    var scorpionIsHere = false

    // quantities and prices
    var water: Int = 0
    var furs: Int = 0
    var food: Int = 0
    var ore: Int = 0
    var games: Int = 0
    var firearms: Int = 0
    var medicine: Int = 0
    var machines: Int = 0
    var narcotics: Int = 0
    var robots: Int = 0
    
    var waterBuy: Int = 0
    var fursBuy: Int = 0
    var foodBuy: Int = 0
    var oreBuy: Int = 0
    var gamesBuy: Int = 0
    var firearmsBuy: Int = 0
    var medicineBuy: Int = 0
    var machinesBuy: Int = 0
    var narcoticsBuy: Int = 0
    var robotsBuy: Int = 0
    var waterSell: Int = 0
    var fursSell: Int = 0
    var foodSell: Int = 0
    var oreSell: Int = 0
    var gamesSell: Int = 0
    var firearmsSell: Int = 0
    var medicineSell: Int = 0
    var machinesSell: Int = 0
    var narcoticsSell: Int = 0
    var robotsSell: Int = 0
    
    var techLevelInt: Int {
        get {
            switch self.techLevel {
            case .techLevel0:
                return 0
            case .techLevel1:
                return 1
            case .techLevel2:
                return 2
            case .techLevel3:
                return 3
            case .techLevel4:
                return 4
            case .techLevel5:
                return 5
            case .techLevel6:
                return 6
            case .techLevel7:
                return 7
            case .techLevel8:
                return 8
            }
        }
    }
    
    var localNewspaperTitle: String {
        get {
            switch self.politics {
            case PoliticsType.anarchy:
                switch newspaperOption {
                case 0: return "The \(self.name) Arsenal"
                case 1: return "The Grassroot"
                case 2: return "Kick it!"
                default: return ""
                }
            case PoliticsType.capitalist:
                switch newspaperOption {
                case 0: return "The Objectivist"
                case 1: return "The \(self.name) Market"
                case 2: return "The Invisible Hand"
                default: return ""
                }
            case PoliticsType.communist:
                switch newspaperOption {
                case 0: return "The Daily Worker"
                case 1: return "The People's Voice"
                case 2: return "The \(self.name) Proletariat"
                default: return ""
                }
            case PoliticsType.confederacy:
                switch newspaperOption {
                case 0: return "Planet News"
                case 1: return "The \(self.name) Times"
                case 2: return "Interstate Update"
                default: return ""
                }
            case PoliticsType.corporate:
                switch newspaperOption {
                case 0: return "\(self.name) Memo"
                case 1: return "News From the Board"
                case 2: return "Status Report"
                default: return ""
                }
            case PoliticsType.cybernetic:
                switch newspaperOption {
                case 0: return "Pulses"
                case 1: return "Binary Stream"
                case 2: return "The System Clock"
                default: return ""
                }
            case PoliticsType.democracy:
                switch newspaperOption {
                case 0: return "The Daily Planet"
                case 1: return "The \(self.name) Majority"
                case 2: return "Unanimity"
                default: return ""
                }
            case PoliticsType.dictatorship:
                switch newspaperOption {
                case 0: return "The Command"
                case 1: return "Leader's Voice"
                case 2: return "The \(self.name) Mandate"
                default: return ""
                }
            case PoliticsType.fascist:
                switch newspaperOption {
                case 0: return "State Tribune"
                case 1: return "Motherland News"
                case 2: return "Homeland Report"
                default: return ""
                }
            case PoliticsType.feudal:
                switch newspaperOption {
                case 0: return "News from the Keep"
                case 1: return "The Town Crier"
                case 2: return "The \(self.name) Herald"
                default: return ""
                }
            case PoliticsType.military:
                switch newspaperOption {
                case 0: return "General Report"
                case 1: return "\(self.name) Dispatch"
                case 2: return "The \(self.name) Sentry"
                default: return ""
                }
            case PoliticsType.monarchy:
                switch newspaperOption {
                case 0: return "Royal Times"
                case 1: return "The Loyal Subject"
                case 2: return "The Fanfare"
                default: return ""
                }
            case PoliticsType.pacifist:
                switch newspaperOption {
                case 0: return "Pax Humani"
                case 1: return "Principle"
                case 2: return "The \(self.name) Chorus"
                default: return ""
                }
            case PoliticsType.satori:
                switch newspaperOption {
                case 0: return "All for One"
                case 1: return "Brotherhood"
                case 2: return "The People's Syndicate"
                default: return ""
                }
            case PoliticsType.socialist:
                switch newspaperOption {
                case 0: return "The Daily Worker"
                case 1: return "Justice"
                case 2: return "The People's Daily"
                default: return ""
                }
            case PoliticsType.technocracy:
                switch newspaperOption {
                case 0: return "The Future"
                case 1: return "Hardware Dispatch"
                case 2: return "TechNews"
                default: return ""
                }
            case PoliticsType.theocracy:
                switch newspaperOption {
                case 0: return "The Spiritual Advisor"
                case 1: return "Church Tidings"
                case 2: return "The Temple Tribune"
                default: return ""
                }
            }
            
        }
    }
    var newspaperOption: Int = rand(3)
    
    init(name: String, techLevel: TechLevelType, politics: PoliticsType, status: StatusType, xCoord: Int, yCoord: Int, specialResources: SpecialResourcesType, size: SizeType) {
        self.name = name
        self.techLevel = techLevel
        self.politics = politics
        self.status = status
        self.xCoord = xCoord
        self.yCoord = yCoord
        self.specialResources = specialResources
        self.size = size
        self.countdown = Int(arc4random_uniform(6))
        self.visited = false
    }
    
    // GETBUYPRICE, GETSELLPRICE, GETQUANTITYAVAILABLE**************************************************
    
    func getBuyPrice(_ commodity: TradeItemType) -> Int {
        var buyPrice = 0
        
        switch commodity {
            case TradeItemType.Water:
                buyPrice = waterBuy
            case TradeItemType.Furs:
                buyPrice = fursBuy
            case TradeItemType.Food:
                buyPrice = foodBuy
            case TradeItemType.Ore:
                buyPrice = oreBuy
            case TradeItemType.Games:
                buyPrice = gamesBuy
            case TradeItemType.Firearms:
                buyPrice = firearmsBuy
            case TradeItemType.Medicine:
                buyPrice = medicineBuy
            case TradeItemType.Machines:
                buyPrice = machinesBuy
            case TradeItemType.Narcotics:
                buyPrice = narcoticsBuy
            case TradeItemType.Robots:
                buyPrice = robotsBuy
            default:
                buyPrice = 0
        }
        
        return buyPrice
    }
    
    func getSellPrice(_ commodity: TradeItemType) -> Int {
        var sellPrice = 0
        
        switch commodity {
        case TradeItemType.Water:
            sellPrice = waterSell
        case TradeItemType.Furs:
            sellPrice = fursSell
        case TradeItemType.Food:
            sellPrice = foodSell
        case TradeItemType.Ore:
            sellPrice = oreSell
        case TradeItemType.Games:
            sellPrice = gamesSell
        case TradeItemType.Firearms:
            sellPrice = firearmsSell
        case TradeItemType.Medicine:
            sellPrice = medicineSell
        case TradeItemType.Machines:
            sellPrice = machinesSell
        case TradeItemType.Narcotics:
            sellPrice = narcoticsSell
        case TradeItemType.Robots:
            sellPrice = robotsSell
        default:
            sellPrice = 0
        }
        
        return sellPrice
    }
    
    func getQuantityAvailable(_ commodity: TradeItemType) -> Int {
        var quantity = 0
        
        switch commodity {
        case TradeItemType.Water:
            quantity = water
        case TradeItemType.Furs:
            quantity = furs
        case TradeItemType.Food:
            quantity = food
        case TradeItemType.Ore:
            quantity = ore
        case TradeItemType.Games:
            quantity = games
        case TradeItemType.Firearms:
            quantity = firearms
        case TradeItemType.Medicine:
            quantity = medicine
        case TradeItemType.Machines:
            quantity = machines
        case TradeItemType.Narcotics:
            quantity = narcotics
        case TradeItemType.Robots:
            quantity = robots
        default:
            quantity = 0
        }
        
        return quantity
    }
    
    
    
    // END PRICE/AVAILABILITY METHODS*******************************************************************
    // MODIFY QUANTITY AMOUNT
    func modifyQuantities(_ commodity: TradeItemType, quantity: Int, addAsOpposedToRemove: Bool) {
        var quantity = quantity
        
        if !addAsOpposedToRemove {
            quantity = quantity * -1
        }
        
        switch commodity {
        case TradeItemType.Water:
            galaxy.currentSystem!.water += quantity
        case TradeItemType.Furs:
            galaxy.currentSystem!.furs += quantity
        case TradeItemType.Food:
            galaxy.currentSystem!.food += quantity
        case TradeItemType.Ore:
            galaxy.currentSystem!.ore += quantity
        case TradeItemType.Games:
            galaxy.currentSystem!.games += quantity
        case TradeItemType.Firearms:
            galaxy.currentSystem!.firearms += quantity
        case TradeItemType.Medicine:
            galaxy.currentSystem!.medicine += quantity
        case TradeItemType.Machines:
            galaxy.currentSystem!.machines += quantity
        case TradeItemType.Narcotics:
            galaxy.currentSystem!.narcotics += quantity
        case TradeItemType.Robots:
            galaxy.currentSystem!.robots += quantity
        default:
            galaxy.currentSystem!.water += 0
        }
    }
    
    // NSCODING METHODS
        required init(coder decoder: NSCoder) {
            self.name = decoder.decodeObject(forKey: "name") as! String
            self.techLevel = TechLevelType(rawValue: decoder.decodeObject(forKey: "techLevel") as! String!)!
            self.politics = PoliticsType(rawValue: decoder.decodeObject(forKey: "politics") as! String!)!
            self.status = StatusType(rawValue: decoder.decodeObject(forKey: "status") as! String!)!
            self.xCoord = decoder.decodeInteger(forKey: "xCoord")
            self.yCoord = decoder.decodeInteger(forKey: "yCoord")
            self.specialResources = SpecialResourcesType(rawValue: decoder.decodeObject(forKey: "specialResources") as! String!)!
            self.size = SizeType(rawValue: decoder.decodeObject(forKey: "size") as! String!)!
            self.countdown = decoder.decodeInteger(forKey: "countdown")
            self.visited = decoder.decodeBool(forKey: "visited")
            self.wormhole = decoder.decodeBool(forKey: "wormhole")
            
            self.wormholeDestination = decoder.decodeObject(forKey: "wormholeDestination") as! StarSystem?
            
            self.indexNumber = decoder.decodeInteger(forKey: "indexNumber")
            self.mercenaries = decoder.decodeObject(forKey: "mercenaries") as! [CrewMember]
            self.newspaper = decoder.decodeObject(forKey: "newspaper") as! Newspaper
            if let newsItemDropBoxRaw = decoder.decodeObject(forKey: "newsItemDropBox") as! Int! {
                self.newsItemDropBox = NewsItemID(rawValue: newsItemDropBoxRaw)
            }
            
            if let specialEventRaw = decoder.decodeObject(forKey: "specialEvent") as! Int! {
                self.specialEvent = SpecialEventID(rawValue: specialEventRaw)
            }
            if let shipyardRaw = decoder.decodeObject(forKey: "shipyard") as! String! {
                self.shipyard = ShipyardID(rawValue: shipyardRaw)!
            }
            if let shipyardEngineerRaw = decoder.decodeObject(forKey: "shipyardEngineer") as! String! {
                self.shipyardEngineer = ShipyardEngineers(rawValue: shipyardEngineerRaw)!
            }
            if let shipyardSkillRaw = decoder.decodeObject(forKey: "shipyardSkill") as! String! {
                self.shipyardSkill = ShipyardSkills(rawValue: shipyardSkillRaw)!
            }
            if let shipyardSizeSpecialtyRaw = decoder.decodeObject(forKey: "shipyardSizeSpecialty") as! String! {
                self.shipyardSizeSpecialty = SizeType(rawValue: shipyardSizeSpecialtyRaw)!
            }
            
            self.scarabIsHere = decoder.decodeBool(forKey: "scarabIsHere")
            self.dragonflyIsHere = decoder.decodeBool(forKey: "dragonflyIsHere")
            self.swarmingWithAliens = decoder.decodeBool(forKey: "swarmingWithAliens")
            self.spaceMonsterIsHere = decoder.decodeBool(forKey: "spaceMonsterIsHere")
            self.scorpionIsHere = decoder.decodeBool(forKey: "scorpionIsHere")
            
            self.water = decoder.decodeInteger(forKey: "water")
            self.furs = decoder.decodeInteger(forKey: "furs")
            self.food = decoder.decodeInteger(forKey: "food")
            self.ore = decoder.decodeInteger(forKey: "ore")
            self.games = decoder.decodeInteger(forKey: "games")
            self.firearms = decoder.decodeInteger(forKey: "firearms")
            self.medicine = decoder.decodeInteger(forKey: "medicine")
            self.machines = decoder.decodeInteger(forKey: "machines")
            self.narcotics = decoder.decodeInteger(forKey: "narcotics")
            self.robots = decoder.decodeInteger(forKey: "robots")
            
            self.waterBuy = decoder.decodeInteger(forKey: "waterBuy")
            self.fursBuy = decoder.decodeInteger(forKey: "fursBuy")
            self.foodBuy = decoder.decodeInteger(forKey: "foodBuy")
            self.oreBuy = decoder.decodeInteger(forKey: "oreBuy")
            self.gamesBuy = decoder.decodeInteger(forKey: "gamesBuy")
            self.firearmsBuy = decoder.decodeInteger(forKey: "firearmsBuy")
            self.medicineBuy = decoder.decodeInteger(forKey: "medicineBuy")
            self.machinesBuy = decoder.decodeInteger(forKey: "machinesBuy")
            self.narcoticsBuy = decoder.decodeInteger(forKey: "narcoticsBuy")
            self.robotsBuy = decoder.decodeInteger(forKey: "robotsBuy")
            self.waterSell = decoder.decodeInteger(forKey: "waterSell")
            self.fursSell = decoder.decodeInteger(forKey: "fursSell")
            self.foodSell = decoder.decodeInteger(forKey: "foodSell")
            self.oreSell = decoder.decodeInteger(forKey: "oreSell")
            self.gamesSell = decoder.decodeInteger(forKey: "gamesSell")
            self.firearmsSell = decoder.decodeInteger(forKey: "firearmsSell")
            self.medicineSell = decoder.decodeInteger(forKey: "medicineSell")
            self.machinesSell = decoder.decodeInteger(forKey: "machinesSell")
            self.narcoticsSell = decoder.decodeInteger(forKey: "narcoticsSell")
            self.robotsSell = decoder.decodeInteger(forKey: "robotsSell")
    
            super.init()
        }
    
        func encode(with encoder: NSCoder) {
            encoder.encode(name, forKey: "name")
            encoder.encode(techLevel.rawValue, forKey: "techLevel")
            encoder.encode(politics.rawValue, forKey: "politics")
            encoder.encode(status.rawValue, forKey: "status")
            encoder.encode(xCoord, forKey: "xCoord")
            encoder.encode(yCoord, forKey: "yCoord")
            encoder.encode(specialResources.rawValue, forKey: "specialResources")
            encoder.encode(size.rawValue, forKey: "size")
            encoder.encode(countdown, forKey: "countdown")
            encoder.encode(visited, forKey: "visited")
            encoder.encode(wormhole, forKey: "wormhole")
            encoder.encode(wormholeDestination, forKey: "wormholeDestination")
            encoder.encode(indexNumber, forKey: "indexNumber")
            encoder.encode(mercenaries, forKey: "mercenaries")
            encoder.encode(newspaper, forKey: "newspaper")
            encoder.encode(newsItemDropBox?.rawValue, forKey: "newsItemDropBox")
            encoder.encode(specialEvent?.rawValue, forKey: "specialEvent")
            
            encoder.encode(shipyard.rawValue, forKey: "shipyard")
            encoder.encode(shipyardEngineer.rawValue, forKey: "shipyardEngineer")
            encoder.encode(shipyardSkill.rawValue, forKey: "shipyardSkill")
            encoder.encode(shipyardSizeSpecialty.rawValue, forKey: "shipyardSizeSpecialty")
            
            encoder.encode(scarabIsHere, forKey: "scarabIsHere")
            encoder.encode(dragonflyIsHere, forKey: "dragonflyIsHere")
            encoder.encode(swarmingWithAliens, forKey: "swarmingWithAliens")
            encoder.encode(spaceMonsterIsHere, forKey: "spaceMonsterIsHere")
            encoder.encode(scorpionIsHere, forKey: "scorpionIsHere")
            
            encoder.encode(water, forKey: "water")
            encoder.encode(furs, forKey: "furs")
            encoder.encode(food, forKey: "food")
            encoder.encode(ore, forKey: "ore")
            encoder.encode(games, forKey: "games")
            encoder.encode(firearms, forKey: "firearms")
            encoder.encode(medicine, forKey: "medicine")
            encoder.encode(machines, forKey: "machines")
            encoder.encode(narcotics, forKey: "narcotics")
            encoder.encode(robots, forKey: "robots")

            encoder.encode(waterBuy, forKey: "waterBuy")
            encoder.encode(fursBuy, forKey: "fursBuy")
            encoder.encode(foodBuy, forKey: "foodBuy")
            encoder.encode(oreBuy, forKey: "oreBuy")
            encoder.encode(gamesBuy, forKey: "gamesBuy")
            encoder.encode(firearmsBuy, forKey: "firearmsBuy")
            encoder.encode(medicineBuy, forKey: "medicineBuy")
            encoder.encode(machinesBuy, forKey: "machinesBuy")
            encoder.encode(narcoticsBuy, forKey: "narcoticsBuy")
            encoder.encode(robotsBuy, forKey: "robotsBuy")
            encoder.encode(waterSell, forKey: "waterSell")
            encoder.encode(fursSell, forKey: "fursSell")
            encoder.encode(foodSell, forKey: "foodSell")
            encoder.encode(oreSell, forKey: "oreSell")
            encoder.encode(gamesSell, forKey: "gamesSell")
            encoder.encode(firearmsSell, forKey: "firearmsSell")
            encoder.encode(medicineSell, forKey: "medicineSell")
            encoder.encode(machinesSell, forKey: "machinesSell")
            encoder.encode(narcoticsSell, forKey: "narcoticsSell")
            encoder.encode(robotsSell, forKey: "robotsSell")
        }
}
