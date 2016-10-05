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
        self.edgesForExtendedLayout = UIRectEdge()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DataViewTableCell = tableView.dequeueReusableCell(withIdentifier: "dataViewCell") as! DataViewTableCell
        
        // since this is infomational only, none of these should be selectable
        cell.isUserInteractionEnabled = false
        
        if (indexPath as NSIndexPath).section == 0 {
            // ship info
            if (indexPath as NSIndexPath).row == 0 {
                cell.setLabels("Name", valueLabel: "\(player.commanderShip.name)")
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.setLabels("Size", valueLabel: "\(player.commanderShip.size)")
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.setLabels("Cargo Bays", valueLabel: "\(player.commanderShip.cargoBays)")
            } else if (indexPath as NSIndexPath).row == 3 {
                cell.setLabels("Range", valueLabel: "\(player.commanderShip.fuelTanks) parsecs")
            } else if (indexPath as NSIndexPath).row == 4 {
                cell.setLabels("Hull Strength", valueLabel: "\(player.commanderShip.hullStrength)")
            } else if (indexPath as NSIndexPath).row == 5 {
                cell.setLabels("Weapon Slots", valueLabel: "\(player.commanderShip.weaponSlots)")
            } else if (indexPath as NSIndexPath).row == 6 {
                cell.setLabels("Shield Slots", valueLabel: "\(player.commanderShip.shieldSlots)")
            } else if (indexPath as NSIndexPath).row == 7 {
                cell.setLabels("Gadget Slots", valueLabel: "\(player.commanderShip.gadgetSlots)")
            } else if (indexPath as NSIndexPath).row == 8 {
                cell.setLabels("Crew Quarters", valueLabel: "\(player.commanderShip.crewSlotsFilled)/\(player.commanderShip.crewQuarters)")
            } else if (indexPath as NSIndexPath).row == 9 {
                // format...
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let valueFormatted = numberFormatter.string(from: NSNumber(value: player.commanderShip.value))!
                
                // set
                cell.setLabels("Total Value", valueLabel: "\(valueFormatted) cr.")
            } else {
                print("error")
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if (indexPath as NSIndexPath).section == 1 {
            // WEAPONS
            if numberOfWeaponSlots == 0 {
                cell.setLabels("<No Weapon Slots>", valueLabel: "")
            } else {
                if (indexPath as NSIndexPath).row < player.commanderShip.weapon.count {
                    // there is one
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "\(player.commanderShip.weapon[(indexPath as NSIndexPath).row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "<empty slot>")
                }
            }
        } else if (indexPath as NSIndexPath).section == 2 {
            // SHIELDS
            if numberOfShieldSlots == 0 {
                cell.setLabels("<No Shield Slots>", valueLabel: "")
            } else {
                if (indexPath as NSIndexPath).row < player.commanderShip.shield.count {
                    // there is one
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "\(player.commanderShip.shield[(indexPath as NSIndexPath).row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "<empty slot>")
                }
            }
            
            
            
        } else if (indexPath as NSIndexPath).section == 3 {
            // GADGETS
            if numberOfGadgetSlots == 0 {
                cell.setLabels("<No Gadget Slots>", valueLabel: "")
            } else {
                if (indexPath as NSIndexPath).row < player.commanderShip.gadget.count {
                    // there is one
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "\(player.commanderShip.gadget[(indexPath as NSIndexPath).row].name)")
                } else {
                    // empty slot
                    cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "<empty slot>")
                }
            }
        } else if (indexPath as NSIndexPath).section == 4 {
            if player.commanderShip.specialCargoStrings.count == 0 {
                cell.setLabels("<No Special Cargo>", valueLabel: "")
            } else {
                cell.setLabels("\(player.commanderShip.specialCargoStrings[(indexPath as NSIndexPath).row])", valueLabel: "")
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        } else if section == 4 {
            return player.commanderShip.specialCargoStrings.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected \((indexPath as NSIndexPath).section), \((indexPath as NSIndexPath).row)")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Ship"
        } else if section == 1 {
            return "Weapons"
        } else if section == 2 {
            return "Shields"
        } else if section == 3 {
            return "Gadgets"
        } else if section == 4 {
            return "Special Cargo"
        } else {
            return "error"
        }
    }
}

class DataViewTableCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(_ keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
