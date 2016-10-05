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
        self.edgesForExtendedLayout = UIRectEdge()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommanderStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataViewCell") as! CommanderStatusTableViewCell
        
        // since this is infomational only, none of these should be selectable
        cell.isUserInteractionEnabled = false
        
        if (indexPath as NSIndexPath).section == 0 {
            // basic info
            if (indexPath as NSIndexPath).row == 0 {
                cell.setLabels("Name", valueLabel: "\(player.commanderName)")
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.setLabels("Difficulty", valueLabel: "\(player.difficulty.rawValue)")
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.setLabels("Time", valueLabel: "\(player.days) days")
            } else {
                print("error")
            }
            //cell.accessoryType = .DisclosureIndicator
        } else if (indexPath as NSIndexPath).section == 1 {
            // skills
            if (indexPath as NSIndexPath).row == 0 {
                cell.setLabels("Pilot", valueLabel: "\(player.initialPilotSkill) (\(player.pilotSkill))")
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.setLabels("Fighter", valueLabel: "\(player.initialFighterSkill) (\(player.fighterSkill))")
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.setLabels("Trader", valueLabel: "\(player.initialTraderSkill) (\(player.traderSkill))")
            } else if (indexPath as NSIndexPath).row == 3 {
                cell.setLabels("Engineer", valueLabel: "\(player.initialEngineerSkill) (\(player.engineerSkill))")
            } else {
                print("error")
            }
            
        } else if (indexPath as NSIndexPath).section == 2 {
            // finances
            // formatting
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let cashFormatted = numberFormatter.string(from: NSNumber(value: player.credits))!
            let debtFormatted = numberFormatter.string(from: NSNumber(value: player.debt))!
            let creditLimitFormatted = numberFormatter.string(from: NSNumber(value: player.creditLimit))!
            let debtRatioFormatted = numberFormatter.string(from: NSNumber(value: player.debtRatio))!
            let netWorthFormatted = numberFormatter.string(from: NSNumber(value: player.netWorth))!
            
            // displaying
            
            
            if (indexPath as NSIndexPath).row == 0 {
                cell.setLabels("Cash", valueLabel: "\(cashFormatted) cr.")
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.setLabels("Debt", valueLabel: "\(debtFormatted) cr.")
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.setLabels("Credit Limit", valueLabel: "\(creditLimitFormatted) cr.")
            } else if (indexPath as NSIndexPath).row == 3 {
                cell.setLabels("Debt Ratio", valueLabel: "\(debtRatioFormatted)")
            } else if (indexPath as NSIndexPath).row == 4 {
                cell.setLabels("Net Worth", valueLabel: "\(netWorthFormatted) cr.")
            } else {
                print("error")
            }
            
            
            
        } else if (indexPath as NSIndexPath).section == 3 {
            // notoriety
            if (indexPath as NSIndexPath).row == 0 {
                cell.setLabels("Kills", valueLabel: "\(player.kills)")
            } else if (indexPath as NSIndexPath).row == 1 {
                cell.setLabels("Reputation", valueLabel: "\(getPoliceRecordForInt(player.policeRecord.rawValue))")
            } else if (indexPath as NSIndexPath).row == 2 {
                cell.setLabels("Police Record", valueLabel: "\(getReputationForInt(player.reputation.rawValue))")
            } else {
                print("error")
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func setLabels(_ keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
