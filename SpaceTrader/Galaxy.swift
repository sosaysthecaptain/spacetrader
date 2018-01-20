//
//  Galaxy.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/8/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//
//
// createGalaxy() initializes the galaxy. All planets are stored in .planets. currentSystem and targetSystem also exist, and should be referenced from here. systemsInRange, an array, also lives here. It seems that modifying things in these arrays modifies them referentially, in the main array as well, so handling should be easy. Confirm this.
//
// standardPrice() gets a starting point price. determinePrices sets all prices, though does not yet correctly do sell prices. Need to figure out how to update prices and quantities.
//
// getSystemsInRange() populates systems in range, and should be called from warp.
//
//

import Foundation
import UIKit


class Galaxy: NSObject, NSCoding {
    
    var planets: [StarSystem] = []
    var systemsInRange: [StarSystem] = []
    var currentSystem: StarSystem?
    var targetSystem: StarSystem? {
        didSet {
            let distance = getDistance(currentSystem!, system2: targetSystem!)
            if distance > player.commanderShip.fuel {
                targetSystemInRange = false
            } else {
                targetSystemInRange = true
            }
            
            // handle wormhole
            if currentSystem!.wormhole {
                if currentSystem!.wormholeDestination!.name == targetSystem!.name {
                    targetSystemInRange = true
                }
            }
            
        }
    }
    var targetSystemInRange = true
    var trackedSystem: StarSystem? = nil
    var currentJourney: Journey?
    var journeyJustFinished = false
    var alertsToFireOnArrival: [AlertID] = []
    var meltdownOnArrival = false
    
    var spaceTimeMessedUp = false
    
    let closeButtonEnabled = false               // turn this on manually to enable skipping encounters
    
    var justArrived = false     // used to reset tab bar controller upon arrival
    var justArrivedSystem = false
    var justArrivedSell = false
    var justArrivedBuy = false
    var justArrivedShipyard = false
    
    override init() {
        // deliberately empty
    }
    
