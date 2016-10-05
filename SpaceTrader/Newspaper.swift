//
//  Newspaper.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/3/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation

class Newspaper: NSObject, NSCoding {
    var stories: [String] = []
    
    override init() {
        // deliberately empty
    }
    
    func generatePaper() {
        self.stories = []
        
        // Special Events get to go first, crowding out other news
        getSpecialEventHeadline()
        
        // character-specific news
        getCharacterSpecificNews()
        
        // status headline
        getStatusHeadline()
        
        // useful news. Chance of it appearing is 50% + 10% per difficulty level less than impossible
        // shows special conditions of other systems in range
        getUsefulNews()
        
        // moon vendor and tribble collector always get shown
        // (where are these? This is presumably anywhere within range?)
        moonAndTribbles()
        
        
        // add a canned headline
        getCannedHeadline()

        // if slow news day, add another canned headline
        if stories.count < 3 {
            getCannedHeadline()
            repeat {
                print("executing")
                stories.remove(at: stories.count - 1)
                getCannedHeadline()
            } while stories[stories.count-1] == stories[stories.count-2]
        }
        
        // shuffle?
        shuffle()
        
        for _ in 0..<5 {
            stories.append("")
        }
    }
    
    func shuffle() {
        var drawFrom: [String] = []
        let top = min(stories.count, 5)
        for i in 0..<top {
            drawFrom.append(stories[i])
        }
        
        var output: [String] = []
        while drawFrom.count > 0 {
            let index = rand(drawFrom.count)
            output.append(drawFrom[index])
            drawFrom.remove(at: index)
        }
        stories = output
    }
    
    
    func getSpecialEventHeadline() {
        let optionalSpecialEventID = galaxy.currentSystem!.newsItemDropBox  // doing only one story
        galaxy.currentSystem!.newsItemDropBox = nil
        
        if optionalSpecialEventID != nil {
            let specialEventID = optionalSpecialEventID!
            var string = ""
            
            switch specialEventID {
            case NewsItemID.artifactDelivery: string = "Scientist Adds Alien Artifact to Museum Collection."
            case NewsItemID.caughtLittering: string = "Police Trace Orbiting Space Litter to \(player.commanderName)."
            case NewsItemID.dragonfly: string = "Experimental Craft Stolen! Critics Demand Security Review."
            case NewsItemID.dragonflyBaratas: string = "Investigators Report Strange Craft."
            case NewsItemID.dragonflyDestroyed: string = "Spectacular Display as Stolen Ship Destroyed in Fierce Space Battle."
            case NewsItemID.dragonflyMelina: string = "Rumors Continue: Melina Orbitted by Odd Starcraft."
            case NewsItemID.dragonflyRegulas: string = "Strange Ship Observed in Regulas Orbit."
            case NewsItemID.dragonflyZalkon: string = "Unidentified Ship: A Threat to Zalkon?"
            case NewsItemID.experimentFailed: string = "Huge Explosion Reported at Research Facility."
            case NewsItemID.experimentPerformed: string = "Travelers Report Spacetime Damage, Warp Problems!"
            case NewsItemID.experimentStopped: string = "Scientists Cancel High-profile Test! Committee to Investigate Design."
            case NewsItemID.experimentArrival: string = "Travelers Claim Sighting of Ship Materializing in Orbit!"
            case NewsItemID.gemulon: string = "Editorial: Who Will Warn Gemulon?"
            case NewsItemID.gemulonInvaded: string = "Alien Invasion Devastates Planet!"
            case NewsItemID.gemulonRescued: string = "Invasion Imminent! Plans in Place to Repel Hostile Invaders."
            case NewsItemID.captAhabAttacked: string = "Thug Assaults Captain Ahab!"
            case NewsItemID.captAhabDestroyed: string = "Destruction of Captain Ahab's Ship Causes Anger!"
            case NewsItemID.captConradAttacked: string = "Captain Conrad Comes Under Attack By Criminal!"
            case NewsItemID.captConradDestroyed: string = "Captain Conrad's Ship Destroyed by Villain!"
            case NewsItemID.captHuieAttacked: string = "Famed Captain Huie Attacked by Brigand!"
            case NewsItemID.captHuieDestroyed: string = "Citizens Mourn Destruction of Captain Huie's Ship!"
            case NewsItemID.japori: string = "Editorial: We Must Help Japori!"
            case NewsItemID.japoriDelivery: string = "Disease Antidotes Arrive! Health Officials Optimistic."
            case NewsItemID.jarekGetsOut: string = "Ambassador Jarek Returns from Crisis."
            case NewsItemID.scarab: string = "Security Scandal: Test Craft Confirmed Stolen."
            case NewsItemID.scarabDestroyed: string = "Wormhole Traffic Delayed as Stolen Craft Destroyed."
            case NewsItemID.scarabHarass: string = "Wormhole Travelers Harassed by Unusual Ship!"
            case NewsItemID.spaceMonster: string = "Space Monster Threatens Homeworld!"
            case NewsItemID.spaceMonsterKilled: string = "Hero Slays Space Monster! Parade, Honors Planned for Today."
            case NewsItemID.wildArrested: string = "Notorious Criminal Jonathan Wild Arrested!"
            case NewsItemID.wildGetsOut: string = "Rumors Suggest Known Criminal J. Wild May Come to Kravat!"
            case NewsItemID.sculptureStolen: string = "Priceless collector's item stolen from home of Geurge Locas!"
            case NewsItemID.sculptureTracked: string = "Space Corps follows \(player.commanderName) with alleged stolen sculpture to \(galaxy.currentSystem!.name)."
            case NewsItemID.princess: string = "Member of Royal Family kidnapped!"
            case NewsItemID.princessCentauri: string = "Aggressive Ship Seen in Orbit Around Centauri"
            case NewsItemID.princessInthara: string = "Dangerous Scorpion Damages Several Other Ships Near Inthara"
            case NewsItemID.princessQuonos: string = "Kidnappers Holding Out at Qonos"
            case NewsItemID.princessRescued: string = "Scorpion Defeated! Kidnapped Member of Galvon Royal Family Freed!"
            case NewsItemID.princessReturned: string = "Beloved Royal Returns Home!"
            }
            
            self.stories.append(string)
        }
    }
    
