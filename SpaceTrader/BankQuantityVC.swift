//
//  BankQuantityVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/17/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class BankQuantityVC: UIViewController {

    var getVsPayBack: Bool?
    var maxLoan: Int?
    var selectedValue: Float = 0
    var maxLoanFloat: Float {
        get {
            return Float(maxLoan!)
        }
    }
    var selectedValueRounded = 0
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var buttonOutlet: PurpleButtonTurnsGray!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if getVsPayBack! {
            self.title = "Get Loan"
        } else {
            self.title = "Pay Back Loan"
        }
        
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateData()
    }
    
    func updateData() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let maxLoanFormatted = numberFormatter.string(from: NSNumber(value: maxLoan!))!
        
        let debtFormatted = numberFormatter.string(from: NSNumber(value: player.debt))!
        
        if getVsPayBack! {
            text1.text = "You can borrow up to \(maxLoanFormatted) credits."
            text2.text = "How much do you want to borrow?"
        } else {
            text1.text = "You have a debt of \(debtFormatted) credits."
            text2.text = "How much do you want to pay back?"
        }
        
        
        sliderValueChanged(sliderOutlet)
        
        // set button title
        if getVsPayBack! {
            let controlState = UIControlState()
            buttonOutlet.setTitle("Get Loan", for: controlState)
        } else {
            let controlState = UIControlState()
            buttonOutlet.setTitle("Pay Back Loan", for: controlState)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if getVsPayBack! {
            selectedValue = sender.value * maxLoanFloat
            selectedValue = round(0.01 * selectedValue) / 0.01      // round to nearest hundred
            selectedValueRounded = Int(selectedValue)
        } else {
            selectedValue = sender.value * Float(player.debt)
            selectedValue = round(selectedValue)      // round to nearest whole number
            selectedValueRounded = Int(selectedValue)
        }
        
        
        
        // format
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let selectedValueFormatted = numberFormatter.string(from: NSNumber(value: selectedValue))!
        
        numberLabel.text = "\(selectedValueFormatted) credits"
        
        // disable get loan button if quantity is zero
        if selectedValue == 0 {
            buttonOutlet.isEnabled = false
        } else {
            buttonOutlet.isEnabled = true
        }
    }

    @IBAction func getLoan(_ sender: AnyObject) {
        if getVsPayBack! {
            player.credits += selectedValueRounded
            player.debt += selectedValueRounded
            
            navigationController?.popViewController(animated: true)
        } else {
            // MUST CHECK IF ENOUGH MONEY FIRST
            // does rounding by hundreds work here?
            
            player.credits -= selectedValueRounded
            player.debt -= selectedValueRounded
            
            navigationController?.popViewController(animated: true)
        }
        
    }

}
