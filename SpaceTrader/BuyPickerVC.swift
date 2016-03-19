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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set page title

        // set slider max and min
        slider.minimumValue = 0
        slider.maximumValue = 10            // change this
        slider.value = 0
        
        updateUI()
    }
    
    func updateUI() {
        // set labels
        firstLabel.text = "You can buy up to \() bays of \()."
        secondLabel.text = "How many would you like to buy?"
        quantityLabel.text = "\(Int(slider.value)) bays"
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        updateUI()
    }
    
    @IBAction func buyPressed(sender: AnyObject) {
    }
    

}
