//
//  BuyShipCell.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/24/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class BuyShipCell: UITableViewCell {


    @IBOutlet weak var shipName: UILabel!
    @IBOutlet weak var priceField: UILabel!
    @IBOutlet weak var shipImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ ship: ShipType) {
        let shipPrototype = SpaceShip(type: ship, IFFStatus: IFFStatusType.Player)
        
        // set name
        shipName.text = shipPrototype.name
        
        // set image
        switch ship {
            case ShipType.flea:
                shipImage.image = UIImage(named: "ship0")
            case ShipType.gnat:
                shipImage.image = UIImage(named: "ship1")
            case ShipType.firefly:
                shipImage.image = UIImage(named: "ship2")
            case ShipType.mosquito:
                shipImage.image = UIImage(named: "ship3")
            case ShipType.bumblebee:
                shipImage.image = UIImage(named: "ship4")
            case ShipType.beetle:
                shipImage.image = UIImage(named: "ship5")
            case ShipType.hornet:
                shipImage.image = UIImage(named: "ship6")
            case ShipType.grasshopper:
                shipImage.image = UIImage(named: "ship7")
            case ShipType.termite:
                shipImage.image = UIImage(named: "ship8")
            case ShipType.wasp:
                shipImage.image = UIImage(named: "ship9")
            default:
                print("error")
        }
        
        // set price
        let currentSystemTechLevel = galaxy.currentSystem!.techLevelInt
        let shipTechLevelInt = getTechLevelInt(shipPrototype.minTechLevel)
        
        if currentSystemTechLevel >= shipTechLevelInt {
            // set price
            var price = shipPrototype.price
            price -= player.commanderShip.value
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let priceFormatted = numberFormatter.string(from: NSNumber(value: price))!
            priceField.text = "\(priceFormatted) cr."
        } else {
            priceField.text = "not sold"
            priceField.textColor = inactiveGray
        }
        
        if player.commanderShip.type == ship {
            priceField.text = "got one"
        }
        
        // enabling/disabling will be done separately in ShipDetailVC
    }

}
