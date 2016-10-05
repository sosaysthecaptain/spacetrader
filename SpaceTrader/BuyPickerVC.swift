//
//  BuyPickerVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/18/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

// this is the modern version of BuyModalVC
class BuyPickerVC: UIViewController {
    
    @IBOutlet weak var firstLabel: StandardLabel!
    @IBOutlet weak var secondLabel: StandardLabel!
    @IBOutlet weak var quantityLabel: PurpleHeader!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var buyButton: PurpleButtonTurnsGray!
    
    let commodity = buySellCommodity!                        // this is stored as a global
    let max = player.getMax(buySellCommodity!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set color of slider
        slider.tintColor = mainPurple
        
        // set page title
        self.title = "Buy \(commodity.rawValue)"
        
        // set slider max and min
        slider.minimumValue = 0
        slider.maximumValue = Float(max)            // change this
        slider.value = 0
        
        updateUI()
    }
    
    func updateUI() {
        // set labels
        firstLabel.text = "You can buy up to \(max) bays of \(commodity.rawValue)."
        secondLabel.text = "How many would you like to buy?"
        quantityLabel.text = "\(Int(slider.value)) bays"
        
        // disable buy if quantity is zero
        if slider.value == 0 {
            buyButton.isEnabled = false
        } else {
            buyButton.isEnabled = true
        }
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        updateUI()
    }
    
    @IBAction func buyPressed(_ sender: AnyObject) {
        // submit transaction
        player.buy(commodity, quantity: Int(slider.value))
        
        // close VC
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