    func getCharacterSpecificNews() {
        if (player.policeRecord == PoliceRecordType.villainScore) || (player.policeRecord == PoliceRecordType.psychopathScore) {
            var string = ""
            let rand3 = rand(4)
            switch rand3 {
            case 0:
                string = "Police Warning: \(player.commanderName) Will Dock At \(galaxy.currentSystem!.name)!"
            case 1:
                string = "Notorious Criminal \(player.commanderName) Sighted in \(galaxy.currentSystem!.name) System!"
            case 2:
                string = "Locals Rally to Deny Spaceport Access to \(player.commanderName)!"
            case 3:
                string = "Terror Strikes Locals on Arrival of \(player.commanderName)!"
            default:
                print("error")
            }
            self.stories.append(string)
        }
        
        if player.policeRecord == PoliceRecordType.heroScore {
            var string = ""
            let rand4 = rand(3)
            switch rand4 {
            case 0:
                string = "Locals Welcome Visiting Hero \(player.commanderName)!"
            case 1:
                string = "Famed Hero \(player.commanderName) to Visit System!"
            case 2:
                string = "Large Turnout At Spaceport to Welcome \(player.commanderName)!"
            default:
                print("error")
            }
            self.stories.append(string)
        }
        
        // caught littering?
        if player.caughtLittering {
            let string = "Police Trace Orbiting Space Litter to \(player.commanderName)."
            self.stories.append(string)
        }
    }
    
    func moonAndTribbles() {
        // TO DO***************************************************************************************
        // for system in systemsInRange
        // if system.special == one (next do the other)
        // display line
        
        // "Collector in \() Seeks to Purchase Tribbles."
        // "Seller in \() System has Utopian Moon Available."
    }
    
