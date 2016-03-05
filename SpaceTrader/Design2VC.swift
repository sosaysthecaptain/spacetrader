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
    
    // use variables
    var size: SizeType = SizeType.Medium        // set from player on viewDidLoad
    var maxUnits: Double = 50                           // set in viewDidLoad, based on size
    var unitsInUse: Double = 0                          // set in computeUnitsUsed
    var percentUsed: Double {
        return ((unitsInUse / maxUnits) * 100)
    }
    
    // cost variables
    var shipCost = 0
    var crowdingPenalty = 0
    var designFee = 0
    var lessTradeIn = 0
    var totalCost = 0
    
    
    // then function to set initial values based on chosen ship size
    // then plug steppers into variables, within max/min limits
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set ship size from player (storing it there from VC1 for lack of a better place)
        size = player.selectedConstructShipSize
        
        // set max units
        switch size {
            case SizeType.Tiny:
                maxUnits = 50
            case SizeType.Small:
                maxUnits = 100
            case SizeType.Medium:
                maxUnits = 150
            case SizeType.Large:
                maxUnits = 200
            case SizeType.Huge:
                maxUnits = 250
        }
        
        // set defaults, load display
        self.setMaxMinDefault()
        self.updateDisplay()
    }
    
    func updateDisplay() {
        // compute new values
        computeUnitsUsed()
        computePrices()
        
        // set value fields
        cargoBaysField.text = "\(Int(cargoBaysStepper.value))"
        rangeField.text = "\(Int(rangeStepper.value))"
        hullStrengthField.text = "\(Int(hullStrengthStepper.value))"
        weaponSlotsField.text = "\(Int(weaponSlotsStepper.value))"
        shieldSlotsField.text = "\(Int(shieldSlotsStepper.value))"
        gadgetSlotsField.text = "\(Int(gadgetSlotsStepper.value))"
        crewQuartersField.text = "\(Int(crewQuartersStepper.value))"
        
        // set units in use labels
        unitsUsedLabel.text = "\(Int(unitsInUse))/\(Int(maxUnits))"
        percentMaxLabel.text = "\(Int(percentUsed))%"
        
        // set price labels, formatted
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        let shipCostFormatted = numberFormatter.stringFromNumber(shipCost)
        let crowdingPenaltyFormatted = numberFormatter.stringFromNumber(crowdingPenalty)
        let designFeeFormatted = numberFormatter.stringFromNumber(designFee)
        let lessTradeInFormatted = numberFormatter.stringFromNumber(lessTradeIn)
        let totalCostFormatted = numberFormatter.stringFromNumber(totalCost)
        
        shipCostLabel.text = "\(shipCostFormatted!) cr."
        crowdingPenaltyLabel.text = "\(crowdingPenaltyFormatted!) cr."
        designFeeLabel.text = "\(designFeeFormatted!) cr."
        lessTradeInLabel.text = "\(lessTradeInFormatted!) cr."
        totalCostLabel.text = "\(totalCostFormatted!) cr."
        
        // disable "Construct Ship" if over 100% units used
        if unitsInUse > maxUnits {
            constructShipOutlet.enabled = false
        } else {
            constructShipOutlet.enabled = true
        }
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
    
    func computeUnitsUsed() {
        // this function is called from updateDisplay(), and sums up units currently in use
        
        // add up values times their cost in units
        unitsInUse = 0
        
        unitsInUse += cargoBaysStepper.value
        unitsInUse += rangeStepper.value
        unitsInUse += hullStrengthStepper.value / 10
        unitsInUse += weaponSlotsStepper.value * 13
        unitsInUse += shieldSlotsStepper.value * 10
        unitsInUse += gadgetSlotsStepper.value * 5
        unitsInUse += crewQuartersStepper.value * 20
    }
    
    func computePrices() {
        // this function is called from updateDisplay(), and sets price based on unitsInUse and size
        
        // reset all cost vars to 0
        shipCost = 0
        crowdingPenalty = 0
        designFee = 0
        lessTradeIn = 0
        totalCost = 0
        
        // shipCost is just 550 * units
        shipCost = Int(unitsInUse) * 550
        
        // crowdingPenalty goes in tiers, and is a flat fee per unit, for all units
        if Int(percentUsed) > 80 {
            crowdingPenalty = 25 * Int(unitsInUse)
        } else if Int(percentUsed) > 90 {
            crowdingPenalty = 75 * Int(unitsInUse)
        }
        
        // designFee is based on ship size
        switch size {
            case SizeType.Tiny:
                designFee = 1800
            case SizeType.Small:
                designFee = 5000
            case SizeType.Medium:
                designFee = 11000
            case SizeType.Large:
                designFee = 22000
            case SizeType.Huge:
                designFee = 39000
        }
        
        // lessTradeIn is the value of the player's ship, negative
        lessTradeIn = -1 * player.commanderShip.value
        
        // totalCost is the sum of these things
        totalCost = shipCost + crowdingPenalty + designFee + lessTradeIn
    }
    
    @IBAction func cancelDesignAction(sender: AnyObject) {
        // LEAVING THIS FUNCTIONALITY OUT FOR NOW
        
        // reset values (probably not necessary)
//        player.selectedConstructShipSize = SizeType.Medium
//        cargoBaysStepper.value = cargoBaysStepper.minimumValue
//        rangeStepper.value = rangeStepper.minimumValue
//        hullStrengthStepper.value = hullStrengthStepper.minimumValue
//        weaponSlotsStepper.value = weaponSlotsStepper.minimumValue
//        shieldSlotsStepper.value = shieldSlotsStepper.minimumValue
//        gadgetSlotsStepper.value = gadgetSlotsStepper.minimumValue
        
        // close window, return to shipyard
    }
    
    // CONSTRUCT SHIP FUNCTIONS
    
    // called on button press. Asks player if he wants to transfer escape pod
    @IBAction func constructShipAction(sender: AnyObject) {
        // ask about escape pod
        let title = "Transfer Escape Pod"
        let message = "I'll transfer your escape pod to your new ship for 200 credits."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Do It!", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // call build ship, with escape pod
            self.constructShipAreYouSure(true)
        }))
        alertController.addAction(UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.Cancel ,handler: {
            (alert: UIAlertAction!) -> Void in
            // call build ship with no escape pod
            self.constructShipAreYouSure(false)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // verifies player wants to proceed. Either tells him he can't afford it, he has too many crew, or calls constructShip()
    func constructShipAreYouSure(escapePod: Bool) {
        if player.credits < totalCost {
            // tell player he doesn't have enough money
            let title = "Not Enough Money"
            let message = "You don't have enough money to buy this ship."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if player.commanderShip.crew.count < (Int(crewQuartersStepper.value) + 1) {
            // if not enough crew slots, refuse transaction
            let title = "Too Many Crewmembers"
            let message = "The new ship you picked doesn't have enough quarters for all of your crewmembers. First you will have to fire one or more of them."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // ask if he's sure and proceed
            let title = "Buy New Ship"
            let message = "Are you sure you want to trade in your \(player.commanderShip.name) for a new \(player.selectedConstructShipName), and transfer your unique equipment to the new ship?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // call constructShip
                self.constructShip(escapePod)
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    // actually constructs ship
    func constructShip(transferEscapePod: Bool) {
        // charge money
        player.credits -= totalCost
        
        // create new ship
        let newShip = SpaceShip(type: ShipType.Custom, IFFStatus: IFFStatusType.Player)
        
        // enter selected values into new ship
        newShip.name = player.selectedConstructShipName
        newShip.cargoBays = Int(cargoBaysStepper.value)
        newShip.fuelTanks = Int(rangeStepper.value)
        newShip.hullStrength = Int(hullStrengthStepper.value)
        newShip.weaponSlots = Int(weaponSlotsStepper.value)
        newShip.shieldSlots = Int(shieldSlotsStepper.value)
        newShip.gadgetSlots = Int(gadgetSlotsStepper.value)
        newShip.crewQuarters = Int(crewQuartersStepper.value)
        
        // set image, once there is a way to do this
        
        // transfer unique items
        if player.commanderShip.getMorgansLaserStatus() {
            newShip.weapon.append(Weapon(type: WeaponType.morgansLaser))
        }
        if player.commanderShip.getFuelCompactorStatus() {
            newShip.gadget.append(Gadget(type: GadgetType.FuelCompactor))
        }
        if player.commanderShip.getLightningShieldStatus() {
            newShip.shield.append(Shield(type: ShieldType.lightningShield))
        }
        
        // transfer crew. Have already checked that there's room.
        for crewMember in player.commanderShip.crew {
            if newShip.crewQuarters >= player.commanderShip.crew.count {
                newShip.crew.append(crewMember)
            }
        }
        
        // handle escape pod situation
        if transferEscapePod {
            player.credits -= 200
            player.escapePod = true
        } else {
            player.escapePod = false
        }
        
        // replace player ship with new one
        player.commanderShip = newShip
        
        // finally, launch thank you alert
        let shipyardName = galaxy.currentSystem!.shipyard.rawValue
        
        let title = "Thank You!"
        let message = "\(shipyardName) thanks you for your business!"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // done. Close window, returning to shipyard. Use unwind segue
            //self.performSegueWithIdentifier("unwind", sender: nil)
            // TODO: there must be a better way to do this?
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
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
