//
//  WarpViewVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/26/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class WarpViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageHandler:", name: "encounterModalFireNotification", object: nil)

    }


    // FIRE ALERT MODALS
    // (maybe this should only fire the first? Let additional ones be sequential?)
    func messageHandler(notification: NSNotification) {
        let receivedMessage: String = notification.object! as! String
        
        if receivedMessage == "main" {
            performSegueWithIdentifier("encounterModal", sender: nil)
        } else if receivedMessage == "done" {
            print("firing return segue")
            performSegueWithIdentifier("returnToTabBar", sender: nil)
        } else if receivedMessage == "playerDestroyedEscapes" {
            playerDestroyedEscapesSequence()
        }
    }
    
    func playerDestroyedEscapesSequence() {
        let title = "Escape Pod Activated"
        let message = "Just before the final demise of your ship, your escape pod gets activated and ejects you. After a few days, the Space Corps picks you up and drops you off at a nearby space port."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            if player.insurance {
                // insurance refund alert, then fleaBuilt
                self.insuranceAward()
            } else {
                // straight to fleaBuilt
                self.fleaBuilt()
            }
            
        }))

        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func insuranceAward() {
        let title = "Insurance"
        let message = "Since your ship was insured, the bank pays you the total worth of the destroyed ship."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            player.credits += player.insuredValue
            // and turn off insurance
            player.noClaim = 0
            player.insurance = false
            self.fleaBuilt()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fleaBuilt() {
        // give player a flea with no cargo
        if player.credits > 500 {
            player.credits -= 500
        } else {
            print("too poor. FIGURE OUT WHAT TO DO")
            // MUST GO INTO DEBT TO BUILD NEW SHIP. IMPLEMENT THIS WHEN THE BANK EXISTS
        }
        player.commanderShip = SpaceShip(type: ShipType.Flea, IFFStatus: IFFStatusType.Player)
        
        
        // alert
        let title = "Flea Built"
        let message = "In 3 days and with 500 credits, you manage to convert your pod into a Flea."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            galaxy.currentJourney!.completeJourney()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        print("is the player's ship now a flea? It should be. Player ship:\(player.commanderShip.name)")
    }

}
