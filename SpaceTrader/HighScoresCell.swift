//
//  HighScoresCell.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class HighScoresCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var netWorthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ commander: String, days: Int, score: Int, netWorth: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let daysFormatted = numberFormatter.string(from: NSNumber(value: days))!
        let netWorthFormatted = numberFormatter.string(from: NSNumber(value: netWorth))!
        let scoreFormatted = numberFormatter.string(from: NSNumber(value: score))!
        
        nameLabel.text = commander
        scoreLabel.text = "Score: \(scoreFormatted)"
        daysLabel.text = "Days: \(daysFormatted)"
        netWorthLabel.text = "Net Worth: \(netWorthFormatted) cr."
        
        
    }

}
