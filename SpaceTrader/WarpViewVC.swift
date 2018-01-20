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
            print("FIRING ENCOUNTER MODAL")
            presentEncounterVC()
            
            //performSegue(withIdentifier: "encounterModal", sender: nil)     // WHAT IF THIS LINE IS THE SOURCE OF ALL OUR PROBLEMS?
        } else if receivedMessage == "done" {
//            print("firing return segue")
            //print("this is when we occasionally hang")
            //performSegue(withIdentifier: "returnToTabBar", sender: nil) // OR MAYBE IT'S THIS!!!
            //self.dismiss(animated: true, completion: nil)
            doneDismissSystemInfo()
        } else if receivedMessage == "playerDestroyedEscapes" {
            playerDestroyedEscapesSequence()
        }
    }
    
    // outsourced the problem functionality to here
    // if we can make this present on top of whatever's currently on top of the stack, that might solve it
    func presentEncounterVC() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let encounterViewController = storyBoard.instantiateViewController(withIdentifier: "encounterModal")
        
        self.present(encounterViewController, animated: true, completion: nil)
    }
    
    func doneDismissSystemInfo() {
        galaxy.justArrived = true      // WarpVC uses this to switch to systemInfoVC
        galaxy.justArrivedSystem = true
        galaxy.justArrivedSell = true
        galaxy.justArrivedBuy = true
        galaxy.justArrivedShipyard = true
        
        self.dismiss(animated: false, completion: nil)
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
        // this would be an excellent place to handle all the arrival alerts that might need to happen
        // tribbles
        if player.commanderShip.tribbles > 0 {
            player.commanderShip.tribbles = 0
    
            galaxy.alertsToFireOnArrival.append(AlertID.tribblesKilled)
        }
        
        // japori special cargo
        if player.commanderShip.japoriSpecialCargo {
            player.commanderShip.japoriSpecialCargo = false
            galaxy.setSpecial("Nix", id: SpecialEventID.japoriDisease)
            galaxy.alertsToFireOnArrival.append(AlertID.antidoteDestroyed)
        }
        
        // artifact
        if player.commanderShip.artifactSpecialCargo {
            player.commanderShip.artifactSpecialCargo = false
            galaxy.alertsToFireOnArrival.append(AlertID.artifactLost)
        }
        
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
        
    }

}
