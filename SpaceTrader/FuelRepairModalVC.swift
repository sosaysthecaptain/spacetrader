//
//  FuelRepairModalVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

protocol FuelRepairModalDelegate: class {
    func modalDidFinish()
    func getFuelAsOpposedToRepair() -> Bool
}

class FuelRepairModalVC: UIViewController {
    weak var delegate: FuelRepairModalDelegate?
    
    var fuelAsOpposedToRepair = true
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var entryField: UITextField!

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        entryField.becomeFirstResponder()
        fuelAsOpposedToRepair = delegate!.getFuelAsOpposedToRepair()
        
        if !fuelAsOpposedToRepair {
            titleLabel.text = "Hull Repair"
            
            // put default value in entryField
        }
        
    }
    
    @IBAction func cancelButton() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func okButton() {
        
        if entryField.text != nil {
            let price = Int(entryField.text!)
            if fuelAsOpposedToRepair {
                let amountOfFuelToBuy: Int = price! / player.commanderShip.costOfFuel
                player.buyFuel(amountOfFuelToBuy)
                delegate?.modalDidFinish()
                self.dismiss(animated: false, completion: nil)
            } else {
                player.buyRepairs(price!)
                delegate?.modalDidFinish()
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    @IBAction func maxButton() {
        if fuelAsOpposedToRepair {
            player.buyMaxFuel()
            delegate?.modalDidFinish()
            self.dismiss(animated: false, completion: nil)
        } else {
            player.buyMaxRepairs()
            delegate?.modalDidFinish()
            self.dismiss(animated: false, completion: nil)
        }
        
        
    }
}