    func createGalaxy() {
        print("Initializing galaxy...")
        planets = []
        
        // populate availableNames
        var availableNames: [String] = ["Acamar", "Adhan", "Aldea", "Andevian", "Balosnee", "Baratas", "Brax", "Bretel", "Calondia", "Campor", "Capelle", "Carzon", "Castor", "Centauri", "Cestus", "Cheron", "Courtney", "Daled", "Damast", "Davlos", "Deneb", "Deneva", "Devidia", "Draylon", "Drema", "Endor", "Esmee", "Exo", "Ferris", "Festen", "Fourmi", "Frolix", "Galvon", "Gemulon", "Guinifer", "Hades", "Hamlet", "Helena", "Hulst", "Inthara", "Iodine", "Iralius", "Janus", "Japori", "Jarada", "Jason", "Kaylon", "Khefka", "Kira", "Klaatu", "Klaestron", "Korma", "Kravat", "Krios", "Laertes", "Largo", "Lave", "Ligon", "Lowry", "Magrat", "Malcoria", "Melina", "Mentar", "Merik", "Mintaka", "Montor", "Mordan", "Myrthe", "Nelvana", "Nix", "Nyle", "Odet", "Og", "Omega", "Omphalos", "Orias", "Othello", "Parade", "Penthara", "Picard", "Pollux", "Qonos", "Quator", "Rakhar", "Ran", "Regulas", "Relva", "Rhymus", "Rochani", "Rubicum", "Rutia", "Sarpeidon", "Sefalla", "Seltrice", "Sigma", "Sol", "Somari", "Stakoron", "Styris", "Talani", "Tamus", "Tantalos", "Tanuga", "Tarchannen", "Terosa", "Thera", "Titan", "Torin", "Triacus", "Turkana", "Tyrus", "Umberlee", "Utopia", "Vadera", "Varga", "Vandor", "Ventax", "Xenon", "Xerxes", "Yew", "Yojimbo", "Zalkon", "Zuul"]       // added "Rigel". Was at 119, not sure why.
        // removed "Rigel". Realized Centauri was the missing planet.
        // added "Inthara. Hopefully not a problem to have one more. Also was needed for princess quest. "Qonos", "Galvon" also added. Not sure why the princess quest didn't use regular planets
        
        // shuffle names
        availableNames = shuffleAvailableNames(availableNames)
        print("shuffling...")
        print("availableNames: \(availableNames)")
        
        var i: Int = 0
        while i < 123 {
            let newStarSystem = StarSystem(name: "NOT SET YET", techLevel: TechLevelType.techLevel0, politics: PoliticsType.anarchy, status: StatusType.none, xCoord: 0, yCoord: 0, specialResources: SpecialResourcesType.none, size: SizeType.Tiny)
            

            if i < MAXWORMHOLE {
                // place each of the six with a wormhole within a square, defined as the middle of each square of the galaxy broken into a 3x2 grid
                switch i {
                case 0:
                    let wUpper: UInt32 = 48
                    let wLower: UInt32 = 2
                    let hUpper: UInt32 = 54
                    let hLower: UInt32 = 2
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                case 1:
                    let wUpper: UInt32 = 98
                    let wLower: UInt32 = 52
                    let hUpper: UInt32 = 54
                    let hLower: UInt32 = 2
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                case 2:
                    let wUpper: UInt32 = 148
                    let wLower: UInt32 = 102
                    let hUpper: UInt32 = 54
                    let hLower: UInt32 = 2
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                case 3:
                    let wUpper: UInt32 = 48
                    let wLower: UInt32 = 2
                    let hUpper: UInt32 = 108
                    let hLower: UInt32 = 56
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                case 4:
                    let wUpper: UInt32 = 98
                    let wLower: UInt32 = 52
                    let hUpper: UInt32 = 108
                    let hLower: UInt32 = 56
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                case 5:
                    let wUpper: UInt32 = 148
                    let wLower: UInt32 = 102
                    let hUpper: UInt32 = 108
                    let hLower: UInt32 = 56
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                default:
                    newStarSystem.xCoord = 100
                    newStarSystem.yCoord = 100
                }
                // set wormhole to true
                newStarSystem.wormhole = true
                
            } else {
                // place others randomly, not closer than 2 from the edge
                let wUpper: UInt32 = 148
                let wLower: UInt32 = 2
                let hUpper: UInt32 = 108
                let hLower: UInt32 = 2
                newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                
                // ALTERNATELY, PLACE IN A CONTROLLED FASHION, EACH OBSERVING MIN AND MAX DISTANCE LIMITATIONS
                // TODO?
                
                
                // make sure each one is no closer than MINDISTANCE to another planet
                var proximityFlag = false
                while !proximityFlag {
                    let wUpper: UInt32 = 148
                    let wLower: UInt32 = 2
                    let hUpper: UInt32 = 108
                    let hLower: UInt32 = 2
                    newStarSystem.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
                    newStarSystem.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
                    proximityFlag = verifyMinDistance(newStarSystem, i: i)
                    
                    // check max distance, should be no more than 13
//                    if proximityFlag {
//                        proximityFlag = verifyMaxDistance(newStarSystem, i: i)  // this is experimental
//                    }
                }
                
                // (later we will verify that all planets are within CLOSEDISTANCE of each other. If they aren't, we'll regenerate their coords until they satisfy this condition)
            }
            
            // SET EVERYTHING ELSE HERE. NAME, TECH, POLITICS, SIZE, STATUS, SPECIAL RESOURCES, INITIAL TRADE ITEMS, WORMHOLE DESTINATION
            
            // name
            let count = UInt32(availableNames.count)
            let nameIndex = Int(arc4random_uniform(count))
            let nameString = availableNames[nameIndex]
            availableNames.remove(at: nameIndex)
            newStarSystem.name = nameString
            newStarSystem.indexNumber = i
            
            // tech level, politics, size--ALL COMPLETELY RANDOM
            let techLevelRand = Int(arc4random_uniform(8))
            switch techLevelRand{
                case 0:
                    newStarSystem.techLevel = TechLevelType.techLevel0
                case 1:
                    newStarSystem.techLevel = TechLevelType.techLevel1
                case 2:
                    newStarSystem.techLevel = TechLevelType.techLevel2
                case 3:
                    newStarSystem.techLevel = TechLevelType.techLevel3
                case 4:
                    newStarSystem.techLevel = TechLevelType.techLevel4
                case 5:
                    newStarSystem.techLevel = TechLevelType.techLevel5
                case 6:
                    newStarSystem.techLevel = TechLevelType.techLevel6
                case 7:
                    newStarSystem.techLevel = TechLevelType.techLevel7
                default:
                    newStarSystem.techLevel = TechLevelType.techLevel8
            }
            
            
            // politics--BUG: MUST ADHERE TO CONSTRAINTS
            
            var politicsTypeTemp: PoliticsType = PoliticsType.anarchy
            var satisfiesTechLevelRequirements = false
            
            while !satisfiesTechLevelRequirements {
                let politicsRand = Int(arc4random_uniform(17))
                
                switch politicsRand {
                case 0:
                    politicsTypeTemp = PoliticsType.anarchy
                case 1:
                    politicsTypeTemp = PoliticsType.capitalist
                case 2:
                    politicsTypeTemp = PoliticsType.communist
                case 3:
                    politicsTypeTemp = PoliticsType.confederacy
                case 4:
                    politicsTypeTemp = PoliticsType.corporate
                case 5:
                    politicsTypeTemp = PoliticsType.cybernetic
                case 6:
                    politicsTypeTemp = PoliticsType.democracy
                case 7:
                    politicsTypeTemp = PoliticsType.dictatorship
                case 8:
                    politicsTypeTemp = PoliticsType.fascist
                case 9:
                    politicsTypeTemp = PoliticsType.feudal
                case 10:
                    politicsTypeTemp = PoliticsType.military
                case 11:
                    politicsTypeTemp = PoliticsType.monarchy
                case 12:
                    politicsTypeTemp = PoliticsType.pacifist
                case 13:
                    politicsTypeTemp = PoliticsType.socialist
                case 14:
                    politicsTypeTemp = PoliticsType.satori
                case 15:
                    politicsTypeTemp = PoliticsType.technocracy
                case 16:
                    politicsTypeTemp = PoliticsType.theocracy
                default:
                    politicsTypeTemp = PoliticsType.anarchy
                }
                
                let politicsProto = Politics(type: politicsTypeTemp)
                let minTech = getTechLevelValue(politicsProto.minTech)
                let maxTech = getTechLevelValue(politicsProto.maxTech)
                let techLevelValue = getTechLevelValue(newStarSystem.techLevel)
                
                if (techLevelValue >= minTech) && (techLevelValue <= maxTech) {
                    satisfiesTechLevelRequirements = true
                }
                
                newStarSystem.politics = politicsTypeTemp
            }
            
            
            // size
            let sizeRand = Int(arc4random_uniform(5))
            switch sizeRand {
                case 0:
                    newStarSystem.size = SizeType.Tiny
                case 1:
                    newStarSystem.size = SizeType.Small
                case 2:
                    newStarSystem.size = SizeType.Medium
                case 3:
                    newStarSystem.size = SizeType.Large
                case 4:
                    newStarSystem.size = SizeType.Huge
                default:
                    newStarSystem.size = SizeType.Tiny
            }
            
            // special resources
            let specialResourcesRand1 = Int(arc4random_uniform(5))
            if specialResourcesRand1 >= 3 {
                let specialResourcesRand2 = Int(arc4random_uniform(12))
                switch specialResourcesRand2 {
                    case 0:
                        newStarSystem.specialResources = SpecialResourcesType.mineralRich
                    case 1:
                        newStarSystem.specialResources = SpecialResourcesType.desert
                    case 2:
                        newStarSystem.specialResources = SpecialResourcesType.mineralRich
                    case 3:
                        newStarSystem.specialResources = SpecialResourcesType.lotsOfWater
                    case 4:
                        newStarSystem.specialResources = SpecialResourcesType.richSoil
                    case 5:
                        newStarSystem.specialResources = SpecialResourcesType.poorSoil
                    case 6:
                        newStarSystem.specialResources = SpecialResourcesType.richFauna
                    case 7:
                        newStarSystem.specialResources = SpecialResourcesType.lifeless
                    case 8:
                        newStarSystem.specialResources = SpecialResourcesType.weirdMushrooms
                    case 9:
                        newStarSystem.specialResources = SpecialResourcesType.specialHerbs
                    case 10:
                        newStarSystem.specialResources = SpecialResourcesType.artisticPopulace
                    case 11:
                        newStarSystem.specialResources = SpecialResourcesType.warlikePopulace
                    default:
                        newStarSystem.specialResources = SpecialResourcesType.none
                }
            } else {
                 newStarSystem.specialResources = SpecialResourcesType.none
            }
            
            // status
            let statusRand1 = Int(arc4random_uniform(100))
            if statusRand1 >= 85 {
                newStarSystem.status = StatusType.none
            } else {
                let statusRand2 = Int(arc4random_uniform(7))
                switch statusRand2 {
                case 0:
                    newStarSystem.status = StatusType.war
                case 0:
                    newStarSystem.status = StatusType.plague
                case 0:
                    newStarSystem.status = StatusType.drought
                case 0:
                    newStarSystem.status = StatusType.boredom
                case 0:
                    newStarSystem.status = StatusType.cold
                case 0:
                    newStarSystem.status = StatusType.cropFailure
                case 0:
                    newStarSystem.status = StatusType.employment
                default:
                    newStarSystem.status = StatusType.none
                }
            }

            
            // initialize trade items
            //newStarSystem = initializeTradeItems(newStarSystem)
            initializeTradeItems(newStarSystem)
            determinePrices(newStarSystem)
            
            
            // anything else that needs to be set here?
            // mercenaries?
            
            // end of loop
            planets.append(newStarSystem)
            i += 1
        }
        
        // verify everything is close enough
        verifyAndFixProximity()
        
        // set wormhole destinations
        var planetsWithWormholes: [StarSystem] = []
        
        // populate list
        for planet in planets {
            if planet.wormhole {
                planetsWithWormholes.append(planet)
            }
        }
        
        // assign randomly
        var doOverNecessary = true
        var repetitions: Int = 0
        
        while doOverNecessary == true {
            repetitions += 1
            for planet in planetsWithWormholes {
                var indicesOfPlanetsWithUnassignedWormholes: [Int] = [0, 1, 2, 3, 4, 5]
                doOverNecessary = false
                let randomIndex = Int(arc4random_uniform(UInt32(indicesOfPlanetsWithUnassignedWormholes.count)))
                let destinationIndex = indicesOfPlanetsWithUnassignedWormholes[randomIndex]
                indicesOfPlanetsWithUnassignedWormholes.remove(at: randomIndex)
                planet.wormholeDestination = planets[destinationIndex]
                
                
                // make sure planet not assigned to self
                if planet.wormholeDestination!.name == planet.name {
                    doOverNecessary = true
                }
            }
            

            // check to see that all six are in a single chain
            for index in 0...5 {
                // check each does not point to self
                if planets[index].wormholeDestination!.name == planets[index].name {
                    doOverNecessary = true
                }
                
                // check not 2 loop
                if planets[index].wormholeDestination!.wormholeDestination!.name == planets[index].name {
                    doOverNecessary = true
                }
                
                // check not 3 loop
                if planets[index].wormholeDestination!.wormholeDestination!.wormholeDestination!.name == planets[index].name {
                    doOverNecessary = true
                }
                
                // check not 4 loop
                if planets[index].wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.name == planets[index].name {
                    doOverNecessary = true
                }
                
                // check not 5 loop
                if planets[index].wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.name == planets[index].name {
                    doOverNecessary = true
                }
            }
            
            // make sure is a 6 loop
            if planets[0].wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.wormholeDestination!.name == planets[0].name {
                continue
            } else {
                doOverNecessary = true
            }
        }
        
        // assign shipyardID
        initializeShipyard()
        
        
        
//        var indicesOfPlanetsWithWormholes: [Int] = [0, 1, 2, 3, 4, 5]
//        for planet in planets {
//            if planet.wormhole {
//                // randomly choose a number in the array
//                var index: Int = 50
//                var number: Int = 50
//                // must make sure planet is not assigned its own index
//            
//                index = Int(arc4random_uniform(UInt32(indicesOfPlanetsWithWormholes.count)))
//                number = indicesOfPlanetsWithWormholes[index]
//                
//                while number == planet.indexNumber {
//                    index = Int(arc4random_uniform(UInt32(indicesOfPlanetsWithWormholes.count)))
//                    number = indicesOfPlanetsWithWormholes[index]
//                    if (planet.indexNumber == 5) && (number == 5) {
//                        print("this is the infinite loop case. Handling manually")
//                        let oldFourthDestination = planets[4].wormholeDestination
//                        planets[5].wormholeDestination = oldFourthDestination
//                        planets[4].wormholeDestination =
//                    }
//                    print("while loop: planet index: \(planet.indexNumber), wormhole index: \(number)")
//                }
//                
//                
//                
//                print("first round: planet index: \(planet.indexNumber), wormhole index: \(number)")
//                // doesn't work because if failure is on 5, there is no other option
//                
//                // remove it from the array
//                indicesOfPlanetsWithWormholes.removeAtIndex(index)
//                // assign it
//                planet.wormholeDestination = planets[number]
//            }
//        }
        
        currentSystem = planets[50]             // FIX THIS. ARBITRARY CHOICE TO BE REPLACED
        currentSystem!.visited = true
        getSystemsInRange()
        targetSystem = systemsInRange[0]        // INITIAL VALUE THAT SHOULD ACTUALLY BE IN RANGE
        
        // mercenaries
        initializeMercenaries()
        
        // DEBUGGING:
        // log output to console
        for planet in planets {
            print("*****************************************************")
            print("name: \(planet.name)")
            print("x coord: \(planet.xCoord)")
            print("y coord: \(planet.yCoord)")
            print("tech level: \(planet.techLevel)")
            print("politics: \(planet.politics)")
            print("size: \(planet.size)")
            print("special resources: \(planet.specialResources)")
            print("status: \(planet.status)")
            print("wormhole destination: \(planet.wormholeDestination)")
            print("water quantity: \(planet.water)")
            print("furs quantity: \(planet.furs)")
            print("food quantity: \(planet.food)")
            print("ore quantity: \(planet.ore)")
            print("games quantity: \(planet.games)")
            print("firearms quantity: \(planet.firearms)")
            print("medicine quantity: \(planet.medicine)")
            print("machines quantity: \(planet.machines)")
            print("narcotics quantity: \(planet.narcotics)")
            print("robots quantity: \(planet.robots)")
            print("waterBuy: \(planet.waterBuy)")
            print("waterSell: \(planet.waterSell)")
            print("fursBuy: \(planet.fursBuy)")
            print("fursSell: \(planet.fursSell)")
            print("foodBuy: \(planet.foodBuy)")
            print("foodSell: \(planet.foodSell)")
            print("oreBuy: \(planet.oreBuy)")
            print("oreSell: \(planet.oreSell)")
            print("gamesBuy: \(planet.gamesBuy)")
            print("gamesSell: \(planet.gamesSell)")
            print("firearmsBuy: \(planet.firearmsBuy)")
            print("firearmsSell: \(planet.firearmsSell)")
            print("medicineBuy: \(planet.medicineBuy)")
            print("medicineSell: \(planet.medicineSell)")
            print("machinesBuy: \(planet.machinesBuy)")
            print("machinesSell: \(planet.machinesSell)")
            print("narcoticsBuy: \(planet.narcoticsBuy)")
            print("narcoticsSell: \(planet.narcoticsSell)")
            print("robotsBuy: \(planet.robotsBuy)")
            print("robotsSell: \(planet.robotsSell)")
        }
        
        print("******************************************************************")
        print("WORMHOLE MAPPING:")
        print("planet 0. Name: \(planets[0].name), wormhole destination: \(planets[0].wormholeDestination!.name)")
        print("planet 1. Name: \(planets[1].name), wormhole destination: \(planets[1].wormholeDestination!.name)")
        print("planet 2. Name: \(planets[2].name), wormhole destination: \(planets[2].wormholeDestination!.name)")
        print("planet 3. Name: \(planets[3].name), wormhole destination: \(planets[3].wormholeDestination!.name)")
        print("planet 4. Name: \(planets[4].name), wormhole destination: \(planets[4].wormholeDestination!.name)")
        print("planet 5. Name: \(planets[5].name), wormhole destination: \(planets[5].wormholeDestination!.name)")
        
        var totalPlanets: Int = 0
        for _ in planets {
            totalPlanets += 1
        }
        print("total planets populated: \(totalPlanets)")
        
        // handle unreachable planet issue
        //print("first pass: \(getUnreachablePlanetsCount()) unreachable")
        let unreachable = getUnreachablePlanets()
        
        // recursive, nuclear option
        if unreachable.count > 15 {
            self.createGalaxy()
        }
        
        // kinder, gentler option that works in most other cases
        for planet in unreachable {
            print("reassigning coords of \(planet.name)")
            reinsertSystemDoingAllChecks(planet)
        }
        //print("second pass: unreachable planets: \(getUnreachablePlanetsCount())")
        
        initializeSpecials()
        // DEBUG SPECIAL
//        print("Specials:")
//        for system in self.planets {
//            print("planet name: " + system.name + " Special: ")
//            print(system.specialEvent as Any)
//        }
    }
    

    
    func getDistance(_ system1: StarSystem, system2: StarSystem) -> Int {
        let xDistance = abs(system1.xCoord - system2.xCoord)
        let yDistance = abs(system1.yCoord - system2.yCoord)
        let sum: Double = Double((xDistance * xDistance) + (yDistance * yDistance))
        return Int(sqrt(sum))       // might need to round. Not worrying about that now
    }
    
