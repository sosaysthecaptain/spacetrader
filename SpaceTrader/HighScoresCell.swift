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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(commander: String, days: Int, score: Int, netWorth: Int) {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let daysFormatted = numberFormatter.stringFromNumber(days)
        let netWorthFormatted = numberFormatter.stringFromNumber(netWorth)
        let scoreFormatted = numberFormatter.stringFromNumber(score)
        
        nameLabel.text = commander
        scoreLabel.text = "Score: \(scoreFormatted!)"
        daysLabel.text = "Days: \(daysFormatted!)"
        netWorthLabel.text = "Net Worth: \(netWorthFormatted!) cr."
        
        
    }

}
