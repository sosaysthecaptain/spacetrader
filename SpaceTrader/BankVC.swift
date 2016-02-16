//
//  BankVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/17/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class BankVC: UIViewController {

    @IBOutlet weak var currentDebtLabel: UILabel!
    @IBOutlet weak var maximumLoanLabel: UILabel!
    @IBOutlet weak var shipValueLabel: UILabel!
    @IBOutlet weak var noClaimDiscountLabel: UILabel!
    @IBOutlet weak var costsLabel: UILabel!
    
    @IBOutlet weak var getLoanLabel: CustomButton!
    @IBOutlet weak var payBackLoanLabel: CustomButton!
    @IBOutlet weak var buyInsuranceOutlet: CustomButton!
    
    
    var getVsPayBack = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    override func viewDidAppear(animated: Bool) {
        setData()
    }
    
    func setData() {
        // current debt
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let currentDebtFormatted = numberFormatter.stringFromNumber(player.debt)
        currentDebtLabel.text = "\(currentDebtFormatted!) cr."
        
        // maximum loan
        let maxLoan = getMaxLoan()
        let maxLoanFormatted = numberFormatter.stringFromNumber(maxLoan)
        maximumLoanLabel.text = "\(maxLoanFormatted!) cr."
        
        
        
        // disable pay back loan button if no debt
        if player.debt == 0 {
            payBackLoanLabel.enabled = false
        } else {
            payBackLoanLabel.enabled = true
        }
        
        // insurance numbers
        let shipValueFormatted = numberFormatter.stringFromNumber(player.commanderShip.value)
        shipValueLabel.text = "\(shipValueFormatted!) cr."
        
        let noClaimFormatted = numberFormatter.stringFromNumber(player.noClaim)
        noClaimDiscountLabel.text = "\(noClaimFormatted!)%"
        
        let insuranceCostFormatted = numberFormatter.stringFromNumber(player.insuranceCost)
        costsLabel.text = "\(insuranceCostFormatted!) cr. daily"
        
        // set buy/stop insurance
        if player.insurance {
            let controlState = UIControlState()
            buyInsuranceOutlet.setTitle("Stop Insurance", forState: controlState)
        } else {
            let controlState = UIControlState()
            buyInsuranceOutlet.setTitle("Buy Insurance", forState: controlState)
        }
    }
    
    func getMaxLoan() -> Int {
        var maxLoan = 0
        if player.policeRecordInt >= 5 {
            print("at least clean police record")
            maxLoan = max(1000, (player.netWorth / 10))
            maxLoan = min (25000, maxLoan)
            
            // round to 200
            if maxLoan > 1000 {
                maxLoan = maxLoan - (maxLoan % 200)
            }
            
            maxLoan -= player.debt
            if maxLoan < 0 {
                maxLoan = 0
            }
            
            return maxLoan
        } else {
            return 500
        }
    }

    @IBAction func getLoan(sender: AnyObject) {
        getVsPayBack = true
        performSegueWithIdentifier("bankQuantitySegue", sender: nil)
    }
    
    @IBAction func payBackLoan(sender: AnyObject) {
        getVsPayBack = false
        performSegueWithIdentifier("bankQuantitySegue", sender: nil)
    }

    @IBAction func buyInsurance(sender: AnyObject) {
        if player.insurance {
            // stop insurance
            print("SHOULD NOW LAUNCH ALERT")                // DEBUG
            let title = "Stop Insurance"
            let message = "Do you really want to stop your insurance and lose your no-claim?."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                player.insurance = false
                self.setData()
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // buy insurance
            if player.escapePod {
                // launch modal/alert/whatever to buy insurance
                player.insurance = true
                self.setData()
                
            } else {
                let title = "No Escape Pod"
                let message = "Insurance isn't useful to you, since you don't have an escape pod."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                }))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if(segue.identifier == "bankQuantitySegue") {
            // set up VC, add getVsPayBack to it as Bool?, maxLoan as Int?
            
            let vc = (segue.destinationViewController as! BankQuantityVC)
            vc.getVsPayBack = getVsPayBack
            vc.maxLoan = getMaxLoan()
            //print("maxLoan: \(vc.maxLoan)")
        }
        
    }
    
}