    func verifyMinDistance(_ system1: StarSystem, i: Int) -> Bool {
        for index in 0..<i {
            if getDistance(system1, system2: planets[index]) < MINDISTANCE {
                return false
            }
        }
        return true
    }
    
//    func verifyMaxDistance(system1: StarSystem, i: Int) -> Bool {
//        for index in 0..<i {
//            if getDistance(system1, system2: planets[index]) > 13 {
//                return false
//            }
//        }
//        return true
//    }
    
    func distanceToNearestNeighbor(_ system: StarSystem) -> Int {
        var min: Int = 100
        for planet in planets {
            let distance = getDistance(system, system2: planet)
            if distance < min {
                min = distance
            }
        }
        return min
    }
    
    func verifyAndFixProximity() -> Bool {
        // could calculate continuous chain
        print("running verifyAndFixProximity")
        
        var ok = false
        while !ok {
            ok = true
            for planet in planets {
                let distance = distanceToNearestNeighbor(planet)
                if distance > MINDISTANCE {
                    ok = false
                    reassignRandomCoords(planet)
                }
            }
        }
        return true
    }
    
//    func calculateContinuousChain() -> Bool {
//        // finds out if a chain of 13 parsec jumps can get you from planets[0] to here
//        
//    }
    
    func reassignRandomCoords(_ system: StarSystem) {
        var proximityFlag = false
        while !proximityFlag {
            let wUpper: UInt32 = 148
            let wLower: UInt32 = 2
            let hUpper: UInt32 = 108
            let hLower: UInt32 = 2
            system.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
            system.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
            proximityFlag = verifyMinDistance(system, i: planets.count)
        }
    }
    
    func reassignRandomCoordsNoCheck(_ system: StarSystem) {
        let wUpper: UInt32 = 148
        let wLower: UInt32 = 2
        let hUpper: UInt32 = 108
        let hLower: UInt32 = 2
        system.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
        system.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
    }
    