    func getUsefulNews() {
        // chance of a useful news story appearing is 50% + 10% per difficulty level less than impossible
        
        // find systems with stuff going on
        var systems: [StarSystem] = []
        for system in galaxy.systemsInRange {
            if system.status != StatusType.none {
                systems.append(system)
            }
        }
        
        for system in systems {
            let random = rand(100)
            let upperBound = 50 + (40 - (player.difficultyInt * 10))
            
            if random < upperBound {
                let systemName = system.name
                let systemStatus = system.status
                
                var firstPart = ""
                var secondPart = ""
                var thirdPart = ""
                
                // set first part
                let rand2 = rand(6)
                switch rand2 {
                case 0:
                    firstPart = "Reports of "
                case 1:
                    firstPart = "News of  "
                case 2:
                    firstPart = "New Rumors of "
                case 3:
                    firstPart = "Sources say "
                case 4:
                    firstPart = "Notice: "
                case 5:
                    firstPart = "Evidence suggests "
                default:
                    firstPart = ""
                }
                
                // set second part
                switch systemStatus {
                case StatusType.war:
                    secondPart = "Strife and War "
                case StatusType.plague:
                    secondPart = "Plague Outbreaks "
                case StatusType.drought:
                    secondPart = "Severe Drought "
                case StatusType.boredom:
                    secondPart = "Terrible Boredom "
                case StatusType.cold:
                    secondPart = "Cold Weather "
                case StatusType.cropFailure:
                    secondPart = "Crop Failures "
                case StatusType.employment:
                    secondPart = "Labor Shortages "
                default:
                    print("error")
                }
                
                // set third part, assemble, append headline
                thirdPart = "in the \(systemName) system."
                let string = firstPart + secondPart + thirdPart
                self.stories.append(string)
            }
        }
    }
    
    func getStatusHeadline() {
        if galaxy.currentSystem!.status != StatusType.none {
            var headline = ""
            switch galaxy.currentSystem!.status
            {
            case StatusType.war:
                headline = "War News: Offensives Continue!"
            case StatusType.plague:
                headline = "Plague Spreads! Outlook Grim."
            case StatusType.drought:
                headline = "No Rain in Sight!"
            case StatusType.boredom:
                headline = "Editors: Won't Someone Entertain Us?"
            case StatusType.cold:
                headline = "Cold Snap Continues!"
            case StatusType.cropFailure:
                headline = "Serious Crop Failure! Must We Ration?"
            case StatusType.employment:
                headline = "Jobless Rate at All-Time Low!"
            default:
                headline = ""
            }
            
            self.stories.append(headline)
        }
    }
    
