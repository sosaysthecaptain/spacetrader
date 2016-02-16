//
//  CommanderStatusVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/8/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class CommanderStatusVC: UIViewController  {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var pilotLabel: UILabel!
    @IBOutlet weak var fighterLabel: UILabel!
    @IBOutlet weak var traderLabel: UILabel!
    @IBOutlet weak var engineerLabel: UILabel!
    
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var netWorthLabel: UILabel!
    
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var policeRecordLabel: UILabel!
    
    override func viewDidLoad() {
        loadData()
    }
    
    func loadData() {
        nameLabel.text = player.commanderName
        difficultyLabel.text = player.difficulty.rawValue
        timeLabel.text = "\(player.days) days"
        
        pilotLabel.text = "\(player.initialPilotSkill) (\(player.pilotSkill))"
        fighterLabel.text = "\(player.initialFighterSkill) (\(player.fighterSkill))"
        traderLabel.text = "\(player.initialTraderSkill) (\(player.traderSkill))"
        engineerLabel.text = "\(player.initialEngineerSkill) (\(player.engineerSkill))"
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let cashFormatted = numberFormatter.stringFromNumber(player.credits)
        let debtFormatted = numberFormatter.stringFromNumber(player.debt)
        let netWorthFormatted = numberFormatter.stringFromNumber(player.netWorth)
        
        cashLabel.text = "\(cashFormatted!) cr."
        debtLabel.text = "\(debtFormatted!) cr."
        netWorthLabel.text = "\(netWorthFormatted!) cr."
        
        killsLabel.text = "\(player.kills)"
        reputationLabel.text = "\(getPoliceRecordForInt(player.policeRecord.rawValue))"
        policeRecordLabel.text = "\(getReputationForInt(player.reputation.rawValue))"
    }

  }