    func reassignRandomCoords2(_ system: StarSystem) {
        var proximityFlag = false
        var i = 0
        while !proximityFlag {
            reassignRandomCoordsNoCheck(system)
            print("reassigning \(system.name), iteration \(i)")
            i += 1
            proximityFlag = !verifyMinDistance(system, i: planets.count)
        }
        
    }
    

    
    func initializeTradeItems(_ system: StarSystem) {
        var passFlag = false
        let difficulty = getDifficultyValue(player.difficulty)
        let tradeItems: [TradeItem] = [
            TradeItem(item: .Water, quantity: 1, pricePaid: 1),
            TradeItem(item: .Furs, quantity: 1, pricePaid: 1),
            TradeItem(item: .Food, quantity: 1, pricePaid: 1),
            TradeItem(item: .Ore, quantity: 1, pricePaid: 1),
            TradeItem(item: .Games, quantity: 1, pricePaid: 1),
            TradeItem(item: .Firearms, quantity: 1, pricePaid: 1),
            TradeItem(item: .Medicine, quantity: 1, pricePaid: 1),
            TradeItem(item: .Machines, quantity: 1, pricePaid: 1),
            TradeItem(item: .Narcotics, quantity: 1, pricePaid: 1),
            TradeItem(item: .Robots, quantity: 1, pricePaid: 1)]
        // iterate through all tradeItems
        for item in tradeItems {
            let politics = Politics(type: system.politics)
            var quantity: Int = 0
            passFlag == false
            // continue only if not above max trade item for tech level && not ignored here
            if getTechLevelValue(system.techLevel) < getTechLevelValue(item.techProduction) {
                quantity = 0
                passFlag = true
            }
            if item.item == .Firearms && !politics.firearmsOk {
                quantity = 0
                passFlag = true
            }
            if item.item == .Narcotics && !politics.drugsOk {
                quantity = 0
                passFlag = true
            }
            
            
            if !passFlag {
                // general case: (9 + rand(5)) - abs((techTopProduction - techLevel) * (1 + size))
                let rand = Int(arc4random_uniform(5))
                quantity = ((9 + rand) - abs(getTechLevelValue(item.techTopProduction) - getTechLevelValue(system.techLevel))) * (1 + getSizeValue(system.size))
                
                // if robots or narcotics, prevent crazy lucrative scenario
                if (item.item == .Robots) || (item.item == .Narcotics) {
                    quantity = (quantity * (5 - difficulty)) / ((6 - difficulty) + 1)
                }
                
                // if cheapResource
                if system.specialResources == item.cheapResource {
                    quantity = (quantity * 4) / 3
                }
                
                // if expensiveResource
                if system.specialResources == item.expensiveResource {
                    quantity = quantity / 2
                }
                
                // if doublePriceStatus
                if system.status == item.doublePriceStatus {
                    quantity = quantity / 5
                }
                
                // further randomize
                quantity = quantity + Int(arc4random_uniform(10)) - Int(arc4random_uniform(10))
                
                // if less than zero, make zero
                if quantity < 0 {
                    quantity = 0
                }
            }
            
            
            //  write quantity to system                // REPLACE WITH DEDICATED FUNCTION
            switch item.item {
                case .Water:
                    system.water = quantity
                case .Furs:
                    system.furs = quantity
                case .Food:
                    system.food = quantity
                case .Ore:
                    system.ore = quantity
                case .Games:
                    system.games = quantity
                case .Firearms:
                    system.firearms = quantity
                case .Medicine:
                    system.medicine = quantity
                case .Machines:
                    system.machines = quantity
                case .Narcotics:
                    system.narcotics = quantity
                case .Robots:
                    system.robots = quantity
                default:
                    print("?")
            }
        }
    }
    
    func initializeShipyard() {
        // assemble a list of high tech systems
        var highTechSystems: [StarSystem] = []
        for system in planets {
            if system.techLevel == TechLevelType.techLevel7 {
                highTechSystems.append(system)
            }
        }
        
        // randomly choose five of them
        var chosenSystems: [StarSystem] = []
        while chosenSystems.count < 5 {
            let randomIndex = rand(highTechSystems.count)
            chosenSystems.append(highTechSystems[randomIndex])
            highTechSystems.remove(at: randomIndex)
        }
        
        // assign shipyards to those five, as well as engineer, skill & size specialties
        var shipyardsPossible = [ShipyardID.corellian, ShipyardID.incom, ShipyardID.kuat, ShipyardID.sienar, ShipyardID.sorosuub]
        var engineersPossible = [ShipyardEngineers.lando, ShipyardEngineers.luke, ShipyardEngineers.mara, ShipyardEngineers.obiwan, ShipyardEngineers.wedge]
        var specialtiesPossible = [ShipyardSkills.crew, ShipyardSkills.fuel, ShipyardSkills.hull, ShipyardSkills.shielding, ShipyardSkills.weaponry]
        var sizeSpecialtiesPossible = [SizeType.Tiny, SizeType.Small, SizeType.Medium, SizeType.Large, SizeType.Huge]
        
        // for each system with a shipyard, randomly assign an engineer, a skill, and a size specialty
        var index = 0
        for system in chosenSystems {
            system.shipyard = shipyardsPossible[index]
            
            // randomly assign engineer
            let randomEngIndex = rand(engineersPossible.count)
            system.shipyardEngineer = engineersPossible[randomEngIndex]
            engineersPossible.remove(at: randomEngIndex)
            
            // randomly assign skill
            let randomSkillIndex = rand(specialtiesPossible.count)
            system.shipyardSkill = specialtiesPossible[randomSkillIndex]
            specialtiesPossible.remove(at: randomSkillIndex)
            
            // randomly assign shipyardSizeSpecialty
            let randomSizeSpecialtyIndex = rand(sizeSpecialtiesPossible.count)
            system.shipyardSizeSpecialty = sizeSpecialtiesPossible[randomSizeSpecialtyIndex]
            sizeSpecialtiesPossible.remove(at: randomSizeSpecialtyIndex)
            
            index += 1
        }
        
        print("SHIPYARD DEBUG: systems and designated shipyards")
        for system in chosenSystems {
            print("system: \(system.name), shipyardID: \(system.shipyard)")
        }
    }
    
    func determinePrices(_ system: StarSystem) {
        let tradeItems: [TradeItem] = [
            TradeItem(item: .Water, quantity: 1, pricePaid: 1),
            TradeItem(item: .Furs, quantity: 1, pricePaid: 1),
            TradeItem(item: .Food, quantity: 1, pricePaid: 1),
            TradeItem(item: .Ore, quantity: 1, pricePaid: 1),
            TradeItem(item: .Games, quantity: 1, pricePaid: 1),
            TradeItem(item: .Firearms, quantity: 1, pricePaid: 1),
            TradeItem(item: .Medicine, quantity: 1, pricePaid: 1),
            TradeItem(item: .Machines, quantity: 1, pricePaid: 1),
            TradeItem(item: .Narcotics, quantity: 1, pricePaid: 1),
            TradeItem(item: .Robots, quantity: 1, pricePaid: 1)]
        
        for item in tradeItems {
            var done = false
            let systemSize = system.size
            let systemTech = system.techLevel
            let systemGovernment = system.politics
            let systemResources = system.specialResources
            
            // call standardPrice() as a starting point
            var buyPrice = standardPrice(item.item, systemSize: systemSize, systemTech: systemTech, systemGovernment: systemGovernment, systemResources: systemResources)
            var sellPrice = 0
            
            if buyPrice == 0 {
                done = true
            }
            
            if !done {
                // In case of a special status, adapt price accordingly
                if item.doublePriceStatus != StatusType.none {
                    if system.status == item.doublePriceStatus {
                        buyPrice = (buyPrice * 3) / 2
                    }
                }
                
                // randomize price a bit
                buyPrice = buyPrice + Int(arc4random_uniform(UInt32(item.variance))) - Int(arc4random_uniform(UInt32(item.variance)))
                
                // should never happen
                if buyPrice < 0 {
                    buyPrice = 0
                }
                
                // set sell price, as a factor of trader skill
                sellPrice = (buyPrice * (100 - player.traderSkill)) / 100
                
                // criminals have to pay off an intermediary 10% IMPLEMENT THIS LATER
                
                
                // RECALCULATEBUYPRICES?
            }
            
            
            // set buy and sell price for specific item
            switch item.item {
                case .Water:
                    system.waterBuy = buyPrice
                    system.waterSell = sellPrice
                case .Furs:
                    system.fursBuy = buyPrice
                    system.fursSell = sellPrice
                case .Food:
                    system.foodBuy = buyPrice
                    system.foodSell = sellPrice
                case .Ore:
                    system.oreBuy = buyPrice
                    system.oreSell = sellPrice
                case .Games:
                    system.gamesBuy = buyPrice
                    system.gamesSell = sellPrice
                case .Firearms:
                    system.firearmsBuy = buyPrice
                    system.firearmsSell = sellPrice
                case .Medicine:
                    system.medicineBuy = buyPrice
                    system.medicineSell = sellPrice
                case .Machines:
                    system.machinesBuy = buyPrice
                    system.machinesSell = sellPrice
                case .Narcotics:
                    system.narcoticsBuy = buyPrice
                    system.narcoticsSell = sellPrice
                case .Robots:
                    system.robotsBuy = buyPrice
                    system.robotsSell = sellPrice
                default:
                    print("?")
            }
            
        }        
    }
    
