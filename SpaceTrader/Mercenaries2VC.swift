//
//  Mercenaries2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/25/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class Mercenaries2VC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // variables to reference
    let fillableSlotsOnYourShip = player.commanderShip.crewQuarters - 1
    
    var selectedMercenary: CrewMember?
    var hireNotFire: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None

    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.tableView.reloadData()
    }


    @IBAction func donePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PersonnelTableViewCell = tableView.dequeueReusableCellWithIdentifier("personnelPrototypeCell") as! PersonnelTableViewCell

        if indexPath.section == 0 {
            // your crew
            if fillableSlotsOnYourShip == 0 {
                if indexPath.row == 0 {
                    cell.setLabels("<no available crew quarters>", valueLabel: "")
                }
            } else {
                if indexPath.row < fillableSlotsOnYourShip {
                    // there is a slot, something will be written
                    if indexPath.row < player.commanderShip.crew.count {
                        // there is a crewmember in this slot. Display
                        cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "\(player.commanderShip.crew[indexPath.row].name)")
                        // set disclosure indicator
                        cell.accessoryType = .DisclosureIndicator
                    } else {
                        // empty slot
                        cell.setLabels("Slot \(indexPath.row + 1)", valueLabel: "<empty slot>")
                        cell.accessoryType = .None          // necessary in case you fire someone and this reloads
                    }
                }
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if indexPath.section == 1 {
            // see if any mercenaries are available to be hired here
            if galaxy.currentSystem!.mercenaries.count == 0 {
                if indexPath.row == 0 {
                    cell.setLabels("<no available mercenaries at this system>", valueLabel: "")
                }
            } else {
                if indexPath.row < galaxy.currentSystem!.mercenaries.count {
                    cell.setLabels("\(galaxy.currentSystem!.mercenaries[indexPath.row].name)", valueLabel: "")
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
            return fillableSlotsOnYourShip
        } else if section == 1 {
            if galaxy.currentSystem!.mercenaries.count > 0 {
                return galaxy.currentSystem!.mercenaries.count
            } else {
                return 1
            }
        } else {
            return 0
        }
            
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        print("selected \(indexPath.section), \(indexPath.row)")
        
        if indexPath.section == 0 {
            // one of your crew
            hireNotFire = false
            selectedMercenary = player.commanderShip.crew[indexPath.row]
            performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
        } else {
            // someone available for hire
            hireNotFire = true
            selectedMercenary = galaxy.currentSystem!.mercenaries[indexPath.row]
            performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
        }
        
        // deselection
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Crew"
        } else if section == 1 {
            return "Mercenaries Available for Hire"
        } else {
            return "error"
        }
    }
    
    // sets properties in the destination vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "mercenaryDetail") {
            let vc = (segue.destinationViewController as! MercenaryDetailVC)
            vc.selectedMercenary = selectedMercenary
            vc.hireNotFire = hireNotFire
        }
        
    }
    
    // unwind segue
    @IBAction func unwindAfterMercenaryDetail(segue:UIStoryboardSegue) {
        print("mercenaries reached by unwind segue!")
    }

    
}

class PersonnelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
