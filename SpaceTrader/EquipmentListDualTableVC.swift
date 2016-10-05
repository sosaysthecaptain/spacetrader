//
//  EquipmentListDualTableVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/1/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class EquipmentListDualTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectorIndex = 0
    
    let weaponsArray: [WeaponType] = [WeaponType.pulseLaser, WeaponType.beamLaser, WeaponType.militaryLaser, WeaponType.photonDisruptor]
    let shieldsArray: [ShieldType] = [ShieldType.energyShield, ShieldType.reflectiveShield]
    let gadgetsArray: [GadgetType] = [GadgetType.cargoBays, GadgetType.autoRepair, GadgetType.navigation, GadgetType.targeting, GadgetType.cloaking]
    
    var tableView1TextArray: [String] = []
    var tableView2TextArray: [String] = ["first available item", "second available item", "third available item"]
    var shipItems: [UniversalGadget] = []
    var availableItems: [UniversalGadget] = []
    var shipItemsCount = 0
    
    var chosenItem: UniversalGadget?
    var buyNotSell = true
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slotsLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "topCell") 
        self.tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "bottomCell")
        
        refreshView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshView()
        self.tableView1.reloadData()
        self.tableView2.reloadData()
    }
    
    @IBAction func SCIndexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("weapons selected")
            selectorIndex = 0
            refreshView()
        case 1:
            print("shields selected")
            selectorIndex = 1
            refreshView()
        case 2:
            print("gadgets selected")
            selectorIndex = 2
            refreshView()
        default:
            print("error")
        }
    }
    
    @IBAction func doneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    func refreshView() {
        if selectorIndex == 0 {
            slotsLabel.text = "Weapon Slots on Your Ship:"
            availableLabel.text = "Weapons Available:"
            
            // populate current weapons
            tableView1TextArray = []
            shipItems = []
            let weaponSlotCount = player.commanderShip.weaponSlots
            if weaponSlotCount == 0 {
                tableView1TextArray.append("<Your Ship Has No Weapon Slots>")
            } else {
                // add weapons
                var slotNumber = 1
                for item in player.commanderShip.weapon {
                    tableView1TextArray.append("Slot \(slotNumber): \(item.name)")
                    shipItems.append(UniversalGadget(typeIndex: 0, wType: item.type, sType: nil, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (weaponSlotCount + 1) > slotNumber {
                    tableView1TextArray.append("Slot \(slotNumber): <empty>")
                    slotNumber += 1
                }
            }
            self.tableView1.reloadData()
 
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
            self.tableView2.reloadData()
            
        } else if selectorIndex == 1 {
            slotsLabel.text = "Shield Slots on Your Ship:"
            availableLabel.text = "Shields Available:"
            
            // populate current shields
            tableView1TextArray = []
            shipItems = []
            let shieldSlotCount = player.commanderShip.shieldSlots
            if shieldSlotCount == 0 {
                tableView1TextArray.append("<Your Ship Has No Shield Slots>")
            } else {
                // add shields
                var slotNumber = 1
                for item in player.commanderShip.shield {
                    tableView1TextArray.append("Slot \(slotNumber): \(item.name)")
                    shipItems.append(UniversalGadget(typeIndex: 1, wType: nil, sType: item.type, gType: nil))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (shieldSlotCount + 1) > slotNumber {
                    tableView1TextArray.append("Slot \(slotNumber): <empty>")
                    slotNumber += 1
                }
            }
            
            self.tableView1.reloadData()
            
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
            self.tableView2.reloadData()
            

        } else {
            slotsLabel.text = "Gadget Slots on Your Ship:"
            availableLabel.text = "Gadgets Available:"
            
            // populate current gadgets
            tableView1TextArray = []
            let gadgetSlotCount = player.commanderShip.gadgetSlots
            if gadgetSlotCount == 0 {
                tableView1TextArray.append("<Your Ship Has No Gadget Slots>")
            } else {
                // add gadget
                var slotNumber = 1
                for item in player.commanderShip.gadget {
                    tableView1TextArray.append("Slot \(slotNumber): \(item.name)")
                    shipItems.append(UniversalGadget(typeIndex: 2, wType: nil, sType: nil, gType: item.type))
                    slotNumber += 1
                }
                shipItemsCount = shipItems.count
                // add empty slots
                while (gadgetSlotCount + 1) > slotNumber {
                    tableView1TextArray.append("Slot \(slotNumber): <empty>")
                    slotNumber += 1
                }
            }
            self.tableView1.reloadData()
            
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
            self.tableView2.reloadData()
        }

    }
    
    
    // TABLE VIEW METHODS************************************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return tableView1TextArray.count
        } else {
            return availableItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableView1 {
            let cell: UITableViewCell = self.tableView1.dequeueReusableCell(withIdentifier: "topCell")!
            cell.textLabel?.text = self.tableView1TextArray[(indexPath as NSIndexPath).row]
            return cell
        } else {
            let cell: UITableViewCell = self.tableView2.dequeueReusableCell(withIdentifier: "bottomCell")!
            cell.textLabel?.text = self.availableItems[(indexPath as NSIndexPath).row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView1 {
            //print("indexPath.row: \(indexPath.row), shipItems.count: \(shipItems.count)")
            for item in shipItems {
                print("\(item.name)")
            }
            
            if (indexPath as NSIndexPath).row <= (shipItems.count - 1) {
                chosenItem = shipItems[(indexPath as NSIndexPath).row]
                buyNotSell = false
                performSegue(withIdentifier: "gadgetDetail", sender: chosenItem)
            }
        } else {
            chosenItem = availableItems[(indexPath as NSIndexPath).row]
            buyNotSell = true
            performSegue(withIdentifier: "gadgetDetail", sender: chosenItem)
        }
    }
    
    // SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "gadgetDetail") {
            let vc = (segue.destination as! EquipmentDetailVC)
            vc.chosenItem = chosenItem
            vc.buyNotSell = buyNotSell
        }
        
    }
    
}