    func standardPrice(_ good: TradeItemType, systemSize: SizeType, systemTech: TechLevelType, systemGovernment: PoliticsType, systemResources: SpecialResourcesType) -> Int {
        
        var price: Int = 0
        let politics = Politics(type: systemGovernment)
        let techLevelValue = getTechLevelValue(systemTech)
        let sizeValue = getSizeValue(systemSize)
        let tradeItem = TradeItem(item: good, quantity: 1, pricePaid: 1)

        if ((good == .Firearms) && (!politics.firearmsOk)) || ((good == .Narcotics) && (!politics.drugsOk)) {
            return 0
        }
        
        // Determine base price on techlevel of system
        price = tradeItem.priceLowTech + (techLevelValue * tradeItem.priceIncrease)
        //print("DEBUG: priceLowTech \(tradeItem.priceLowTech) + (techLevelValue \(techLevelValue) * priceIncrease \(tradeItem.priceIncrease)")
        //print("DEBUG: tradeItem: \(tradeItem.item), basePrice: \(price)")
        
        // If a good is highly requested, increase the price
        if politics.wanted == tradeItem.item {
            price = (price * 4) / 3
        }
        
        // High trader activity decreases prices
        price = price * ((100 - (2 * politics.activityTraders))) / 100
        
        // Large system = high production decreases prices
        price = (price * (100 - sizeValue)) / 100
        
        // account for special resources
        if systemResources != SpecialResourcesType.none {
            if tradeItem.cheapResource != SpecialResourcesType.none {
                if systemResources == tradeItem.cheapResource {
                    price = (price * 3) / 4
                }
            }
            if tradeItem.expensiveResource != SpecialResourcesType.none {
                if systemResources == tradeItem.expensiveResource {
                    price = (price * 4) / 3
                }
            }
        }
        
        // if a system can't use something, set it's price to zero
        if techLevelValue < getTechLevelValue(tradeItem.techUsage) {
            return 0
        }
        return price
    }
    
    func getSystemsInRange() {
        // dump old
        systemsInRange = []
        
        let range = player.commanderShip.fuel
        
        for planet in planets {
            let distance = getDistance(currentSystem!, system2: planet)
            if planet.name != currentSystem!.name {
                if distance <= range {
                    systemsInRange.append(planet)
                }
            }
        }
        
        // if currentPlanet has a wormhole, add its destination to the list
        if currentSystem!.wormhole {
            systemsInRange.append(currentSystem!.wormholeDestination!)
        }
        
        // if tanks empty and no range, add current system to systemsInRange, so that it can become the target system and nothing will break
        if systemsInRange.count == 0 {
            systemsInRange.append(currentSystem!)
        }
        
        // DEBUG--ARBITRARY ASSIGNMENT OF TARGETSYSTEM
        targetSystem = systemsInRange[0]
    }
    
    // this is used in making the galaxy. Sees what planets are within minimum range of a given system
    func getSystemsInRangeOfPlanet(_ referencePlanet: StarSystem) -> [StarSystem] {
        var returnArray: [StarSystem] = []
        
        let range = 13                                      // set max allowable distance here
        
        for planet in planets {
            let distance = getDistance(referencePlanet, system2: planet)
            if distance <= range {
                returnArray.append(planet)
            }
        }

        return returnArray
    }
    
    func getTechLevelValue(_ level: TechLevelType) -> Int {
        switch level {
            case TechLevelType.techLevel0:
                return 0
            case TechLevelType.techLevel1:
                return 1
            case TechLevelType.techLevel2:
                return 2
            case TechLevelType.techLevel3:
                return 3
            case TechLevelType.techLevel4:
                return 4
            case TechLevelType.techLevel5:
                return 5
            case TechLevelType.techLevel6:
                return 6
            case TechLevelType.techLevel7:
                return 7
            case TechLevelType.techLevel8:
                return 8
        }
    }
    
    func getSizeValue(_ size: SizeType) -> Int {
        switch size {
            case .Tiny:
                return 0
            case .Small:
                return 1
            case .Medium:
                return 2
            case .Large:
                return 3
            case .Huge:
                return 4
        }
    }
    
