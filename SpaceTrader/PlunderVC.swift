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

class PlunderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        updateUI()
    }
    
    
    @IBOutlet weak var waterQuantity: UIButton!
    @IBOutlet weak var fursQuantity: UIButton!
    @IBOutlet weak var foodQuantity: UIButton!
    @IBOutlet weak var oreQuantity: UIButton!
    @IBOutlet weak var gamesQuantity: UIButton!
    @IBOutlet weak var firearmsQuantity: UIButton!
    @IBOutlet weak var medicineQuantity: UIButton!
    @IBOutlet weak var machinesQuantity: UIButton!
    @IBOutlet weak var narcoticsQuantity: UIButton!
    @IBOutlet weak var robotsQuantity: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var baysLabel: UILabel!
    @IBOutlet weak var jettisonButton: UIButton!
    
    var jettisonMode = false
    
    weak var delegate: PlunderDelegate?
    
    func updateUI() {
        let controlState = UIControlState()
        // set title to "Plunder Cargo", jettison button text to present
        titleLabel.text = "Plunder Cargo"
        jettisonButton.setTitle("Jettison", forState: controlState)
        
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
        
        let baysInUse = player.commanderShip.cargoBays - player.commanderShip.baysAvailable
        baysLabel.text = "Bays: \(baysInUse)/\(player.commanderShip.cargoBays)"
    }
    
    func updateUIJettisonMode() {
        let controlState = UIControlState()
        // set title to "Jettison Cargo", make jettison button vanish
        titleLabel.text = "Jettison Cargo"
        jettisonButton.setTitle("", forState: controlState)
        
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
        
        
        let baysInUse = player.commanderShip.cargoBays - player.commanderShip.baysAvailable
        baysLabel.text = "Bays: \(baysInUse)/\(player.commanderShip.cargoBays)"
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
    
    @IBAction func waterAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Water)
    }
    
    @IBAction func fursAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Furs)
    }
    
    @IBAction func foodAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Food)
    }
    
    @IBAction func oreAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Ore)
    }
    
    @IBAction func gamesAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Games)
    }
    
    @IBAction func firearmsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Firearms)
    }
    
    @IBAction func medicineAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Medicine)
    }
    
    @IBAction func machinesAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Machines)
    }
    
    @IBAction func narcoticsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Narcotics)
    }
    
    @IBAction func robotsAll(sender: AnyObject) {
        plunderOrJettisonAll(TradeItemType.Robots)
    }
    
    @IBAction func jettisonButton(sender: AnyObject) {
        if jettisonMode {
            // do nothing
        } else {
            jettisonMode = true
            updateUIJettisonMode()
        }
    }
    
    
}
