//
//  LoadGameCellTableViewCell.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/16/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class LoadGameCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var netWorthLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(titleLabel: String, netWorth: Int, days: Int) {
        self.titleLabel.text = titleLabel
        
        // format and set net worth
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let netWorthFormatted = numberFormatter.stringFromNumber(netWorth)
        netWorthLabel.text = "Net Worth: \(netWorthFormatted!) credits"
        
        let daysFormatted = numberFormatter.stringFromNumber(days)
        daysLabel.text = "\(daysFormatted!) days"
        
    }

}
