//
//  Design2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/2/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class Design2VC: UIViewController {

    @IBOutlet weak var cargoBaysField: UITextField!
    @IBOutlet weak var rangeField: UITextField!
    @IBOutlet weak var hullStrengthField: UITextField!
    @IBOutlet weak var weaponSlotsField: UITextField!
    @IBOutlet weak var shieldSlotsField: UITextField!
    @IBOutlet weak var gadgetSlotsField: UITextField!
    @IBOutlet weak var crewQuartersField: UITextField!
    
    @IBOutlet weak var cargoBaysStepper: UIStepper!
    @IBOutlet weak var rangeStepper: UIStepper!
    @IBOutlet weak var hullStrengthStepper: UIStepper!
    @IBOutlet weak var weaponSlotsStepper: UIStepper!
    @IBOutlet weak var shieldSlotsStepper: UIStepper!
    @IBOutlet weak var gadgetSlotsStepper: UIStepper!
    @IBOutlet weak var crewQuartersStepper: UIStepper!
    
    @IBOutlet weak var unitsUsedLabel: UILabel!
    @IBOutlet weak var percentMaxLabel: UILabel!
    @IBOutlet weak var shipCostLabel: UILabel!
    @IBOutlet weak var crowdingPenaltyLabel: UILabel!
    @IBOutlet weak var designFeeLabel: UILabel!
    @IBOutlet weak var lessTradeInLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    @IBOutlet weak var cancelDesignOutlet: CustomButton!
    @IBOutlet weak var constructShipOutlet: CustomButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelDesignAction(sender: AnyObject) {
    }
    
    @IBAction func constructShipAction(sender: AnyObject) {
    }
    
    
    
}
