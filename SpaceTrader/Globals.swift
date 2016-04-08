//
//  Globals.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/18/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation
import UIKit

// these things should remain, but should not necessarily be populated, or should be populated with default values, with proper initialization to follow

// initial setup of these two, to be overridden. Here so they don't have to be optionals.
var player = Commander(commanderName: "default", difficulty: DifficultyType.normal, pilotSkill: 1, fighterSkill: 1, traderSkill: 1, engineerSkill: 1)
var galaxy = Galaxy()

var savedGames: [NamedSavedGame] = []       // all saved games stored here on initial restore

var gameInProgress = true           // probably use player.endGameType in place of this

var highScoreArchive = HighScoreArchive()

var currentSystem = StarSystem(
    name: "Daled",
    techLevel: TechLevelType.techLevel3,
    politics: PoliticsType.democracy,
    status: StatusType.employment,
    xCoord: 40,
    yCoord: 50,
    specialResources: SpecialResourcesType.richSoil,
    size: SizeType.Large)

var targetSystem = StarSystem(
    name: "Drema",
    techLevel: TechLevelType.techLevel5,
    politics: PoliticsType.technocracy,
    status: StatusType.none,
    xCoord: 63,
    yCoord: 4,
    specialResources:
    SpecialResourcesType.none,
    size: SizeType.Medium)

var systemsInRange: [StarSystem] = []

var buySellCommodity: TradeItemType?
var buyAsOpposedToSell: Bool = true
var plunderAsOpposedToJettison: Bool = true

var justFinishedJettisonNotPlunder = false

var travelBySingularity = false
var dontDeleteLocalSpecialEvent = false

var specialVCAlert: Alert?


// settable constants:

let MAXSOLARSYSTEM = 119
let MAXWORMHOLE = 6
let MINDISTANCE = 6
let CLOSEDISTANCE = 13
let GALAXYWIDTH = 150
let GALAXYHEIGHT = 110

let ACAMARSYSTEM = 0
let BARATASSYSTEM = 6
let DALEDSYSTEM = 17
let DEVIDIASYSTEM = 22
let GEMULONSYSTEM = 32
let JAPORISYSTEM = 41
let KRAVATSYSTEM = 50
let MELINASYSTEM = 59
let NIXSYSTEM = 67
let OGSYSTEM = 70
let REGULASSYSTEM = 82
let SOLSYSTEM = 92
let UTOPIASYSTEM = 109
let ZALKONSYSTEM = 118

// colors (note: supposedly UIColorFromRGB("F21B3F") is a thing, can't make it work, used extension)
let mainPurple = UIColor(netHex:0x2E009F)
let textGray = UIColor(netHex:0x2E2E2E)
let inactiveGray = UIColor(netHex:0x848484)
let mapBlue = UIColor(netHex:0x4b02FF)
let mapGreen = UIColor(netHex:0x00A72E)

