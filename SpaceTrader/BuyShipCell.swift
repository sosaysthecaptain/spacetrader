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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(ship: ShipType) {
        let shipPrototype = SpaceShip(type: ship, IFFStatus: IFFStatusType.Player)
        
        // set name
        shipName.text = shipPrototype.name
        
        // set image
        switch ship {
            case ShipType.Flea:
                shipImage.image = UIImage(named: "ship0")
            case ShipType.Gnat:
                shipImage.image = UIImage(named: "ship1")
            case ShipType.Firefly:
                shipImage.image = UIImage(named: "ship2")
            case ShipType.Mosquito:
                shipImage.image = UIImage(named: "ship3")
            case ShipType.Bumblebee:
                shipImage.image = UIImage(named: "ship4")
            case ShipType.Beetle:
                shipImage.image = UIImage(named: "ship5")
            case ShipType.Hornet:
                shipImage.image = UIImage(named: "ship6")
            case ShipType.Grasshopper:
                shipImage.image = UIImage(named: "ship7")
            case ShipType.Termite:
                shipImage.image = UIImage(named: "ship8")
            case ShipType.Wasp:
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
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            let priceFormatted = numberFormatter.stringFromNumber(price)
            priceField.text = "\(priceFormatted!) credits"
        } else {
            priceField.text = "not sold"
        }
        
        if player.commanderShip.type == ship {
            priceField.text = "got one"
        }
        
        // enabling/disabling will be done separately in ShipDetailVC
    }

}
