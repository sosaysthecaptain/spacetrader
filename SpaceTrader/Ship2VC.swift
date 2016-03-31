//
//  Ship2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/24/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class Ship2VC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // storage for basic info
    var numberOfWeaponSlots = player.commanderShip.weaponSlots
    var numberOfShieldSlots = player.commanderShip.shieldSlots
    var numberOfGadgetSlots = player.commanderShip.gadgetSlots
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DataViewTableCell = tableView.dequeueReusableCellWithIdentifier("dataViewCell") as! DataViewTableCell
        
        // since this is infomational only, none of these should be selectable
        cell.userInteractionEnabled = false
        
        if indexPath.section == 0 {
            // ship info
            if indexPath.row == 0 {
                cell.setLabels("Name", valueLabel: "\(player.commanderShip.name)")
            } else if indexPath.row == 1 {
                cell.setLabels("Size", valueLabel: "\(player.commanderShip.size)")
            } else if indexPath.row == 2 {
                cell.setLabels("Cargo Bays", valueLabel: "\(player.commanderShip.cargoBays)")
            } else if indexPath.row == 3 {
                cell.setLabels("Range", valueLabel: "\(player.commanderShip.fuelTanks) parsecs")
            } else if indexPath.row == 4 {
                cell.setLabels("Hull Strength", valueLabel: "\(player.commanderShip.hullStrength)")
            } else if indexPath.row == 5 {
                cell.setLabels("Weapon Slots", valueLabel: "\(player.commanderShip.weaponSlots)")
            } else if indexPath.row == 6 {
                cell.setLabels("Shield Slots", valueLabel: "\(player.commanderShip.shieldSlots)")
            } else if indexPath.row == 7 {
                cell.setLabels("Gadget Slots", valueLabel: "\(player.commanderShip.gadgetSlots)")
            } else if indexPath.row == 8 {
                cell.setLabels("Crew Quarters", valueLabel: "\(player.commanderShip.crewSlotsFilled)/\(player.commanderShip.crewQuarters)")
            } else if indexPath.row == 9 {
                // format...
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                let valueFormatted = numberFormatter.stringFromNumber(player.commanderShip.value)
                
                // set
                cell.setLabels("Total Value", valueLabel: "\(valueFormatted!) cr.")
            } else {
                print("error")
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if indexPath.section == 1 {
            // WEAPONS
            if numberOfWeaponSlots == 0 {
                cell.setLabels("<No Weapon Slots>", valueLabel: "")
            } else {
                if indexPath.row < player.commanderShip.weapon.count {
                    // there is one
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "\(player.commanderShip.weapon[indexPath.row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "<empty slot>")
                }
            }
        } else if indexPath.section == 2 {
            // SHIELDS
            if numberOfShieldSlots == 0 {
                cell.setLabels("<No Shield Slots>", valueLabel: "")
            } else {
                if indexPath.row < player.commanderShip.shield.count {
                    // there is one
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "\(player.commanderShip.shield[indexPath.row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "<empty slot>")
                }
            }
            
            
            
        } else if indexPath.section == 3 {
            // GADGETS
            if numberOfGadgetSlots == 0 {
                cell.setLabels("<No Gadget Slots>", valueLabel: "")
            } else {
                if indexPath.row < player.commanderShip.gadget.count {
                    // there is one
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "\(player.commanderShip.gadget[indexPath.row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "<empty slot>")
                }
            }
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        } else if section == 1 {
            if numberOfWeaponSlots > 0 {
                return numberOfWeaponSlots
            } else {
                return 1
            }
        } else if section == 2 {
            if numberOfShieldSlots > 0 {
                return numberOfShieldSlots
            } else {
                return 1
            }
        } else if section == 3 {
            if numberOfWeaponSlots > 0 {
                return numberOfGadgetSlots
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("selected \(indexPath.section), \(indexPath.row)")
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Ship"
        } else if section == 1 {
            return "Weapons"
        } else if section == 2 {
            return "Shields"
        } else if section == 3 {
            return "Gadgets"
        } else {
            return "error"
        }
    }
}

class DataViewTableCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
