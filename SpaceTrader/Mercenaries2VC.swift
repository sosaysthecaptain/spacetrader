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
        self.edgesForExtendedLayout = UIRectEdge()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }


    @IBAction func donePressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonnelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "personnelPrototypeCell") as! PersonnelTableViewCell

        if (indexPath as NSIndexPath).section == 0 {
            // your crew
            if fillableSlotsOnYourShip == 0 {
                if (indexPath as NSIndexPath).row == 0 {
                    cell.setLabels("<no available crew quarters>", valueLabel: "")
                }
            } else {
                if (indexPath as NSIndexPath).row < fillableSlotsOnYourShip {
                    // there is a slot, something will be written
                    if (indexPath as NSIndexPath).row < player.commanderShip.crew.count {
                        // there is a crewmember in this slot. Display
                        cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "\(player.commanderShip.crew[(indexPath as NSIndexPath).row].name)")
                        // set disclosure indicator
                        cell.accessoryType = .disclosureIndicator
                        cell.isUserInteractionEnabled = true
                    } else {
                        // empty slot
                        cell.setLabels("Slot \((indexPath as NSIndexPath).row + 1)", valueLabel: "<empty slot>")
                        cell.accessoryType = .none          // necessary in case you fire someone and this reloads
                        cell.isUserInteractionEnabled = false
                    }
                }
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if (indexPath as NSIndexPath).section == 1 {
            // see if any mercenaries are available to be hired here
            if galaxy.currentSystem!.mercenaries.count == 0 {
                if (indexPath as NSIndexPath).row == 0 {
                    cell.setLabels("<none>", valueLabel: "")
                    cell.isUserInteractionEnabled = false
                }
            } else {
                if (indexPath as NSIndexPath).row < galaxy.currentSystem!.mercenaries.count {
                    cell.setLabels("\(galaxy.currentSystem!.mercenaries[(indexPath as NSIndexPath).row].name)", valueLabel: "")
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
            return max(fillableSlotsOnYourShip, 1)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selected \((indexPath as NSIndexPath).section), \((indexPath as NSIndexPath).row)")
        
        if (indexPath as NSIndexPath).section == 0 {
            // one of your crew
            
            // verify that this isn't an empty slot
            if (indexPath as NSIndexPath).row < player.commanderShip.crew.count {
                hireNotFire = false
                selectedMercenary = player.commanderShip.crew[(indexPath as NSIndexPath).row]
                performSegue(withIdentifier: "mercenaryDetail", sender: selectedMercenary)
            }
            
        } else {
            // someone available for hire
            
            // verify not empty slot
            if (indexPath as NSIndexPath).row < galaxy.currentSystem!.mercenaries.count {
                hireNotFire = true
                selectedMercenary = galaxy.currentSystem!.mercenaries[(indexPath as NSIndexPath).row]
                performSegue(withIdentifier: "mercenaryDetail", sender: selectedMercenary)
            }
        }
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Crew"
        } else if section == 1 {
            return "Mercenaries Available for Hire"
        } else {
            return "error"
        }
    }
    
    // sets properties in the destination vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "mercenaryDetail") {
            let vc = (segue.destination as! MercenaryDetailVC)
            vc.selectedMercenary = selectedMercenary
            vc.hireNotFire = hireNotFire
        }
        
        // set back button text for child VCs to "Back"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
    }
    
    // unwind segue
    @IBAction func unwindAfterMercenaryDetail(_ segue:UIStoryboardSegue) {
        print("mercenaries reached by unwind segue!")
    }

    
}

class PersonnelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(_ keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
