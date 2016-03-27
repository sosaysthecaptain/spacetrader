//
//  EquipmentList2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/26/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class EquipmentList2VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectorIndex = 0
    
    let weaponsArray: [WeaponType] = [WeaponType.pulseLaser, WeaponType.beamLaser, WeaponType.militaryLaser, WeaponType.photonDisruptor]
    let shieldsArray: [ShieldType] = [ShieldType.energyShield, ShieldType.reflectiveShield]
    let gadgetsArray: [GadgetType] = [GadgetType.CargoBays, GadgetType.AutoRepair, GadgetType.Navigation, GadgetType.Targeting, GadgetType.Cloaking]
    
    var inventoryKeyArray: [String] = []
    var inventoryValueArray: [String] = []
    var inventoryDisclosureIndicator: [Bool] = []
    
    
    var shipItems: [UniversalGadget] = []
    var availableItems: [UniversalGadget] = []
    var shipItemsCount = 0
    
    var chosenItem: UniversalGadget?
    var buyNotSell = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.reloadData()
        self.refreshView()
        
        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //self.tableView.reloadData()
        //self.refreshView()
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        print("segmented control value: \(segmentedControl.selectedSegmentIndex)")
        selectorIndex = segmentedControl.selectedSegmentIndex
        //self.tableView.reloadData()
        self.refreshView()
    }
    
    // imported refreshView:
    
    func refreshView() {
        if selectorIndex == 0 {
//            slotsLabel.text = "Weapon Slots on Your Ship:"
//            availableLabel.text = "Weapons Available:"
            
            // populate current weapons
            inventoryKeyArray = []
            inventoryValueArray = []
            inventoryDisclosureIndicator = []
            shipItems = []
            let weaponSlotCount = player.commanderShip.weaponSlots
            if weaponSlotCount == 0 {
                inventoryKeyArray.append("<Your Ship Has No Weapon Slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add weapons
                var slotNumber = 1
                for item in player.commanderShip.weapon {
                    inventoryKeyArray.append("Weapon slot \(slotNumber)")
                    inventoryValueArray.append("\(item.name)")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 0, wType: item.type, sType: nil, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (weaponSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("Weapon slot \(slotNumber)")
                    inventoryValueArray.append("<empty>")
                    inventoryDisclosureIndicator.append(false)
                    slotNumber += 1
                }
            }
            
            // populate available weapons
            availableItems = []
            for item in weaponsArray {
                // if available in this system
                let weapon = Weapon(type: item)
                let currentTechLevel = getTechLevelInt(galaxy.currentSystem!.techLevel)
                let itemTechLevel = getTechLevelInt(weapon.techLevel)
                if (currentTechLevel + 1) >= itemTechLevel {
                    // add it to the array
                    let newUniversalGadget = UniversalGadget(typeIndex: 0, wType: item, sType: nil, gType: nil)
                    availableItems.append(newUniversalGadget)
                }
            }
            self.tableView.reloadData()
            
        } else if selectorIndex == 1 {
//            slotsLabel.text = "Shield Slots on Your Ship:"
//            availableLabel.text = "Shields Available:"
            
            // populate current shields
            inventoryKeyArray = []
            inventoryValueArray = []
            inventoryDisclosureIndicator = []
            shipItems = []
            let shieldSlotCount = player.commanderShip.shieldSlots
            if shieldSlotCount == 0 {
                inventoryKeyArray.append("<Your Ship Has No Shield Slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add shields
                var slotNumber = 1
                for item in player.commanderShip.shield {
                    inventoryKeyArray.append("Shield slot \(slotNumber)")
                    inventoryValueArray.append("\(item.name)")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 1, wType: nil, sType: item.type, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (shieldSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("Shield slot \(slotNumber)")
                    inventoryValueArray.append("<empty>")
                    inventoryDisclosureIndicator.append(false)
                    slotNumber += 1
                }
            }
            
            // populate available shields
            availableItems = []
            //shipItems = []
            for item in shieldsArray {
                // if available in this system
                let shield = Shield(type: item)
                let currentTechLevel = getTechLevelInt(galaxy.currentSystem!.techLevel)
                let itemTechLevel = getTechLevelInt(shield.techLevel)
                if (currentTechLevel + 1) >= itemTechLevel {
                    // add it to the array
                    let newUniversalGadget = UniversalGadget(typeIndex: 1, wType: nil, sType: item, gType: nil)
                    availableItems.append(newUniversalGadget)
                }
            }
            
            
        } else {
//            slotsLabel.text = "Gadget Slots on Your Ship:"
//            availableLabel.text = "Gadgets Available:"
            
            // populate current gadgets
            inventoryKeyArray = []
            inventoryValueArray = []
            inventoryDisclosureIndicator = []
            let gadgetSlotCount = player.commanderShip.gadgetSlots
            if gadgetSlotCount == 0 {
                inventoryKeyArray.append("<Your Ship Has No Gadget Slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add gadget
                var slotNumber = 1
                for item in player.commanderShip.gadget {
                    inventoryKeyArray.append("Gadget slot \(slotNumber)")
                    inventoryValueArray.append("\(item.name)")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 2, wType: nil, sType: nil, gType: item.type))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (gadgetSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("Gadget slot \(slotNumber)")
                    inventoryValueArray.append("<empty>")
                    inventoryDisclosureIndicator.append(false)
                    slotNumber += 1
                }
            }
            
            // populate available gadgets
            availableItems = []
            for item in gadgetsArray {
                // if available in this system
                let gadget = Gadget(type: item)
                let currentTechLevel = getTechLevelInt(galaxy.currentSystem!.techLevel)
                let itemTechLevel = getTechLevelInt(gadget.techLevel)
                if (currentTechLevel + 1) >= itemTechLevel {
                    // add it to the array
                    let newUniversalGadget = UniversalGadget(typeIndex: 2, wType: nil, sType: nil, gType: item)
                    availableItems.append(newUniversalGadget)
                }
            }
        }
        self.tableView.reloadData()
        
        
        // DEBUG ************************************************************************
        print("end refreshView()")
        print("shipItems:********************************************")
        for item in shipItems {
            print(item.name)
        }
        
        print("inventoryKeyArray:********************************************")
        for item in inventoryKeyArray {
            print(item)
        }
        
        print("inventoryValueArray:************************************************")
        for item in inventoryValueArray {
            print(item)
        }
    }
    
    
    // TABLE VIEW METHODS****************************************************************************
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EquipmentTableViewCell = tableView.dequeueReusableCellWithIdentifier("equipmentPrototypeCell") as! EquipmentTableViewCell
        
        if indexPath.section == 0 {
            // inventory
            if indexPath.row < inventoryKeyArray.count {
                cell.setLabels(inventoryKeyArray[indexPath.row], valueLabel: inventoryValueArray[indexPath.row])
                if inventoryDisclosureIndicator[indexPath.row] == true {
                    cell.accessoryType = .DisclosureIndicator
                } else {
                    cell.accessoryType = .None
                }
            }
        } else if indexPath.section == 1 {
            if availableItems.count == 0 {
                // set <no available items>
                cell.setLabels("<none available>", valueLabel: "")
                cell.accessoryType = .None
            } else {
                if indexPath.row < availableItems.count {
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "\(availableItems[indexPath.row].name)")
                    cell.accessoryType = .DisclosureIndicator
                }
            }
            
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch segmentedControl.selectedSegmentIndex {
                case 0:
                    return max(player.commanderShip.weaponSlots, 1)
                case 1:
                    return max(player.commanderShip.shieldSlots, 1)
                case 2:
                    return max(player.commanderShip.gadgetSlots, 1)
                default:
                    print("error")
            }
        } else if section == 1 {
            return availableItems.count
        }
        return 0
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print("selected \(indexPath.section), \(indexPath.row)")
//        
//        if indexPath.section == 0 {
//            // one of your crew
//            hireNotFire = false
//            selectedMercenary = player.commanderShip.crew[indexPath.row]
//            performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
//        } else {
//            // someone available for hire
//            hireNotFire = true
//            selectedMercenary = galaxy.currentSystem!.mercenaries[indexPath.row]
//            performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
//        }
//        
//        // deselection
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Current Inventory"
        } else if section == 1 {
            return "Equipment for Sale"
        } else {
            return "error"
        }
    }
    
    // sets properties in the destination vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "gadgetDetail") {
            let vc = (segue.destinationViewController as! EquipmentDetailVC)
            vc.chosenItem = chosenItem
            vc.buyNotSell = buyNotSell
        }
        
    }

}

class EquipmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}