//
//  EncounterVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/10/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class EncounterVCOld: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerShipType.text = player.commanderShip.name
        playerHull.text = "Hull at \(player.commanderShip.hullPercentage)%"
        playerShields.text = player.getShieldStrengthString(player.commanderShip)
        opponentShipType.text = galaxy.currentJourney!.currentEncounter!.opponent.ship.name
        opponentHull.text = "Hull at \(galaxy.currentJourney!.currentEncounter!.opponent.ship.hullPercentage)%"
        opponentShields.text = player.getShieldStrengthString(galaxy.currentJourney!.currentEncounter!.opponent.ship)
        
        // if encounterText1 not otherwise set, display first context information. Else, display it
        if galaxy.currentJourney!.currentEncounter!.encounterText1 == "" {
            firstTextBlock.text = "At \(galaxy.currentJourney!.clicks) clicks from \(galaxy.targetSystem!.name) you encounter a \(galaxy.currentJourney!.currentEncounter!.opponent.ship.IFFStatus.rawValue) \(galaxy.currentJourney!.currentEncounter!.opponent.ship.name)."
        } else {
            firstTextBlock.text = galaxy.currentJourney!.currentEncounter!.encounterText1
        }
        
        //firstTextBlock.text = galaxy.currentJourney!.currentEncounter!.encounterText1
        secondTextBlock.text = galaxy.currentJourney!.currentEncounter!.encounterText2
        
        let controlState = UIControlState()
        button1Text.setTitle("\(galaxy.currentJourney!.currentEncounter!.button1Text)", for: controlState)
        button2Text.setTitle("\(galaxy.currentJourney!.currentEncounter!.button2Text)", for: controlState)
        button3Text.setTitle("\(galaxy.currentJourney!.currentEncounter!.button3Text)", for: controlState)
        button4Text.setTitle("\(galaxy.currentJourney!.currentEncounter!.button4Text)", for: controlState)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(EncounterVCOld.messageHandler(_:)), name: NSNotification.Name(rawValue: "encounterNotification"), object: nil)
    }
    
    
    @IBOutlet weak var playerShipType: UILabel!
    @IBOutlet weak var playerHull: UILabel!
    @IBOutlet weak var playerShields: UILabel!
    @IBOutlet weak var opponentShipType: UILabel!
    @IBOutlet weak var opponentHull: UILabel!
    @IBOutlet weak var opponentShields: UILabel!
    
    
    @IBOutlet weak var firstTextBlock: UITextView!
    @IBOutlet weak var secondTextBlock: UITextView!
    
    
    @IBOutlet weak var button1Text: UIButton!
    @IBOutlet weak var button2Text: UIButton!
    @IBOutlet weak var button3Text: UIButton!
    @IBOutlet weak var button4Text: UIButton!
    
    @objc func messageHandler(_ notification: Notification) {
        let receivedMessage: String = notification.object! as! String
        
        if receivedMessage == "playerKilled" {
            gameOverModal()
        } else if receivedMessage == "dismissViewController" {
            dismissViewController()
        } else if receivedMessage == "simple" {
            launchGenericSimpleModal()
        } else if receivedMessage == "pirateDestroyed" {
            let statusType: IFFStatusType = galaxy.currentJourney!.currentEncounter!.opponent.ship.IFFStatus
            pirateOrTraderDestroyedAlert(statusType)
        } else if receivedMessage == "dismiss" {
            dismissViewController()
        } else if receivedMessage == "submit" {
            submit()
        }
    }
    
    func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func button1(_ sender: AnyObject) {
        // ask if you really want to attack police/trader if your criminal record isn't bad
        if galaxy.currentJourney!.currentEncounter!.button1Text == "Attack" {
            if (galaxy.currentJourney!.currentEncounter!.opponent.ship.IFFStatus == IFFStatusType.Police) && (player.policeRecordInt > 2) {
                fireAttackWarningModal("police")
                
            } else if (galaxy.currentJourney!.currentEncounter!.opponent.ship.IFFStatus == IFFStatusType.Trader) && (player.policeRecordInt > 4) {
                fireAttackWarningModal("trader")
            } else {
                //self.dismissViewControllerAnimated(false, completion: nil)
                //galaxy.currentJourney!.currentEncounter!.resumeEncounter(1)
            }
        } else {
            //self.dismissViewControllerAnimated(false, completion: nil)
            //galaxy.currentJourney!.currentEncounter!.resumeEncounter(1)
        }
    }
    
    func fireAttackWarningModal(_ type: String) {
        var title: String = "Attack Police?"
        var message: String = "Are you sure you want to attack the police? Your police record will be set to criminal!"
        if type == "trader" {
            title = "Attack Trader?"
            message = "Are you sure you want to attack a trader? Your police record will be set to dubious!"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Attack", style: UIAlertActionStyle.destructive,handler: {
            (alert: UIAlertAction!) -> Void in
            // go ahead with it
            if type == "police" {
                player.policeRecord = PoliceRecordType.criminalScore
            } else if type == "trader" {
                player.policeRecord = PoliceRecordType.dubiousScore
            }
            self.dismiss(animated: false, completion: nil)
            //galaxy.currentJourney!.currentEncounter!.resumeEncounter(1)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameOverModal() {
        let title: String = "You Lose"
        let message: String = "You ship has been destroyed by your opponent."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "gameOver", sender: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func button2(_ sender: AnyObject) {
        print("button2 pressed. Button2 text is \(galaxy.currentJourney!.currentEncounter!.button2Text)")
        
        // see if player is unnecessarily fleeing police
        if (galaxy.currentJourney!.currentEncounter!.button2Text == "Flee") && (galaxy.currentJourney!.currentEncounter!.opponent.ship.IFFStatus == IFFStatusType.Police) {
            
            var contraband = false
            for item in player.commanderShip.cargo {
                if (item.item == TradeItemType.Firearms) || (item.item == TradeItemType.Narcotics) {
                    contraband = true
                }
            }
            
            if !contraband {
                // launch warning dialog
                let title: String = "You Have Nothing Illegal"
                let message: String = "Are you sure you want to do that? You are not carrying illegal goods, so you have nothing to fear!"
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Yes, I still want to", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // set police record to dubious if better, flee
                    if player.policeRecordInt > 4 {
                        player.policeRecord = PoliceRecordType.dubiousScore
                    }
                    //galaxy.currentJourney!.currentEncounter!.resumeEncounter(2)
                }))
                alertController.addAction(UIAlertAction(title: "OK, I won't", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // nothing, just close the modal
                }))
                self.present(alertController, animated: true, completion: nil)
            } else {
                // player has contraband; let him flee
                print("player has contraband, let him flee")
                //galaxy.currentJourney!.currentEncounter!.resumeEncounter(2)
            }
        } else {
            // otherwise, do the thing
            //galaxy.currentJourney!.currentEncounter!.resumeEncounter(2)
        }
        
    }
    
    @IBAction func button3(_ sender: AnyObject) {
        //self.dismissViewControllerAnimated(false, completion: nil)
        //galaxy.currentJourney!.currentEncounter!.resumeEncounter(3)
    }
    
    @IBAction func button4(_ sender: AnyObject) {
        //self.dismissViewControllerAnimated(false, completion: nil)
        //galaxy.currentJourney!.currentEncounter!.resumeEncounter(4)
    }
    
    // FOR TESTING PURPOSES ONLY
    @IBAction func closeButton(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
        galaxy.currentJourney!.currentEncounter!.concludeEncounter()
    }
    
    // use this when it is a notification with an OK button that does NOTHING but end the encounter
    func launchGenericSimpleModal() {
        let title = galaxy.currentJourney!.currentEncounter!.alertTitle
        let message = galaxy.currentJourney!.currentEncounter!.alertText
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // dismiss encounter dialog
            self.dismiss(animated: false, completion: nil)
            // how to resume?
            galaxy.currentJourney!.currentEncounter!.concludeEncounter()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func pirateOrTraderDestroyedAlert(_ type: IFFStatusType) {
        var title = ""
        var message = ""
        if type == IFFStatusType.Pirate && (player.policeRecordInt > 2) {
            let bounty = galaxy.currentJourney!.currentEncounter!.opponent.ship.bounty
            player.credits += bounty
            title = "Opponent Destroyed"
            message = "You have destroyed your opponent, earning a bounty of \(bounty) credits."
        } else {
            let bounty = galaxy.currentJourney!.currentEncounter!.opponent.ship.bounty
            player.credits += bounty
            
            title = "Opponent Destroyed"
            message = "You have destroyed your opponent."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // dismiss encounter dialog
            //self.dismissViewControllerAnimated(false, completion: nil)
            var number = 0
            switch player.difficulty {
            case DifficultyType.beginner:
                number = 0
            case DifficultyType.easy:
                number = 0
            case DifficultyType.normal:
                number = 50
            case DifficultyType.hard:
                number = 66
            case DifficultyType.impossible:
                number = 75
            }
            
            if rand(100) > number {
                // scoop
                print("scooping...")
                self.scoop()
            } else {
                print("no scoop. Concluding encounter.")
                galaxy.currentJourney!.currentEncounter!.concludeEncounter()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func scoop() {
        // figure out what floated by
        let random = rand(galaxy.currentJourney!.currentEncounter!.opponent.ship.cargo.count)
        let itemType = galaxy.currentJourney!.currentEncounter!.opponent.ship.cargo[random].item
        let item = TradeItem(item: itemType, quantity: 1, pricePaid: 0)
        
        // launch alert to pick it up
        let title = "Scoop"
        let message = "A canister from the destroyed ship, labeled \(item.name), drifts within range of your scoops."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Pick It Up", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // dismiss and resume, for now
            print("you picked it up")
            //player.commanderShip.cargo.append(item)
            // CORRECTED VERSION
            print("SCOOP (ENCOUNTERVCOLD) RUNNING. ABOUT TO ADD CARGO BY CORRECTED METHOD")
            player.commanderShip.addCargo(item.item, quantity: 1, pricePaid: 0)
            
            self.dismiss(animated: false, completion: nil)
            galaxy.currentJourney!.currentEncounter!.concludeEncounter()
        }))
        alertController.addAction(UIAlertAction(title: "Let It Go", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // dismiss and resume, for now
            print("you let it go")
            self.dismiss(animated: false, completion: nil)
            galaxy.currentJourney!.currentEncounter!.concludeEncounter()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func submit() {
        var contraband = false
        for item in player.commanderShip.cargo {
            if (item.item == TradeItemType.Firearms) || (item.item == TradeItemType.Narcotics) {
                contraband = true
            }
        }
        
        // if not, apologise
        if !contraband {
            let title = "Nothing Found"
            let message = "The police find nothing illegal in your cargo holds, and apologise for the inconvenience."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // dismiss and conclude encounter
                self.dismiss(animated: false, completion: nil)
                galaxy.currentJourney!.currentEncounter!.concludeEncounter()
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            // if so, ask if you really want to submit to an inspection
            let title = "You Have Illegal Goods"
            let message = "Are you sure you want to let the police search you? You are carrying illegal goods!"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Yes, let them", style: UIAlertActionStyle.destructive ,handler: {
                (alert: UIAlertAction!) -> Void in
                // arrest
                self.arrest()
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // dismiss alert
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func arrest() {
        print("ARREST!")
        // Figure out punishment
        // close journey
        // mete out punishment
        // display appropriate modal
        // conclude journey
        
    }
    
}
