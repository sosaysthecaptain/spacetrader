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
    
    override func viewDidAppear(_ animated: Bool) {
        if player.commanderShip.sculptureSpecialCargo {
            sculpture = true
        }
        
        self.meltdownAlert()
    }
    
    func meltdownAlert() {
        let alert = Alert(ID: AlertID.reactorMeltdown, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // if escape pod, display escape pod alerts. Else, die.
            if player.escapePod {
                // escape pod activated
                self.escapePodActivatedAlert()
            } else {
                // player is killed
                player.endGameType = EndGameStatus.killed
                self.killedAlert()
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }

    func killedAlert() {
        let alert = Alert(ID: AlertID.gameEndKilled, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "gameOverVC")
            self.present(vc, animated: false, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func escapePodActivatedAlert() {
        let alert = Alert(ID: AlertID.encounterEscapePodActivated, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // replace player's ship with a flea
            player.escapedNewFlea()
            
            self.sculptureChecker()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func sculptureChecker() {
        if sculpture {
            let alert = Alert(ID: AlertID.sculptureSaved, passedString1: nil, passedString2: nil, passedString3: nil)
            let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                player.commanderShip.sculptureSpecialCargo = true
                
                self.fleaBuiltAlert()
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            insuranceChecker()
        }
    }
    
    func insuranceChecker() {
        if player.insurance {
            let alert = Alert(ID: AlertID.sculptureSaved, passedString1: nil, passedString2: nil, passedString3: nil)
            let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // restore sculpture
                player.commanderShip.sculptureSpecialCargo = true
                self.fleaBuiltAlert()
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            fleaBuiltAlert()
        }
    }
    
    func fleaBuiltAlert() {
        let alert = Alert(ID: AlertID.fleaBuilt, passedString1: nil, passedString2: nil, passedString3: nil)
        let alertController = UIAlertController(title: alert.header, message: alert.text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // THIS MUST GET THE NAV CONTROLLER
//            self.performSegueWithIdentifier("systemInfoFromMeltdown", sender: nil)
            let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "mainTabBarController")
            self.present(vc, animated: false, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // do we want the sculpture scenario to be addressed here?
}

