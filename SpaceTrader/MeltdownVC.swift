//
//  MeltdownVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 2/8/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class MeltdownVC: UIViewController {
    
    var sculpture = false
    
    // when escape pod present: meltdown alert, escape pod activated, check for sculpture, check for insurance, flea built, taken to systemInfoVC
    // when no escape pod: meltdown alert, killed alert, taken to killed VC

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        if player.commanderShip.sculptureSpecialCargo {
            sculpture = true
        }
        
        self.meltdownAlert()
    }
    
    func meltdownAlert() {
        let alert = Alert(ID: AlertID.ReactorMeltdown, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // if escape pod, display escape pod alerts. Else, die.
            if player.escapePod {
                // escape pod activated
                self.escapePodActivatedAlert()
            } else {
                // player is killed
                player.endGameType = EndGameStatus.Killed
                self.killedAlert()
            }
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func killedAlert() {
        let alert = Alert(ID: AlertID.GameEndKilled, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("gameOverVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func escapePodActivatedAlert() {
        let alert = Alert(ID: AlertID.EncounterEscapePodActivated, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // replace player's ship with a flea
            player.escapedNewFlea()
            
            self.sculptureChecker()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func sculptureChecker() {
        if sculpture {
            let alert = Alert(ID: AlertID.SculptureSaved, passedString1: nil, passedString2: nil, passedString3: nil)
            let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                player.commanderShip.sculptureSpecialCargo = true
                
                self.fleaBuiltAlert()
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            insuranceChecker()
        }
    }
    
    func insuranceChecker() {
        if player.insurance {
            let alert = Alert(ID: AlertID.SculptureSaved, passedString1: nil, passedString2: nil, passedString3: nil)
            let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // restore sculpture
                player.commanderShip.sculptureSpecialCargo = true
                self.fleaBuiltAlert()
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            fleaBuiltAlert()
        }
    }
    
    func fleaBuiltAlert() {
        let alert = Alert(ID: AlertID.FleaBuilt, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // THIS MUST GET THE NAV CONTROLLER
//            self.performSegueWithIdentifier("systemInfoFromMeltdown", sender: nil)
            let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainTabBarController")
            self.presentViewController(vc, animated: false, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // do we want the sculpture scenario to be addressed here?
}

