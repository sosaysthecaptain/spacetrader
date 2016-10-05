//
//  EquipmentListVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

// THIS FILE IS NOW DEFUNCT AND UNUSED. CAN BE DELETED

import UIKit

class EquipmentListVC: UIViewController {

    var selectorIndex = 0
    
    var buyNotSell = true
    var weaponSelected: Weapon?
    var shieldSelected: Shield?
    var gadgetSelected: Gadget?
    
    //slot1weapon, etc
    var slot1Weapon: Weapon?
    var slot2Weapon: Weapon?
    var slot3Weapon: Weapon?
    var slot1Shield: Shield?
    var slot2Shield: Shield?
    var slot3Shield: Shield?
    var slot1Gadget: Gadget?
    var slot2Gadget: Gadget?
    var slot3Gadget: Gadget?
    
    var item1Weapon: Weapon?
    var item2Weapon: Weapon?
    var item3Weapon: Weapon?
    var item4Weapon: Weapon?
    var item5Weapon: Weapon?
    var item1Shield: Shield?
    var item2Shield: Shield?
    var item3Shield: Shield?
    var item4Shield: Shield?
    var item5Shield: Shield?
    var item1Gadget: Gadget?
    var item2Gadget: Gadget?
    var item3Gadget: Gadget?
    var item4Gadget: Gadget?
    var item5Gadget: Gadget?
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var itemSlots: UILabel!
    @IBOutlet weak var itemsAvalable: UILabel!
    
    @IBOutlet weak var slot1: CustomButton!
    @IBOutlet weak var slot2: CustomButton!
    @IBOutlet weak var slot3: CustomButton!
    
    @IBOutlet weak var item1: UIButton!
    @IBOutlet weak var item2: UIButton!
    @IBOutlet weak var item3: UIButton!
    @IBOutlet weak var item4: UIButton!
    @IBOutlet weak var item5: UIButton!
    
    
    //let universalArray: [UniversalGadgetType] = [UniversalGadgetType.pulseLaser, UniversalGadgetType.beamLaser, UniversalGadgetType.militaryLaser, UniversalGadgetType.photonDisruptor, UniversalGadgetType.energyShield, UniversalGadgetType.reflectiveShield, UniversalGadgetType.CargoBays, UniversalGadgetType.AutoRepair, UniversalGadgetType.Navigation, UniversalGadgetType.Targeting, UniversalGadgetType.Cloaking]
    
    let weaponsArray: [WeaponType] = [WeaponType.pulseLaser, WeaponType.beamLaser, WeaponType.militaryLaser, WeaponType.photonDisruptor]
    let shieldsArray: [ShieldType] = [ShieldType.energyShield, ShieldType.reflectiveShield]
    let gadgetsArray: [GadgetType] = [GadgetType.cargoBays, GadgetType.autoRepair, GadgetType.navigation, GadgetType.targeting, GadgetType.cloaking]
    
    var availableWeapons: [Weapon] = []
    var availableShields: [Shield] = []
    var availableGadgets: [Gadget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateAvailable()
        populateSlots()
        populateLabels()
        
    }
    
    

