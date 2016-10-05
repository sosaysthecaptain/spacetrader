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
    
    @IBOutlet weak var getLoanLabel: PurpleButtonTurnsGray!
    @IBOutlet weak var payBackLoanLabel: PurpleButtonTurnsGray!
    @IBOutlet weak var buyInsuranceOutlet: PurpleButtonTurnsGray!
    
    
    var getVsPayBack = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setData()
    }
    
    func setData() {
        // current debt
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let currentDebtFormatted = numberFormatter.string(from: NSNumber(value: player.debt))!
        currentDebtLabel.text = "\(currentDebtFormatted) cr."
        
        // maximum loan--round down to nearest multiple of 100
        var maxLoan = getMaxLoan()
        maxLoan = maxLoan - (maxLoan % 100)
        let maxLoanFormatted = numberFormatter.string(from: NSNumber(value: maxLoan))!
        maximumLoanLabel.text = "\(maxLoanFormatted) cr."
        
        
        
        // disable pay back loan button if no debt
        if player.debt == 0 {
            payBackLoanLabel.isEnabled = false
        } else {
            payBackLoanLabel.isEnabled = true
        }
        
        // disable get loan button if no credit available
        if maxLoan == 0 {
            getLoanLabel.isEnabled = false
        } else {
            getLoanLabel.isEnabled = true
        }
        
        // insurance numbers
        let shipValueFormatted = numberFormatter.string(from: NSNumber(value: player.commanderShip.value))!
        shipValueLabel.text = "\(shipValueFormatted) cr."
        
        let noClaimFormatted = numberFormatter.string(from: NSNumber(value: player.noClaim))!
        noClaimDiscountLabel.text = "\(noClaimFormatted)%"
        
        let insuranceCostFormatted = numberFormatter.string(from: NSNumber(value: player.insuranceCost))!
        costsLabel.text = "\(insuranceCostFormatted) cr. daily"
        
        // set buy/stop insurance
        if player.insurance {
            let controlState = UIControlState()
            buyInsuranceOutlet.setTitle("Stop Insurance", for: controlState)
        } else {
            let controlState = UIControlState()
            buyInsuranceOutlet.setTitle("Buy Insurance", for: controlState)
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

    @IBAction func getLoan(_ sender: AnyObject) {
        getVsPayBack = true
        performSegue(withIdentifier: "bankQuantitySegue", sender: nil)
    }
    
    @IBAction func payBackLoan(_ sender: AnyObject) {
        getVsPayBack = false
        performSegue(withIdentifier: "bankQuantitySegue", sender: nil)
    }

    @IBAction func buyInsurance(_ sender: AnyObject) {
        if player.insurance {
            // stop insurance
            let title = "Stop Insurance"
            let message = "Do you really want to stop your insurance and lose your no-claim?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                player.insurance = false
                self.setData()
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            // buy insurance
            if player.escapePod {
                // launch modal/alert/whatever to buy insurance
                player.insurance = true
                self.setData()
                
            } else {
                let title = "No Escape Pod"
                let message = "Insurance isn't useful to you, since you don't have an escape pod."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                }))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "bankQuantitySegue") {
            // set up VC, add getVsPayBack to it as Bool?, maxLoan as Int?
            
            let vc = (segue.destination as! BankQuantityVC)
            vc.getVsPayBack = getVsPayBack
            vc.maxLoan = getMaxLoan()
            //print("maxLoan: \(vc.maxLoan)")
        }
        
    }
    
}
