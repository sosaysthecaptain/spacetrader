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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None

    }


    @IBAction func donePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PersonnelTableViewCell = tableView.dequeueReusableCellWithIdentifier("personnelPrototypeCell") as! PersonnelTableViewCell

        if indexPath.section == 0 {
            // basic info
            if indexPath.row == 0 {
                cell.setLabels("Name", valueLabel: "\(player.commanderName)")
            } else if indexPath.row == 1 {
                cell.setLabels("Difficulty", valueLabel: "\(player.difficulty.rawValue)")
            } else if indexPath.row == 2 {
                cell.setLabels("Time", valueLabel: "\(player.days)")
            } else {
                print("error")
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if indexPath.section == 1 {
            // skills
            if indexPath.row == 0 {
                cell.setLabels("Pilot", valueLabel: "\(player.initialPilotSkill) (\(player.pilotSkill))")
            } else if indexPath.row == 1 {
                cell.setLabels("Fighter", valueLabel: "\(player.initialFighterSkill) (\(player.fighterSkill))")
            } else if indexPath.row == 2 {
                cell.setLabels("Trader", valueLabel: "\(player.initialTraderSkill) (\(player.traderSkill))")
            } else if indexPath.row == 3 {
                cell.setLabels("Engineer", valueLabel: "\(player.initialEngineerSkill) (\(player.engineerSkill))")
            } else {
                print("error")
            }

        }

        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 4
        } else {
            return 0
        }
            
    }
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        print("selected \(indexPath.section), \(indexPath.row)")
    //    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Crew"
        } else if section == 1 {
            return "Mercenaries Available for Hire"
        } else {
            return "error"
        }
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