    @IBAction func indexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("weapons selected")
                selectorIndex = 0
                populateLabels()
                populateSlots()
            case 1:
                print("shields selected")
                selectorIndex = 1
                populateLabels()
                populateSlots()
            case 2:
                print("gadgets selected")
                selectorIndex = 2
                populateLabels()
                populateSlots()
            default:
                print("error")
        }
    }

    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func populateLabels() {
        if selectorIndex == 0 {
            itemSlots.text = "Weapon Slots on Your Ship:"
            itemsAvalable.text = "Weapons Available:"
            
            let controlState = UIControlState()
            
            item1.setTitle("", for: controlState)
            item2.setTitle("", for: controlState)
            item3.setTitle("", for: controlState)
            item4.setTitle("", for: controlState)
            item5.setTitle("", for: controlState)
            
            if availableWeapons.count >= 1 {
                item1.setTitle("\(availableWeapons[0].name)", for: controlState)
            }
            if availableWeapons.count >= 2 {
                item2.setTitle("\(availableWeapons[1].name)", for: controlState)
            }
            if availableWeapons.count >= 3 {
                item3.setTitle("\(availableWeapons[2].name)", for: controlState)
            }
            if availableWeapons.count >= 4 {
                item4.setTitle("\(availableWeapons[3].name)", for: controlState)
            }
            if availableWeapons.count >= 5 {
                item5.setTitle("\(availableWeapons[4].name)", for: controlState)
            }
            
        } else if selectorIndex == 1 {
            itemSlots.text = "Shield Slots on Your Ship:"
            itemsAvalable.text = "Shields Available:"
            
            let controlState = UIControlState()
            
            item1.setTitle("", for: controlState)
            item2.setTitle("", for: controlState)
            item3.setTitle("", for: controlState)
            item4.setTitle("", for: controlState)
            item5.setTitle("", for: controlState)
            
            if availableWeapons.count >= 1 {
                item1.setTitle("\(availableShields[0].name)", for: controlState)
            }
            if availableWeapons.count >= 2 {
                item2.setTitle("\(availableShields[1].name)", for: controlState)
            }
            if availableWeapons.count >= 3 {
                item3.setTitle("\(availableShields[2].name)", for: controlState)
            }
            if availableWeapons.count >= 4 {
                item4.setTitle("\(availableShields[3].name)", for: controlState)
            }
            if availableWeapons.count >= 5 {
                item5.setTitle("\(availableShields[4].name)", for: controlState)
            }
            
        } else if selectorIndex == 2 {
            itemSlots.text = "Gadget Slots on Your Ship:"
            itemsAvalable.text = "Gadgets Available:"
            
            let controlState = UIControlState()
            
            item1.setTitle("", for: controlState)
            item2.setTitle("", for: controlState)
            item3.setTitle("", for: controlState)
            item4.setTitle("", for: controlState)
            item5.setTitle("", for: controlState)
            
            if availableWeapons.count >= 1 {
                item1.setTitle("\(availableGadgets[0].name)", for: controlState)
            }
            if availableWeapons.count >= 2 {
                item2.setTitle("\(availableGadgets[1].name)", for: controlState)
            }
            if availableWeapons.count >= 3 {
                item3.setTitle("\(availableGadgets[2].name)", for: controlState)
            }
            if availableWeapons.count >= 4 {
                item4.setTitle("\(availableGadgets[3].name)", for: controlState)
            }
            if availableWeapons.count >= 5 {
                item5.setTitle("\(availableGadgets[4].name)", for: controlState)
            }
        }
    }
    
    func populateAvailable() {
        let currentSystemTechLevel = getTechLevelInt(galaxy.currentSystem!.techLevel)
        
        for item in weaponsArray {
            let prototype = Weapon(type: item)
            let neededTechLevel = getTechLevelInt(prototype.techLevel)
            if neededTechLevel <= currentSystemTechLevel {
                print("including \(prototype.name)")
                availableWeapons.append(prototype)
            }
        }
        
        for item in shieldsArray {
            let prototype = Shield(type: item)
            let neededTechLevel = getTechLevelInt(prototype.techLevel)
            if neededTechLevel <= currentSystemTechLevel {
                print("including \(prototype.name)")
                availableShields.append(prototype)
            }
        }
        
        for item in gadgetsArray {
            let prototype = Gadget(type: item)
            let neededTechLevel = getTechLevelInt(prototype.techLevel)
            if neededTechLevel <= currentSystemTechLevel {
                print("including \(prototype.name)")
                availableGadgets.append(prototype)
            }
            
        }
    }
    
    func populateSlots() {
        // set all titles to empty
        let controlState = UIControlState()
        slot1.setTitle("Slot 1: <empty>", for: controlState)
        slot2.setTitle("Slot 2: <empty>", for: controlState)
        slot3.setTitle("Slot 3: <empty>", for: controlState)
        
        // get correct number of slots
        var numberOfSlots = 0
        switch selectorIndex {
            case 0:
                numberOfSlots = player.commanderShip.weaponSlots
            case 1:
                numberOfSlots = player.commanderShip.shieldSlots
            case 2:
                numberOfSlots = player.commanderShip.gadgetSlots
            default:
                print("error")
        }
        
        // display correct number of slots
        switch numberOfSlots {
        case 0:
            slot1.isEnabled = false
            slot2.isEnabled = false
            slot3.isEnabled = false
        case 1:
            slot1.isEnabled = true
            slot2.isEnabled = false
            slot3.isEnabled = false
        case 2:
            slot1.isEnabled = true
            slot2.isEnabled = true
            slot3.isEnabled = false
        case 3:
            slot1.isEnabled = true
            slot2.isEnabled = true
            slot3.isEnabled = true
        default:
            print("error")
        }
        
        //
        if selectorIndex == 0 {
            let controlState = UIControlState()
            
            if player.commanderShip.weapon.count >= 1 {
                slot1.setTitle("Slot 1: \(player.commanderShip.weapon[0].name)", for: controlState)
            }
            if player.commanderShip.weapon.count >= 2 {
                slot2.setTitle("Slot 2: \(player.commanderShip.weapon[1].name)", for: controlState)
            }
            if player.commanderShip.weapon.count >= 3 {
                slot3.setTitle("Slot 3: \(player.commanderShip.weapon[2].name)", for: controlState)
            }
        } else if selectorIndex == 1 {
            let controlState = UIControlState()
            
            if player.commanderShip.shield.count >= 1 {
                slot1.setTitle("Slot 1: \(player.commanderShip.shield[0].name)", for: controlState)
            }
            if player.commanderShip.shield.count >= 2 {
                slot2.setTitle("Slot 2: \(player.commanderShip.shield[1].name)", for: controlState)
            }
            if player.commanderShip.shield.count >= 3 {
                slot3.setTitle("Slot 3: \(player.commanderShip.shield[2].name)", for: controlState)
            }
            
        } else if selectorIndex == 2 {
            let controlState = UIControlState()
            
            if player.commanderShip.gadget.count >= 1 {
                slot1.setTitle("Slot 1: \(player.commanderShip.gadget[0].name)", for: controlState)
            }
            if player.commanderShip.gadget.count >= 2 {
                slot2.setTitle("Slot 2: \(player.commanderShip.gadget[1].name)", for: controlState)
            }
            if player.commanderShip.gadget.count >= 3 {
                slot3.setTitle("Slot 3: \(player.commanderShip.gadget[2].name)", for: controlState)
            }
            
        }
    }
    
    @IBAction func item1Button(_ sender: AnyObject) {
        performSegue(withIdentifier: "gadgetDetail", sender: nil)
    }
    
    @IBAction func item2Button(_ sender: AnyObject) {
        performSegue(withIdentifier: "gadgetDetail", sender: nil)
    }
    
    @IBAction func item3Button(_ sender: AnyObject) {
        performSegue(withIdentifier: "gadgetDetail", sender: nil)
    }
    
    @IBAction func item4Button(_ sender: AnyObject) {
        performSegue(withIdentifier: "gadgetDetail", sender: nil)
    }
    
    @IBAction func item5Button(_ sender: AnyObject) {
        performSegue(withIdentifier: "gadgetDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "gadgetDetail") {
            
//            let vc = (segue.destinationViewController as! ShipDetailVC)
//            vc.ship = chosenShip
//            vc.typeOfShip = chosenShipType
            // vc.buyNotSell = buyNotSell
            // vc.weaponSelected = weaponSelected
            // vc.shieldSeelcted = shieldSelected
            // vc.gadgetSelected = gadgetSelected
        }
        
    }
    
}
