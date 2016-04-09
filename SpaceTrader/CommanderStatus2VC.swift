//
//  CommanderStatus2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/25/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class CommanderStatus2VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CommanderStatusTableViewCell = tableView.dequeueReusableCellWithIdentifier("dataViewCell") as! CommanderStatusTableViewCell
        
        // since this is infomational only, none of these should be selectable
        cell.userInteractionEnabled = false
        
        if indexPath.section == 0 {
            // basic info
            if indexPath.row == 0 {
                cell.setLabels("Name", valueLabel: "\(player.commanderName)")
            } else if indexPath.row == 1 {
                cell.setLabels("Difficulty", valueLabel: "\(player.difficulty.rawValue)")
            } else if indexPath.row == 2 {
                cell.setLabels("Time", valueLabel: "\(player.days) days")
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
            
        } else if indexPath.section == 2 {
            // finances
            // formatting
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            let cashFormatted = numberFormatter.stringFromNumber(player.credits)
            let debtFormatted = numberFormatter.stringFromNumber(player.debt)
            let creditLimitFormatted = numberFormatter.stringFromNumber(player.creditLimit)
            let debtRatioFormatted = numberFormatter.stringFromNumber(player.debtRatio)
            let netWorthFormatted = numberFormatter.stringFromNumber(player.netWorth)
            
            // displaying
            
            
            if indexPath.row == 0 {
                cell.setLabels("Cash", valueLabel: "\(cashFormatted!) cr.")
            } else if indexPath.row == 1 {
                cell.setLabels("Debt", valueLabel: "\(debtFormatted!) cr.")
            } else if indexPath.row == 2 {
                cell.setLabels("Credit Limit", valueLabel: "\(creditLimitFormatted!) cr.")
            } else if indexPath.row == 3 {
                cell.setLabels("Debt Ratio", valueLabel: "\(debtRatioFormatted!)")
            } else if indexPath.row == 4 {
                cell.setLabels("Net Worth", valueLabel: "\(netWorthFormatted!) cr.")
            } else {
                print("error")
            }
            
            
            
        } else if indexPath.section == 3 {
            // notoriety
            if indexPath.row == 0 {
                cell.setLabels("Kills", valueLabel: "\(player.kills)")
            } else if indexPath.row == 1 {
                cell.setLabels("Reputation", valueLabel: "\(getPoliceRecordForInt(player.policeRecord.rawValue))")
            } else if indexPath.row == 2 {
                cell.setLabels("Police Record", valueLabel: "\(getReputationForInt(player.reputation.rawValue))")
            } else {
                print("error")
            }
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 5
        } else if section == 3 {
            return 3
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
            return "Basic Info"
        } else if section == 1 {
            return "Skills"
        } else if section == 2 {
            return "Finances"
        } else if section == 3 {
            return "Notoriety"
        } else {
            return "error"
        }
    }

}

class CommanderStatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