    func getCannedHeadline() {
        let random = rand(4)
        var headline: String = ""
        switch galaxy.currentSystem!.politics {
        case PoliticsType.anarchy:
            switch random {
            case 0: headline = "Riots, Looting Mar Factional Negotiations."
            case 1: headline = "Communities Seek Consensus."
            case 2: headline = "Successful Bakunin Day Rally!"
            case 3: headline = "Major Faction Conflict Expected for the Weekend!"
            default: headline = ""
            }
        case PoliticsType.capitalist:
            switch random {
            case 0: headline = "Editorial: Taxes Too High!"
            case 1: headline = "Market Indices Read Record Levels!"
            case 2: headline = "Corporate Profits Up!"
            case 3: headline = "Restrictions on Corporate Freedom Abolished by Courts!"
            default: headline = ""
            }
        case PoliticsType.communist:
            switch random {
            case 0: headline = "Party Reports Productivity Increase."
            case 1: headline = "Counter-Revolutionary Bureaucrats Purged from Party!"
            case 2: headline = "Party: Bold New Future Predicted!"
            case 3: headline = "Politburo Approves New 5-Year Plan!"
            default: headline = ""
            }
        case PoliticsType.confederacy:
            switch random {
            case 0: headline = "States Dispute Natural Resource Rights!"
            case 1: headline = "States Denied Federal Funds Over Local Laws!"
            case 2: headline = "Southern States Resist Federal Taxation for Capital Projects!"
            case 3: headline = "States Request Federal Intervention in Citrus Conflict!"
            default: headline = ""
            }
        case PoliticsType.corporate:
            switch random {
            case 0: headline = "Robot Shortages Predicted for Q4."
            case 1: headline = "Profitable Quarter Predicted."
            case 2: headline = "CEO: Corporate Rebranding Progressing."
            case 3: headline = "Advertising Budgets to Increase."
            default: headline = ""
            }
        case PoliticsType.cybernetic:
            switch random {
            case 0: headline = "Olympics: Software Beats Wetware in All Events!"
            case 1: headline = "New Network Protocols To Be Deployed."
            case 2: headline = "Storage Banks to be Upgraded!"
            case 3: headline = "System Backup Rescheduled."
            default: headline = ""
            }
        case PoliticsType.democracy:
            switch random {
            case 0: headline = "Local Elections on Schedule!"
            case 1: headline = "Polls: Voter Satisfaction High!"
            case 2: headline = "Campaign Spending Aids Economy!"
            case 3: headline = "Police, Politicians Vow Improvements."
            default: headline = ""
            }
        case PoliticsType.dictatorship:
            switch random {
            case 0: headline = "New Palace Planned; Taxes Increase."
            case 1: headline = "Future Presents More Opportunities for Sacrifice!"
            case 2: headline = "Insurrection Crushed: Rebels Executed!"
            case 3: headline = "Police Powers to Increase!"
            default: headline = ""
            }
        case PoliticsType.fascist:
            switch random {
            case 0: headline = "Drug Smugglers Sentenced to Death!"
            case 1: headline = "Aliens Required to Carry Visible Identification at All Times!"
            case 2: headline = "Foreign Sabotage Suspected."
            case 3: headline = "Stricter Immigration Laws Installed."
            default: headline = ""
            }
        case PoliticsType.feudal:
            switch random {
            case 0: headline = "Farmers Drafted to Defend Lord's Castle!"
            case 1: headline = "Report: Kingdoms Near Flashpoint!"
            case 2: headline = "Baron Ignores Ultimatum!"
            case 3: headline = "War of Succession Threatens!"
            default: headline = ""
            }
        case PoliticsType.military:
            switch random {
            case 0: headline = "Court-Martials Up 2% This Year."
            case 1: headline = "Editorial: Why Wait to Invade?"
            case 2: headline = "HQ: Invasion Plans Reviewed."
            case 3: headline = "Weapons Research Increases Kill-Ratio!"
            default: headline = ""
            }
        case PoliticsType.monarchy:
            switch random {
            case 0: headline = "King to Attend Celebrations."
            case 1: headline = "Queen's Birthday Celebration Ends in Riots!"
            case 2: headline = "King Commissions New Artworks."
            case 3: headline = "Prince Exiled for Palace Plot!"
            default: headline = ""
            }
        case PoliticsType.pacifist:
            switch random {
            case 0: headline = "Dialog Averts Eastern Conflict!"
            case 1: headline = "Universal Peace: Is it Possible?"
            case 2: headline = "Universal Peace: Is it Possible?"
            case 3: headline = "Polls: Happiness Quotient High!"
            default: headline = ""
            }
        case PoliticsType.satori:
            switch random {
            case 0: headline = "Millions at Peace."
            case 1: headline = "Sun Rises."
            case 2: headline = "Countless Hearts Awaken."
            case 3: headline = "Serenity Reigns."
            default: headline = ""
            }
        case PoliticsType.socialist:
            switch random {
            case 0: headline = "Government Promises Increased Welfare Benefits!"
            case 1: headline = "Council Votes to Raise Minimum Wage."
            case 2: headline = "Maternity Benefits Increased!"
            case 3: headline = "Military Spending Cut Referendum Goes To Vote on Wednesday."
            default: headline = ""
            }
        case PoliticsType.technocracy:
            switch random {
            case 0: headline = "New Processor Hits 10 Zettaherz!"
            case 1: headline = "Nanobot Output Exceeds Expectation."
            case 2: headline = "Last Human Judge Retires."
            case 3: headline = "Software Bug Causes Mass Confusion."
            default: headline = ""
            }
        case PoliticsType.theocracy:
            switch random {
            case 0: headline = "High Priest to Hold Special Services."
            case 1: headline = "Temple Restoration Fund at 81%."
            case 2: headline = "Sacred Texts on Public Display."
            case 3: headline = "Dozen Blasphemers Excommunicated!"
            default: headline = ""
            }
        }
        self.stories.append(headline)
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.stories = decoder.decodeObject(forKey: "stories") as! [String]

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(stories, forKey: "stories")
    }
}

enum NewsItemID: Int {
    case artifactDelivery = 0
    case caughtLittering
    case dragonfly
    case dragonflyBaratas
    case dragonflyDestroyed
    case dragonflyMelina
    case dragonflyRegulas
    case dragonflyZalkon
    case experimentFailed
    case experimentPerformed
    case experimentStopped
    case experimentArrival
    case gemulon
    case gemulonInvaded
    case gemulonRescued
    case captAhabAttacked
    case captAhabDestroyed
    case captConradAttacked
    case captConradDestroyed
    case captHuieAttacked
    case captHuieDestroyed
    case japori
    case japoriDelivery
    case jarekGetsOut
    case scarab
    case scarabDestroyed
    case scarabHarass
    case spaceMonster
    case spaceMonsterKilled
    case wildArrested
    case wildGetsOut
    case sculptureStolen
    case sculptureTracked
    case princess
    case princessCentauri
    case princessInthara
    case princessQuonos
    case princessRescued
    case princessReturned
    
}
