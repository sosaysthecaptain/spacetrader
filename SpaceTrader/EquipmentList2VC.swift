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
    @IBOutlet weak var grayPatchView: UIView!
    
    var selectorIndex = 0
    
    let weaponsArray: [WeaponType] = [WeaponType.pulseLaser, WeaponType.beamLaser, WeaponType.militaryLaser, WeaponType.photonDisruptor]
    let shieldsArray: [ShieldType] = [ShieldType.energyShield, ShieldType.reflectiveShield]
    let gadgetsArray: [GadgetType] = [GadgetType.cargoBays, GadgetType.autoRepair, GadgetType.navigation, GadgetType.targeting, GadgetType.cloaking]
    
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
        self.edgesForExtendedLayout = UIRectEdge()
        
        // send view to background. Not possible to do this in IB
        self.view.sendSubview(toBack: grayPatchView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshView()                  // needed for return from detail view
    }
    
    
    @IBAction func donePressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlChanged(_ sender: AnyObject) {
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
                inventoryKeyArray.append("<Your ship has no weapon slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add weapons
                var slotNumber = 1
                for item in player.commanderShip.weapon {
                    inventoryKeyArray.append("\(item.name)")
                    inventoryValueArray.append("")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 0, wType: item.type, sType: nil, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (weaponSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("<empty slot>")       // Previously "Weapon slot 1"
                    inventoryValueArray.append("")           // previously <item>
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
                inventoryKeyArray.append("<Your ship has no shield slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add shields
                var slotNumber = 1
                for item in player.commanderShip.shield {
                    inventoryKeyArray.append("\(item.name)")
                    inventoryValueArray.append("")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 1, wType: nil, sType: item.type, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (shieldSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("<empty>")
                    inventoryValueArray.append("")
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
                inventoryKeyArray.append("<Your ship has no gadget slots>")
                inventoryValueArray.append("")
                inventoryDisclosureIndicator.append(false)
            } else {
                // add gadget
                var slotNumber = 1
                for item in player.commanderShip.gadget {
                    inventoryKeyArray.append("\(item.name)")
                    inventoryValueArray.append("")
                    inventoryDisclosureIndicator.append(true)
                    shipItems.append(UniversalGadget(typeIndex: 2, wType: nil, sType: nil, gType: item.type))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (gadgetSlotCount + 1) > slotNumber {
                    inventoryKeyArray.append("<empty>")
                    inventoryValueArray.append("")
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
    }
    
    
    // TABLE VIEW METHODS****************************************************************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EquipmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "equipmentPrototypeCell") as! EquipmentTableViewCell
        
        if (indexPath as NSIndexPath).section == 0 {
            // inventory
            if (indexPath as NSIndexPath).row < inventoryKeyArray.count {
                cell.setLabels(inventoryKeyArray[(indexPath as NSIndexPath).row], valueLabel: inventoryValueArray[(indexPath as NSIndexPath).row])
                if inventoryDisclosureIndicator[(indexPath as NSIndexPath).row] == true {
                    cell.accessoryType = .disclosureIndicator
                    cell.isUserInteractionEnabled = true
                } else {
                    cell.accessoryType = .none
                    cell.isUserInteractionEnabled = false
                }
            }
        } else if (indexPath as NSIndexPath).section == 1 {
            // available items
            if availableItems.count == 0 {
                // set <no available items>
                cell.setLabels("<none available>", valueLabel: "")
                cell.accessoryType = .none
                cell.isUserInteractionEnabled = false
            } else {
                if (indexPath as NSIndexPath).row < availableItems.count {
                    cell.setLabels("\(availableItems[(indexPath as NSIndexPath).row].name)", valueLabel: "")
                    cell.accessoryType = .disclosureIndicator
                    cell.isUserInteractionEnabled = true
                }
            }
            
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            return max(availableItems.count, 1)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected \((indexPath as NSIndexPath).section), \((indexPath as NSIndexPath).row)")
        
        if (indexPath as NSIndexPath).section == 0 {
            // inventory item
            if (indexPath as NSIndexPath).row < (shipItems.count) {          // check that this isn't the cell saying "no item"
                chosenItem = shipItems[(indexPath as NSIndexPath).row]
                buyNotSell = false
                performSegue(withIdentifier: "gadgetDetail", sender: chosenItem)
            }
        } else {
            // user selected available item
            if (indexPath as NSIndexPath).row < (availableItems.count) {
                chosenItem = availableItems[(indexPath as NSIndexPath).row]
                buyNotSell = true
                performSegue(withIdentifier: "gadgetDetail", sender: chosenItem)
            }
        }
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Current Inventory"
        } else if section == 1 {
            return "Equipment for Sale"
        } else {
            return "error"
        }
    }
    
    // UTILITY************************************************************************************
    //func getImageForUniversalGadget(universalGadget: Universa)
    
    // sets properties in the destination vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // set text of back button
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        if(segue.identifier == "gadgetDetail") {
            let vc = (segue.destination as! EquipmentDetailVC)
            vc.chosenItem = chosenItem
            vc.buyNotSell = buyNotSell
        }
        
    }

}

class EquipmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(_ keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
