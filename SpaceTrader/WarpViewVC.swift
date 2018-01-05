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
        NotificationCenter.default.addObserver(self, selector: #selector(WarpViewVC.messageHandler(_:)), name: NSNotification.Name(rawValue: "encounterModalFireNotification"), object: nil)

    }


    // set dark statusBar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // FIRE ALERT MODALS
    // (maybe this should only fire the first? Let additional ones be sequential?)
    @objc func messageHandler(_ notification: Notification) {
        let receivedMessage: String = notification.object! as! String
        
        if receivedMessage == "main" {
            performSegue(withIdentifier: "encounterModal", sender: nil)
        } else if receivedMessage == "done" {
            print("firing return segue")
            performSegue(withIdentifier: "returnToTabBar", sender: nil)
        } else if receivedMessage == "playerDestroyedEscapes" {
            playerDestroyedEscapesSequence()
        }
    }
    
    func playerDestroyedEscapesSequence() {
        let title = "Escape Pod Activated"
        let message = "Just before the final demise of your ship, your escape pod gets activated and ejects you. After a few days, the Space Corps picks you up and drops you off at a nearby space port."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            if player.insurance {
                // insurance refund alert, then fleaBuilt
                self.insuranceAward()
            } else {
                // straight to fleaBuilt
                self.fleaBuilt()
            }
            
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func insuranceAward() {
        let title = "Insurance"
        let message = "Since your ship was insured, the bank pays you the total worth of the destroyed ship."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            player.credits += player.insuredValue
            // and turn off insurance
            player.noClaim = 0
            player.insurance = false
            self.fleaBuilt()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fleaBuilt() {
        // give player a flea with no cargo
        if player.credits > 500 {
            player.credits -= 500
        } else {
            player.debt += 500
        }
        player.commanderShip = SpaceShip(type: ShipType.flea, IFFStatus: IFFStatusType.Player)
        
        
        // alert
        let title = "Flea Built"
        let message = "In 3 days and with 500 credits, you manage to convert your pod into a Flea."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            galaxy.currentJourney!.completeJourney()
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
        print("is the player's ship now a flea? It should be. Player ship:\(player.commanderShip.name)")
    }

}