    func getDifficultyValue(_ difficulty: DifficultyType) -> Int {
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
    
    func getActivityForInt(_ activity: Int) -> String {
        var activityString: String = ""
        switch activity {
        case 0:
            activityString = "Absent"
        case 1:
            activityString = "Minimal"
        case 2:
            activityString = "Few"
        case 3:
            activityString = "Some"
        case 4:
            activityString = "Moderate"
        case 5:
            activityString = "Many"
        case 6:
            activityString = "Abundant"
        case 7:
            activityString = "Swarms"
        default:
            activityString = "RANGE ERROR"
        }
        return activityString
    }
    
    func getShortDescriptorString(_ system: StarSystem) -> String {
        let size = system.size.rawValue
        let techLevel = system.techLevel.rawValue
        let politics = system.politics.rawValue
        return "\(size), \(techLevel), \(politics)"
    }
    
    func cycleForward() {
        var i: Int = 0
        var currentIndex: Int = 0
        for system in systemsInRange {
            if system.name == targetSystem!.name {
                currentIndex = i
            }
            i += 1
        }
        let newIndex = (currentIndex + 1) % systemsInRange.count
        targetSystem = systemsInRange[newIndex]
    }
    
    func cycleBackward() {
        var i: Int = 0
        var currentIndex: Int = 0
        for system in systemsInRange {
            if system.name == targetSystem!.name {
                currentIndex = i
            }
            i += 1
        }
        var newIndex = (currentIndex - 1)
        if newIndex < 0 {
            newIndex = systemsInRange.count - 1
        }
        targetSystem = systemsInRange[newIndex]
    }
    
    func updateGalaxy() {
        // handles all events that happen with the passage of a day.
        player.days += 1
        shuffleStatus()
        
        // player's police record improves slowly, if he doesn't get into trouble
        if player.days % 10 == 0 {
            player.incrementPoliceRecord(true)
        }
        
        // interest on player's debt
        if player.debt != 0 {
            let newDebt: Double = Double(player.debt) * 1.02
            player.debt = Int(newDebt)
        }
        
        // if player rich enough, add utopia moon special
        
    }
    
    func shuffleStatus() {
        for planet in planets {
            if planet.status != StatusType.none {
                let statusRand1 = Int(arc4random_uniform(100))
                if statusRand1 < 15 {
                    planet.status = StatusType.none
                }
            } else {
                let statusRand2 = Int(arc4random_uniform(7))
                switch statusRand2 {
                    case 0:
                        planet.status = StatusType.war
                    case 0:
                        planet.status = StatusType.plague
                    case 0:
                        planet.status = StatusType.drought
                    case 0:
                        planet.status = StatusType.boredom
                    case 0:
                        planet.status = StatusType.cold
                    case 0:
                        planet.status = StatusType.cropFailure
                    case 0:
                        planet.status = StatusType.employment
                    default:
                        planet.status = StatusType.none
                }
            }
        }
    }
    
    func updateQuantities() {
        for planet in planets {
            planet.countdown -= 1
            if planet.countdown <= 0 {
                planet.countdown = (3 + getDifficultyValue(player.difficulty))
                initializeTradeItems(planet)            // really? we want this to happen only seldom
            } else {
                // increment all trade items, unless they are not traded there
                var skipFlag = false
                // set skipFlag to true if needed
                var adjustQuantityBy: Int = 0
                let politics = Politics(type: planet.politics)
                
                let tradeItems: [TradeItem] = [
                    TradeItem(item: .Water, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Furs, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Food, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Ore, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Games, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Firearms, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Medicine, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Machines, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Narcotics, quantity: 1, pricePaid: 1),
                    TradeItem(item: .Robots, quantity: 1, pricePaid: 1)]
                for item in tradeItems {
                    if getTechLevelValue(planet.techLevel) < getTechLevelValue(item.techProduction) {
                        adjustQuantityBy = 0
                        skipFlag = true
                    }
                    if item.item == .Firearms && !politics.firearmsOk {
                        adjustQuantityBy = 0
                        skipFlag = true
                    }
                    if item.item == .Narcotics && !politics.drugsOk {
                        adjustQuantityBy = 0
                        skipFlag = true
                    }
                    
                    if !skipFlag {
                        // get quantities to update by
                        adjustQuantityBy += Int(arc4random_uniform(5)) - Int(arc4random_uniform(5))
                        
                        // update
                        addToSystemCommodities(planet, commodity: item.item, amountToAdd: adjustQuantityBy)
                        setCommodityToZeroIfNegative(planet, commodity: item.item)
                    }
                }
            }
        }
    }
    
    
    // STUFF PERTAINING TO REACHABLE PLANETS ISSUE********************************************************
    // this one will be removed
//    func seeHowManySystemsAreReachable() {
//        var reachableSystems: [StarSystem] = []
//        reachableSystems.append(currentSystem!)
//        // distance to test for is found within getSystemsInRangeOfPlanet
//        
//        print("REACHABLE SYSTEM READOUT****************************************************************")
//        print("reachable systems initialized with \(reachableSystems[0].name)")
//        
//        var systemsWithinTenOfCurrent: [StarSystem] = []
//        let foundSystems = getSystemsInRangeOfPlanet(reachableSystems[0])
//        for item in foundSystems {
//            systemsWithinTenOfCurrent.append(item)
//        }
//        print("planets within ten clicks of currentSystem:")
//        for planet in systemsWithinTenOfCurrent {
//            print(planet.name)
//        }
//
//        // second jump
//        var furtherReachableSystems = planetsReachableWithinFurtherTenClicks(systemsWithinTenOfCurrent)
//        print("\(furtherReachableSystems.count) systems reachable in two jumps")
//        
//        // third jump
//        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        print("\(furtherReachableSystems.count) systems reachable in three jumps")
//        
//        // fourth jump
//        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        print("\(furtherReachableSystems.count) systems reachable in four jumps")
//        
//        // fifth jump
//        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        print("\(furtherReachableSystems.count) systems reachable in five jumps")
//        
//        for _ in 0..<5 {
//            furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        }
//        print("\(furtherReachableSystems.count) systems reachable in ten jumps")
//        
//        for _ in 0..<5 {
//            furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        }
//        print("\(furtherReachableSystems.count) systems reachable in fifteen jumps")
//        
//        for _ in 0..<5 {
//            furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        }
//        print("\(furtherReachableSystems.count) systems reachable in twenty jumps")
//        
//        for _ in 0..<5 {
//            furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
//        }
//        print("\(furtherReachableSystems.count) systems reachable in twenty five jumps")
//        
//        // generate and display list of unreachable planets
//        let unreachablePlanets = getUnreachableSystems(furtherReachableSystems)
//        for system in unreachablePlanets {
//            print("unreachable: \(system.name)")
//        }
//        
//        print("reassigning...")
//        reassignCoordsOfUnreachableSystems(unreachablePlanets)
//        
//        
//        
//    }
    
    // puts failing system into galaxy, making sure it is between 5 and 13 parsecs from nearest neighbor
    // WORKS
    func reinsertSystemDoingAllChecks(_ system: StarSystem) {
        var passing = false
        
        while !passing {
            let wUpper: UInt32 = 148
            let wLower: UInt32 = 2
            let hUpper: UInt32 = 108
            let hLower: UInt32 = 2
            system.xCoord = Int(arc4random_uniform(wUpper - wLower) + wLower)
            system.yCoord = Int(arc4random_uniform(hUpper - hLower) + hLower)
            
            // check condition
            let minDistance = getDistanceToClosestNeighbor(system)
            if (minDistance <= 13) && (minDistance > 4) {
                passing = true
            }
        }
        
        system.locationChecked = true
    }
    
    func getDistanceToClosestNeighbor(_ system: StarSystem) -> Int {
        var runningMin = 1000
        for planet in planets {
            if (planet.name != system.name) && planet.locationChecked {
                let distance = getDistance(system, system2: planet)
                if distance < runningMin {
                    runningMin = distance
                }
            }
        }
        print("distance from \(system.name) to closest neighbor is \(runningMin)")
        return runningMin
    }
    
    // deals with alphabet issue by shuffling available planets array
    func shuffleAvailableNames(_ inputArray: [String]) -> [String] {
        var availableNames = inputArray
        var newArray: [String] = []
        
        while availableNames.count > 0 {
            let randomIndex = rand(availableNames.count)
            newArray.append(availableNames[randomIndex])
            availableNames.remove(at: randomIndex)
        }
        
        return newArray
    }
    
    func getUnreachablePlanets() -> [StarSystem] {
        // returns all planets unreachable from 13 parsec jumps from currentSystem
        
        var reachableSystems: [StarSystem] = []
        reachableSystems.append(currentSystem!)
        
        var systemsWithinTenOfCurrent: [StarSystem] = []
        let foundSystems = getSystemsInRangeOfPlanet(reachableSystems[0])
        for item in foundSystems {
            systemsWithinTenOfCurrent.append(item)
        }
        // first jump
        var furtherReachableSystems = planetsReachableWithinFurtherTenClicks(reachableSystems)
        //print("\(furtherReachableSystems.count) systems reachable in one jumps")
        
        // second jump
        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(systemsWithinTenOfCurrent)
        //print("\(furtherReachableSystems.count) systems reachable in two jumps")
        
        // third jump
        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
        //print("\(furtherReachableSystems.count) systems reachable in three jumps")
        
        // fourth jump
        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
        //print("\(furtherReachableSystems.count) systems reachable in four jumps")
        
        // fifth jump
        furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
        //print("\(furtherReachableSystems.count) systems reachable in five jumps")
        
        for _ in 0..<20 {
            furtherReachableSystems = planetsReachableWithinFurtherTenClicks(furtherReachableSystems)
        }
        //print("\(furtherReachableSystems.count) systems reachable in 25 jumps")
        
        // tag reachable
        for system in furtherReachableSystems {
            system.locationChecked = true
        }
        
        // generate and display list of unreachable planets
        let unreachablePlanets = getUnreachableSystems(furtherReachableSystems)

        
        //print("getUnreachablePlanets found \(unreachablePlanets.count) unreachable systems")
        return unreachablePlanets
    }
    
    func getUnreachablePlanetsCount() -> Int {
        let unreachable = getUnreachablePlanets()
        return unreachable.count
    }
    
    
    // reassigns unreachable, repeats until no more unreachable
    func reassignUnreachablePlanets() {
        while getUnreachablePlanetsCount() != 0 {
            reassignUnreachablePlanetsOnce()
        }
    }
    
    // reassigns once, used by above
    func reassignUnreachablePlanetsOnce() {
        let unreachable = getUnreachablePlanets()
        for planet in unreachable {
            reassignRandomCoords2(planet)
        }
    }
    
    func randomlyReassignCurrentSystem() {
        let random = rand(120)
        currentSystem = self.planets[random]
    }
    
    // don't use this, takes too long. Use makeSureContinuousJumpChain instead
//    func getJumpsToFirstPlanet(planetToBeTested: StarSystem) -> Int {
//        // if this returns zero, not reachable
//        
//        let target = planets[0]
//        
//        var planetsReachable: [StarSystem] = [target]
//        var tries = 0
//        while (tries < 25) {
//            // try one more jump
//            planetsReachable = planetsReachableWithinFurtherTenClicks(planetsReachable)
//            tries += 1
//            
//            // check if planet in planetsReachable
//            for planet in planetsReachable {
//                if planet.name == planetToBeTested.name {
//                    return tries
//                }
//            }
//        }
//        return 0
//    }
    
    // THIS ONE
    // makes sure planet has continuous jump chain, using flags to save time
    func makeSureContinuousJumpChain(_ planetToBeTested: StarSystem) -> Bool {
        
        // begins with planetToBeTested. Looks until it finds flagged planet. Once this test is run, planetToBeTested will be flagged to help this algorithm next time
        
        // if this is planets[0], flag and return true
        if planetToBeTested.name == planets[0].name {
            planetToBeTested.locationChecked = true
            return true
        }
        
        var planetsReachable: [StarSystem] = [planetToBeTested]
        var tries = 0
        while (tries < 25) {
            // try one more jump
            planetsReachable = planetsReachableWithinFurtherTenClicks(planetsReachable)
            tries += 1
            
            // check for flagged planet in planetsReachable. If found, done
            for planet in planetsReachable {
                
                // return true if flagged
                if planet.locationChecked {
                    planetToBeTested.locationChecked = true     // flag this planet for next time
                    return true
                }
            }
        }
        print("\(planetToBeTested.name) FAILS CONTINUOUS CHAIN)")
        return false
    }
    
    // debug method
    func planetsReachableWithinFurtherTenClicks(_ testArray: [StarSystem]) -> [StarSystem] {
        var foundSystemsNotUnique: [StarSystem] = []
        // for item in testArray, see who is in ten clicks
        for system in testArray {
            let found = getSystemsInRangeOfPlanet(system)
            for planet in found {
                foundSystemsNotUnique.append(planet)
            }
        }
        
        // strip redundancies
        var notRedundantReturnArray: [StarSystem] = []
        for system in foundSystemsNotUnique {
            var alreadyThere = false
            // see if this one is in notRedunantReturnArray yet
            for planet in notRedundantReturnArray {
                if planet.name == system.name {
                    alreadyThere = true
                }
            }
            
            // if not, add it
            if !alreadyThere {
                notRedundantReturnArray.append(system)
            }
        }
        
        return notRedundantReturnArray
    }
    
    // debug method
    func getUnreachableSystems(_ reachableArray: [StarSystem]) -> [StarSystem] {
        // given an array of planets, returns those planets in the galaxy not in that array
        
        // find still unreachable systems
        var unreachableSystems: [StarSystem] = []
        for system in planets {
            // go through furtherReachableSystems, if not there, add it
            var foundFlag = false
            for item in reachableArray {
                if item.name == system.name {
                    foundFlag = true
                }
            }
            
            if !foundFlag {
                unreachableSystems.append(system)
            }
        }
        
        return unreachableSystems
    }
    
    func reassignCoordsOfUnreachableSystems(_ unreachableSystems: [StarSystem]) {
        for system in unreachableSystems {
            // find it in galaxy
            for planet in planets {
                if planet.name == system.name {
                    // reassign its coords
                    reassignRandomCoords(planet)
                }
            }
        }
    }
    
//    func verifyMaxDistance(system1: StarSystem, i: Int) -> Bool {
//        var minDistance = 1000
//        
//        for index in 0..<i {
//            let distance = getDistance(system1, system2: planets[index])
//            if distance < minDistance {
//                minDistance = distance
//            }
//        }
//        
//        if minDistance > 13 {
//            return false
//        } else {
//            print("\(system1.name)'s closest neighbor is \(minDistance) parsecs away")
//            return true
//        }
//    }
    
    
    // END STUFF PERTAINING TO REACHABLE PLANETS ISSUE****************************************************
    
    func initializeMercenaries() {
        // initial array--all mercenary names, less the reserved ones
        var mercenariesAvailable = [MercenaryName.alyssa, MercenaryName.armatur, MercenaryName.bentos, MercenaryName.c2u2, MercenaryName.chiti, MercenaryName.crystal, MercenaryName.dane, MercenaryName.deirdre, MercenaryName.doc, MercenaryName.draco, MercenaryName.iranda, MercenaryName.jeremiah, MercenaryName.jujubal, MercenaryName.krydon, MercenaryName.luis, MercenaryName.mercedez, MercenaryName.milete, MercenaryName.muril, MercenaryName.mystyc, MercenaryName.nandi, MercenaryName.orestes, MercenaryName.pancho, MercenaryName.ps37, MercenaryName.quarck, MercenaryName.sosumi, MercenaryName.uma, MercenaryName.wesley, MercenaryName.wonton, MercenaryName.yorvick]
        
        // create mercenary, remove name from array
        while mercenariesAvailable.count > 0 {
            let randomIndex = rand(mercenariesAvailable.count)
            let mercenaryID = mercenariesAvailable[randomIndex]
            mercenariesAvailable.remove(at: randomIndex)
            
            // set skills randomly (costPerDay is automatically calculated)
            let newMercenary = CrewMember(ID: mercenaryID, pilot: rand(10, min: 1), fighter: rand(10, min: 1), trader: rand(10, min: 1), engineer: rand(10, min: 1))
            
            
            // give to a randomly chosen planet, max 2 per planet
            let randomPlanetIndex = rand(self.planets.count)
            
            self.planets[randomPlanetIndex].mercenaries.append(newMercenary)
            print("MERCENARY - name: \(newMercenary.name), p: \(newMercenary.pilot), f: \(newMercenary.fighter), t: \(newMercenary.trader), e: \(newMercenary.engineer), system: \(self.planets[randomPlanetIndex].name), costPerDay: \(newMercenary.costPerDay)")
        }
        
        
    }
    
    // initializeSpecial() ?
        
    
    func addToSystemCommodities(_ system: StarSystem, commodity: TradeItemType, amountToAdd: Int) {
        switch commodity {
            case .Water:
                system.water += amountToAdd
            case .Furs:
                system.furs += amountToAdd
            case .Food:
                system.food += amountToAdd
            case .Ore:
                system.ore += amountToAdd
            case .Games:
                system.games += amountToAdd
            case .Firearms:
                system.firearms += amountToAdd
            case .Medicine:
                system.medicine += amountToAdd
            case .Machines:
                system.machines += amountToAdd
            case .Narcotics:
                system.narcotics += amountToAdd
            case .Robots:
                system.robots += amountToAdd
            default:
                print("?")
        }
    }
    
    func setCommodityToZeroIfNegative(_ system: StarSystem, commodity: TradeItemType) {
        switch commodity {
            case .Water:
                if system.water < 0 {
                    system.water = 0
                }
            case .Furs:
                if system.furs < 0 {
                    system.furs = 0
                }
            case .Food:
                if system.food < 0 {
                    system.food = 0
                }
            case .Ore:
                if system.ore < 0 {
                    system.ore = 0
                }
            case .Games:
                if system.games < 0 {
                    system.games = 0
                }
            case .Firearms:
                if system.firearms < 0 {
                    system.firearms = 0
                }
            case .Medicine:
                if system.medicine < 0 {
                    system.medicine = 0
                }
            case .Machines:
                if system.machines < 0 {
                    system.machines = 0
                }
            case .Narcotics:
                if system.narcotics < 0 {
                    system.narcotics = 0
                }
            case .Robots:
                if system.robots < 0 {
                    system.robots = 0
                }
            default:
                print("?")
        }
    }
    
    func getLocalSellPrice(_ commodity: TradeItemType) -> Int {
        switch commodity {
            case TradeItemType.Water:
                return galaxy.targetSystem!.waterSell
            case TradeItemType.Furs:
                return galaxy.targetSystem!.fursSell
            case TradeItemType.Food:
                return galaxy.targetSystem!.foodSell
            case TradeItemType.Ore:
                return galaxy.targetSystem!.oreSell
            case TradeItemType.Games:
                return galaxy.targetSystem!.gamesSell
            case TradeItemType.Firearms:
                return galaxy.targetSystem!.firearmsSell
            case TradeItemType.Medicine:
                return galaxy.targetSystem!.medicineSell
            case TradeItemType.Machines:
                return galaxy.targetSystem!.machinesSell
            case TradeItemType.Narcotics:
                return galaxy.targetSystem!.narcoticsSell
            case TradeItemType.Robots:
                return galaxy.targetSystem!.robotsSell
            default:
                return 0
        }
    }
    
    func getAverageSalePrice(_ commodity: TradeItemType) -> Int {
        var runningSum = 0
        var count = 0
        
        for planet in planets {
            switch commodity {
                case TradeItemType.Water:
                    runningSum += planet.waterSell
                case TradeItemType.Furs:
                    runningSum += planet.fursSell
                case TradeItemType.Food:
                    runningSum += planet.foodSell
                case TradeItemType.Ore:
                    runningSum += planet.oreSell
                case TradeItemType.Games:
                    runningSum += planet.gamesSell
                case TradeItemType.Firearms:
                    runningSum += planet.firearmsSell
                case TradeItemType.Medicine:
                    runningSum += planet.medicineSell
                case TradeItemType.Machines:
                    runningSum += planet.machinesSell
                case TradeItemType.Narcotics:
                    runningSum += planet.narcoticsSell
                case TradeItemType.Robots:
                    runningSum += planet.robotsSell
            default:
                runningSum += 0
            }
            count += 1
        }
        return Int(Double(runningSum) / Double(count))
    }
    
    func setSpecial(_ system: String, id: SpecialEventID) {
        print("setSpecial firing: setting \(id)")                                  // DEBUG, REMOVE
        for planet in planets {
            if planet.name == system {
                planet.specialEvent = id
            }
        }
    }
    
    func setTracked(_ system: String) {
        for planet in planets {
            if planet.name == system {
                self.trackedSystem = planet
            }
        }
    }
    
    func unsetTracked() {
        self.trackedSystem = nil
    }
    
    func warp() -> Bool {
        // let journeyDistance = getDistance(currentSystem!, system2: targetSystem!)
        // print("pre-warp fuel: \(player.commanderShip.fuel)")
        // print("target system in range? \(targetSystemInRange)")
        // print("trip should require \(journeyDistance) fuel. You have \(player.commanderShip.fuel)")
        
        var canWeWarp = true
        if !targetSystemInRange {
            canWeWarp = false
        }
        
        // handle other checks, like on debt, set canWeWarp to false if they fail
        // check mercenary salary
        var mercenarySalary = 0
        for member in player.commanderShip.crew {
            mercenarySalary += member.costPerDay
        }
        if mercenarySalary > player.credits {
            canWeWarp = false
        }
        
        // charge interest, make sure player can pay
        var interest = 0
        switch player.difficulty {
        case DifficultyType.beginner:
            interest = 0
        case DifficultyType.easy:
            interest = Int(0.05 * Double(player.debt))
        case DifficultyType.normal:
            interest = Int(0.10 * Double(player.debt))
        case DifficultyType.hard:
            interest = Int(0.15 * Double(player.debt))
        case DifficultyType.impossible:
            interest = Int(0.20 * Double(player.debt))
        }
        
        if player.credits < interest {
            canWeWarp = false
//            print("WARP CANCELLED ON THE BASIS OF INTEREST PAYMENTS")
        } else {
            player.credits -= interest
        }
        
        // charge insurance, make sure player can pay
        if player.credits < player.insuranceCost {
            canWeWarp = false
//            print("WARP CANCELLED ON THE BASIS OF INSURANCE PAYMENT")
        } else {
            player.credits -= player.insuranceCost
        }
        
        if canWeWarp {
            // housekeeping things
            player.inspected = false
            player.credits -= mercenarySalary
            player.alreadyPaidForNewspaper = false
            player.caughtLittering = false
            //player.specialEvents.setSpecialEvent()
            
            // warp!
//            print("warp function signing off on warp and passing control to journey")
            currentJourney = Journey(origin: galaxy.currentSystem!, destination: galaxy.targetSystem!)
            currentJourney!.beginJourney()
            return true
        }
//        print("warp disallowed. Not enough fuel, or else something something like debt that I haven't implemented yet")
        return false
    }
    
    func warpWithSingularity() -> Bool {
        
        var canWeWarp = true
        
        var mercenarySalary = 0
        for member in player.commanderShip.crew {
            mercenarySalary += member.costPerDay
        }
        if mercenarySalary > player.credits {
            canWeWarp = false
        }
        
        // charge interest, make sure player can pay
        var interest = 0
        switch player.difficulty {
        case DifficultyType.beginner:
            interest = 0
        case DifficultyType.easy:
            interest = Int(0.05 * Double(player.debt))
        case DifficultyType.normal:
            interest = Int(0.10 * Double(player.debt))
        case DifficultyType.hard:
            interest = Int(0.15 * Double(player.debt))
        case DifficultyType.impossible:
            interest = Int(0.20 * Double(player.debt))
        }
        
        if player.credits < interest {
            canWeWarp = false
            print("WARP CANCELLED ON THE BASIS OF INTEREST PAYMENTS")
        } else {
            player.credits -= interest
        }
        
        // charge insurance, make sure player can pay
        if player.credits < player.insuranceCost {
            canWeWarp = false
            print("WARP CANCELLED ON THE BASIS OF INSURANCE PAYMENT")
        } else {
            player.credits -= player.insuranceCost
        }
        
        if canWeWarp {
            // housekeeping things
            player.inspected = false
            player.credits -= mercenarySalary
            player.alreadyPaidForNewspaper = false
            player.caughtLittering = false
            player.portableSingularity = true                  // TESTING ONLY
            
            // warp!
            print("warp function signing off on warp and passing control to journey")
            currentJourney = Journey(origin: galaxy.currentSystem!, destination: galaxy.targetSystem!)
            currentJourney!.beginJourney()
            return true
        }
        print("e by singularity disallowed.")
        return false
    }
    
    // added Jan 2018, no idea what happened to the original implementation of this functionality
    func initializeSpecials() {
        var specialsToBeAssigned: [SpecialEventID] = [SpecialEventID.eraseRecord, SpecialEventID.skillIncrease, SpecialEventID.cargoForSale, SpecialEventID.cargoForSale, SpecialEventID.cargoForSale, SpecialEventID.moonForSale, SpecialEventID.moonForSale]
        
        var sometimesSpecials: [SpecialEventID] = [SpecialEventID.alienArtifact, SpecialEventID.dragonfly, SpecialEventID.dangerousExperiment, SpecialEventID.gemulonInvasion, SpecialEventID.japoriDisease, SpecialEventID.ambassadorJarek, SpecialEventID.princess, SpecialEventID.morgansReactor, SpecialEventID.scarabStolen, SpecialEventID.sculpture, SpecialEventID.spaceMonster, SpecialEventID.wild, SpecialEventID.merchantPrice]
        
//        let planetsThatMustNotHaveSpecials: [StarSystemID] = [StarSystemID.baratas, StarSystemID.melina, StarSystemID.regulas, StarSystemID.zalkon, StarSystemID.daled, StarSystemID.gemulon, StarSystemID.japori, StarSystemID.devidia, StarSystemID.centauri, StarSystemID.utopia, StarSystemID.nix, StarSystemID.endor, StarSystemID.acamar, StarSystemID.kravat]
        
        var planetsThatMayHaveSpecials: [String] = ["Adhan", "Aldea", "Andevian", "Balosnee",  "Brax", "Bretel", "Calondia", "Campor", "Capelle", "Carzon", "Castor", "Cestus", "Cheron", "Courtney", "Damast", "Davlos", "Deneb", "Deneva", "Draylon", "Drema", "Esmee", "Exo", "Ferris", "Festen", "Fourmi", "Frolix", "Guinifer", "Hades", "Hamlet", "Helena", "Hulst", "Iodine", "Iralius", "Janus", "Jarada", "Jason", "Kaylon", "Khefka", "Kira", "Klaatu", "Klaestron", "Korma", "Krios", "Laertes", "Largo", "Lave", "Ligon", "Lowry", "Magrat", "Malcoria", "Mentar", "Merik", "Mintaka", "Montor", "Mordan", "Myrthe", "Nelvana", "Nyle", "Odet", "Og", "Omega", "Omphalos", "Orias", "Othello", "Parade", "Penthara", "Picard", "Pollux", "Quator", "Rakhar", "Ran", "Relva", "Rhymus", "Rochani", "Rubicum", "Rutia", "Sarpeidon", "Sefalla", "Seltrice", "Sigma", "Sol", "Somari", "Stakoron", "Styris", "Talani", "Tamus", "Tantalos", "Tanuga", "Tarchannen", "Terosa", "Thera", "Titan", "Torin", "Triacus", "Turkana", "Tyrus", "Umberlee", "Vadera", "Varga", "Vandor", "Ventax", "Xenon", "Xerxes", "Yew", "Yojimbo", "Zuul"]
        
        // shuffle arrays, using brilliant extension found on stackOverflow
        specialsToBeAssigned.shuffle()
        sometimesSpecials.shuffle()
        planetsThatMayHaveSpecials.shuffle()
        
        // choose about half the sometimes specials
        //var totalToInclude = sometimesSpecials.count
        //totalToInclude = totalToInclude / 2
        let totalSpecialsToInclude = 6
        
        for index in 0...totalSpecialsToInclude {
            specialsToBeAssigned.append(sometimesSpecials[index])
        }
        
        // assignment
        var specialIndex = 0
        for quest in specialsToBeAssigned {
            // pick planet
            let planetNameToAssign = planetsThatMayHaveSpecials[specialIndex]
            specialIndex += 1
            
            // dig planet with that name out of the array, assign its specialEvent
            if let index = self.planets.index(where: { $0.name == planetNameToAssign }) {
                self.planets[index].specialEvent = quest
                //print("Assigned special \(quest as Any) to \(self.planets[index].name)")
            }
        }
    }
    
    // NSCODING METHODS
    
    required init(coder decoder: NSCoder) {
        self.planets = decoder.decodeObject(forKey: "planets") as! [StarSystem]
        self.systemsInRange = decoder.decodeObject(forKey: "systemsInRange") as! [StarSystem]
        self.currentSystem = decoder.decodeObject(forKey: "currentSystem") as! StarSystem?
        self.targetSystem = decoder.decodeObject(forKey: "targetSystem") as! StarSystem?
        self.targetSystemInRange = decoder.decodeBool(forKey: "targetSystemInRange")
        self.trackedSystem = decoder.decodeObject(forKey: "trackedSystem") as! StarSystem?
        self.journeyJustFinished = decoder.decodeBool(forKey: "journeyJustFinished")
        self.spaceTimeMessedUp = decoder.decodeBool(forKey: "spaceTimeMessedUp")

        super.init()
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(planets, forKey: "planets")
        encoder.encode(systemsInRange, forKey: "systemsInRange")
        encoder.encode(currentSystem, forKey: "currentSystem")
        encoder.encode(targetSystem, forKey: "targetSystem")
        encoder.encode(targetSystemInRange, forKey: "targetSystemInRange")
        encoder.encode(trackedSystem, forKey: "trackedSystem")
        encoder.encode(journeyJustFinished, forKey: "journeyJustFinished")
        encoder.encode(spaceTimeMessedUp, forKey: "spaceTimeMessedUp")
    }
    
    
}
