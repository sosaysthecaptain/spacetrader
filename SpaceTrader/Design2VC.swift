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
    
    var size: SizeType = SizeType.Medium        // set from player on viewDidLoad
    
    // then function to set initial values based on chosen ship size
    // then plug steppers into variables, within max/min limits
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        size = player.selectedConstructShipSize
        self.setMaxMinDefault()
        self.updateDisplay()
    }
    
    func updateDisplay() {
        cargoBaysField.text = "\(Int(cargoBaysStepper.value))"
        rangeField.text = "\(Int(rangeStepper.value))"
        hullStrengthField.text = "\(Int(hullStrengthStepper.value))"
        weaponSlotsField.text = "\(Int(weaponSlotsStepper.value))"
        shieldSlotsField.text = "\(Int(shieldSlotsStepper.value))"
        gadgetSlotsField.text = "\(Int(gadgetSlotsStepper.value))"
        crewQuartersField.text = "\(Int(crewQuartersStepper.value))"
    }
    
    func setMaxMinDefault() {
        // set default mins and maxes
        cargoBaysStepper.minimumValue = 5
        cargoBaysStepper.maximumValue = 200
        
        rangeStepper.minimumValue = 5
        rangeStepper.maximumValue = 20
        
        hullStrengthStepper.minimumValue = 10
        hullStrengthStepper.maximumValue = 1000
        hullStrengthStepper.stepValue = 10
        
        weaponSlotsStepper.minimumValue = 0
        weaponSlotsStepper.maximumValue = 5
        
        shieldSlotsStepper.minimumValue = 0
        shieldSlotsStepper.maximumValue = 5
        
        gadgetSlotsStepper.minimumValue = 0
        gadgetSlotsStepper.maximumValue = 5
        
        crewQuartersStepper.minimumValue = 1
        crewQuartersStepper.maximumValue = 5
        
        // set mins that vary and all defaults
        switch size {
            case SizeType.Tiny:
                rangeStepper.minimumValue = 5
                hullStrengthStepper.minimumValue = 10
                
                cargoBaysStepper.value = 5
                rangeStepper.value = 12
                hullStrengthStepper.value = 50
                weaponSlotsStepper.value = 0
                shieldSlotsStepper.value = 0
                gadgetSlotsStepper.value = 0
                crewQuartersStepper.value = 1
            case SizeType.Small:
                rangeStepper.minimumValue = 5
                hullStrengthStepper.minimumValue = 25
            
                cargoBaysStepper.value = 15
                rangeStepper.value = 14
                hullStrengthStepper.value = 100
                weaponSlotsStepper.value = 1
                shieldSlotsStepper.value = 1
                gadgetSlotsStepper.value = 1
                crewQuartersStepper.value = 1
            case SizeType.Medium:
                rangeStepper.minimumValue = 5
                hullStrengthStepper.minimumValue = 50
            
                cargoBaysStepper.value = 25
                rangeStepper.value = 14
                hullStrengthStepper.value = 150
                weaponSlotsStepper.value = 2
                shieldSlotsStepper.value = 1
                gadgetSlotsStepper.value = 1
                crewQuartersStepper.value = 2
            case SizeType.Large:
                rangeStepper.minimumValue = 15
                hullStrengthStepper.minimumValue = 100
            
                cargoBaysStepper.value = 35
                rangeStepper.value = 14
                hullStrengthStepper.value = 200
                weaponSlotsStepper.value = 2
                shieldSlotsStepper.value = 2
                gadgetSlotsStepper.value = 2
                crewQuartersStepper.value = 3
            case SizeType.Huge:
                rangeStepper.minimumValue = 14
                hullStrengthStepper.minimumValue = 150
            
                cargoBaysStepper.value = 50
                rangeStepper.value = 14
                hullStrengthStepper.value = 250
                weaponSlotsStepper.value = 3
                shieldSlotsStepper.value = 2
                gadgetSlotsStepper.value = 2
                crewQuartersStepper.value = 3
        }
        
    }
    
    @IBAction func cancelDesignAction(sender: AnyObject) {
    }
    
    @IBAction func constructShipAction(sender: AnyObject) {
    }
    
    // stepper set functions--not at all interesting
    @IBAction func cargoBaysStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func rangeBaysStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func hullStrengthStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func weaponSlotStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func shieldSlotsStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func gadgetsSlotStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
    @IBAction func crewQuartersStepperSet(sender: AnyObject) {
        updateDisplay()
    }
    
}
