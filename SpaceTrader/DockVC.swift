//
//  DockVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/4/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class DockVC: UIViewController {

    
    @IBOutlet weak var shipMessage1: UILabel!
    @IBOutlet weak var shipMessage2: UILabel!
    @IBOutlet weak var equipmentMessage1: UILabel!
    @IBOutlet weak var equipmentMessage2: UILabel!
    @IBOutlet weak var podMessage1: UILabel!
    @IBOutlet weak var podMessage2: UILabel!
    
    @IBOutlet weak var shipButton: CustomButton!
    @IBOutlet weak var equipmentButton: CustomButton!
    @IBOutlet weak var podButton: CustomButton!
    
    
    override func viewDidLoad() {
        updateUI()
    }
    
    func updateUI() {
        // how to determine whether there are ships for sale?
        
        // display ships for sale message if ships are for sale
        shipMessage1.text = "There are ships for sale."
        shipMessage2.text = ""
        
        // display equipment for sale message if equipment is for sale
        equipmentMessage1.text = "There is equipment for sale."
        equipmentMessage2.text = ""
        
        if player.escapePod {
            podMessage1.text = "You have an escape pod installed."
            podMessage2.text = ""
            podButton.enabled = false
        } else if galaxy.getTechLevelValue(galaxy.currentSystem!.techLevel) <= 2 {
            podMessage1.text = "No escape pods for sale."
            podMessage2.text = ""
            podButton.enabled = false
        } else if player.credits < 2000 {
            podMessage1.text = "You need at least 2,000 cr. to buy an escape pod."
            podMessage2.text = ""
            podButton.enabled = false
        } else {
            // if current system is advanced enough to sell escape pods, make available
            podMessage1.text = "You can buy an escape pod for 2,000 cr."
            podMessage2.text = ""
            podButton.enabled = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        updateUI()
    }

    @IBAction func buyPod(sender: AnyObject) {
        // assumes vetted that player doesn't already have pod, has enough cash
        // launch modal
        let title: String = "Escape Pod"
        let message: String = "Do you want to buy an escape pod for 2,000 credits?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // buy pod
            player.credits -= 2000
            player.escapePod = true
            self.updateUI()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // nothing, just close the modal
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
}
