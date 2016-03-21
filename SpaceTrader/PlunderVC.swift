//
//  PlunderVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/31/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

protocol PlunderDelegate: class {
    func plunderDidFinish(controller: PlunderVC)
}

class PlunderVC: UIViewController, PlunderVCDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        updateUI()
    }
    
//    override func viewDidAppear(animated: Bool) {
//        updateUI()
//        print("viewDidAppear firing")
//    }
    
    // set dark statusBar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    @IBOutlet weak var waterQuantity: PurpleButtonVanishes!
    @IBOutlet weak var fursQuantity: PurpleButtonVanishes!
    @IBOutlet weak var foodQuantity: PurpleButtonVanishes!
    @IBOutlet weak var oreQuantity: PurpleButtonVanishes!
    @IBOutlet weak var gamesQuantity: PurpleButtonVanishes!
    @IBOutlet weak var firearmsQuantity: PurpleButtonVanishes!
    @IBOutlet weak var medicineQuantity: PurpleButtonVanishes!
    @IBOutlet weak var machinesQuantity: PurpleButtonVanishes!
    @IBOutlet weak var narcoticsQuantity: PurpleButtonVanishes!
    @IBOutlet weak var robotsQuantity: PurpleButtonVanishes!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var doneButton: PurpleButtonVanishes!
    @IBOutlet weak var jettisonButton: PurpleButtonVanishes!
    
    @IBOutlet weak var baysDisplay: BaysCashBoxView!
    
    
    var jettisonMode = false
    
    weak var delegate: PlunderDelegate?
    
    // delegate (JettisonPickerVC) function--this fires when JettisonPickerVC completes
    func plunderPickerDidFinish(controller: JettisonPickerVC) {
        // set plunder or jettison mode correctly, update UI accordingly
        if justFinishedJettisonNotPlunder {
            jettisonMode = true
            
            // update UI, jettison mode
            updateUIJettisonMode()
        } else {
            jettisonMode = false
            
            // update UI, plunder mode
            updateUI()
        }
        
        // reset the flag for next time
        justFinishedJettisonNotPlunder = false
    }
    
    func updateUI() {
        let controlState = UIControlState()
        // set title to "Plunder Cargo", jettison button text to present
        titleLabel.text = "Plunder Cargo"
        jettisonButton.enabled = true
        doneButton.setTitle("Done", forState: controlState)
        //jettisonButton.setTitle("Jettison", forState: controlState)
        
        // set quantities
        waterQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Water))", forState: controlState)
        fursQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Furs))", forState: controlState)
        foodQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Food))", forState: controlState)
        oreQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Ore))", forState: controlState)
        gamesQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Games))", forState: controlState)
        firearmsQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Firearms))", forState: controlState)
        medicineQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Medicine))", forState: controlState)
        machinesQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Machines))", forState: controlState)
        narcoticsQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Narcotics))", forState: controlState)
        robotsQuantity.setTitle("\(galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(TradeItemType.Robots))", forState: controlState)
        
        baysDisplay.redrawSelf()
    }
    
    func updateUIJettisonMode() {
        let controlState = UIControlState()
        // set title to "Jettison Cargo", make jettison button vanish
        titleLabel.text = "Jettison Cargo"
        doneButton.setTitle("Back to Plunder", forState: controlState)
        jettisonButton.enabled = false
        //jettisonButton.setTitle("", forState: controlState)
        
        // set quantities on commander ship
        waterQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Water))", forState: controlState)
        fursQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Furs))", forState: controlState)
        foodQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Food))", forState: controlState)
        oreQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Ore))", forState: controlState)
        gamesQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Games))", forState: controlState)
        firearmsQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Firearms))", forState: controlState)
        medicineQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Medicine))", forState: controlState)
        machinesQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Machines))", forState: controlState)
        narcoticsQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Narcotics))", forState: controlState)
        robotsQuantity.setTitle("\(player.commanderShip.getQuantity(TradeItemType.Robots))", forState: controlState)
        
        
//        let baysInUse = player.commanderShip.cargoBays - player.commanderShip.baysAvailable
//        baysLabel.text = "Bays: \(baysInUse)/\(player.commanderShip.cargoBays)"
    }
    
    func getMaxQuantity(commodity: TradeItemType) -> Int {
        // max available to plunder
        
        let quantityOnBoard = galaxy.currentJourney!.currentEncounter!.opponent.ship.getQuantity(commodity)
        let baysAvailable = player.commanderShip.baysAvailable
        
        return min(quantityOnBoard, baysAvailable)
    }
    
    func plunder(commodity: TradeItemType, amount: Int) -> Bool {
        // make sure space to go through
        if amount > getMaxQuantity(commodity) {
            return false
        }
        
        // add to player
        player.commanderShip.addCargo(commodity, quantity: amount, pricePaid: 0)
        
        // remove from opponent
        galaxy.currentJourney!.currentEncounter!.opponent.ship.removeCargo(commodity, quantity: amount)
        
        return true
    }

    @IBAction func doneButton(sender: AnyObject) {
        if jettisonMode {
            jettisonMode = false
            updateUI()
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            delegate?.plunderDidFinish(self)
        }
    }
    
    func plunderOrJettisonAll(commodity: TradeItemType) {
        if jettisonMode {
            let quantity = player.commanderShip.getQuantity(commodity)
            player.commanderShip.removeCargo(commodity, quantity: quantity)
            updateUIJettisonMode()
        } else {
            let quantity = getMaxQuantity(commodity)
            plunder(commodity, amount: quantity)
            updateUI()
        }
    }
    
    // "Some" button functions
    // ALL OF THESE MUST FIRE ONLY IF THE RELEVANT QUANTITY IS GREATER THAN ZERO
    @IBAction func waterSome(sender: AnyObject) {
        // set buySellCommodity to water
        buySellCommodity = TradeItemType.Water
        
        // set plunderAsOpposedToJettison (if !jettisonMode)
        plunderAsOpposedToJettison = !jettisonMode
        
        // fire segue
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func fursSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Furs
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func foodSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Food
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func oreSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Ore
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func gamesSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Games
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func firearmsSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Firearms
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func medicineSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Medicine
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func machinesSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Machines
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func narcoticsSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Narcotics
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    @IBAction func robotsSome(sender: AnyObject) {
        buySellCommodity = TradeItemType.Robots
        plunderAsOpposedToJettison = !jettisonMode
        performSegueWithIdentifier("jettisonPicker", sender: sender)
    }
    
    
    
    // "All" button functions
    @IBAction func waterAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Water)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func fursAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Furs)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func foodAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Food)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func oreAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Ore)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func gamesAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Games)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func firearmsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Firearms)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func medicineAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Medicine)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func machinesAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Machines)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func narcoticsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Narcotics)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func robotsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Robots)
        baysDisplay.redrawSelf()
    }
    
    @IBAction func jettisonButton(sender: AnyObject) {
        if jettisonMode {
            // do nothing
        } else {
            jettisonMode = true
            updateUIJettisonMode()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // make the delegate work
        if segue.identifier == "jettisonPicker" {
            print("relevant segue firing")
            let modalVC: JettisonPickerVC = segue.destinationViewController as! JettisonPickerVC
            modalVC.delegate = self
        }
    }
    
    
}
