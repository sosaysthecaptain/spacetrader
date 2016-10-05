//
//  Utils.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/25/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import Foundation

// utilities
// arc4rand sucks. Let's fix it.
// rand is inclusive on the lower bound, exclusive on the upper.
func rand(_ max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}

func rand(_ max: Int, min: Int) -> Int {
    let maxUInt = UInt32(max)
    let minUInt = UInt32(min)
    return Int(arc4random_uniform(maxUInt - minUInt) + minUInt)
}

func randDouble(_ max: Double, min: Double) -> Double {
    let maxUInt = UInt32(max * 100)
    let minUInt = UInt32(min * 100)
    let resultInt = Int(arc4random_uniform(maxUInt - minUInt) + minUInt)
    let resultDouble = Double(resultInt)
    return (resultDouble / 100)
}

func getTechLevelInt(_ techLevel: TechLevelType) -> Int {
    switch techLevel {
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

func getUniversalGadgetType(_ device: UniversalGadgetType) -> Int {
    // returns 0 if device is weapon, 1 if shield, 2 if gadget
    switch device {
        case UniversalGadgetType.pulseLaser:
            return 0
        case UniversalGadgetType.beamLaser:
            return 0
        case UniversalGadgetType.militaryLaser:
            return 0
        case UniversalGadgetType.photonDisruptor:
            return 0
        case UniversalGadgetType.morgansLaser:
            return 0
        case UniversalGadgetType.energyShield:
            return 1
        case UniversalGadgetType.reflectiveShield:
            return 1
        case UniversalGadgetType.lightningShield:
            return 1
        default:
            return 2
    }
}
