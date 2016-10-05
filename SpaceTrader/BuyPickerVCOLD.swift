//
//  BuyPickerVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/18/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

// this is the modern version of BuyModalVC
class BuyPickerVCOLD: UIViewController {

    @IBOutlet weak var firstLabel: StandardLabel!
    @IBOutlet weak var secondLabel: StandardLabel!
    @IBOutlet weak var quantityLabel: PurpleHeader!
    
    @IBOutlet weak var slider: UISlider!
    
    let commodity = buySellCommodity!                        // this is stored as a global
    let max = player.getMax(buySellCommodity!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set page title
        // TODO
        
        // set slider max and min
        slider.minimumValue = 0
        slider.maximumValue = Float(max)            // change this
        slider.value = 0
        
        updateUI()
    }
    
    func updateUI() {
        // set labels
        //firstLabel.text = "You can buy up to \(max) bays of \(commodity.rawValue)."
        secondLabel.text = "How many would you like to buy?"
        quantityLabel.text = "\(Int(slider.value)) bays"
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        updateUI()
    }
    
    @IBAction func buyPressed(_ sender: AnyObject) {
    }
    

}
