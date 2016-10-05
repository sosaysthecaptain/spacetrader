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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ titleLabel: String, netWorth: Int, days: Int) {
        self.titleLabel.text = titleLabel
        
        // format and set net worth
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let netWorthFormatted = numberFormatter.string(from: NSNumber(value: netWorth))!
        netWorthLabel.text = "Net Worth: \(netWorthFormatted) credits"
        
        let daysFormatted = numberFormatter.string(from: NSNumber(value: days))!
        daysLabel.text = "\(daysFormatted) days"
        
    }

}
