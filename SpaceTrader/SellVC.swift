//
//  SellVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/22/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class SellVC: UIViewController, BuyModalVCDelegate {
    
    let controlState = UIControlState()
    

    
    // quantities
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
    
    // price label
    @IBOutlet weak var waterPrice: UILabel!
    @IBOutlet weak var fursPrice: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var orePrice: UILabel!
    @IBOutlet weak var gamesPrice: UILabel!
    @IBOutlet weak var firearmsPrice: UILabel!
    @IBOutlet weak var medicinePrice: UILabel!
    @IBOutlet weak var machinesPrice: UILabel!
    @IBOutlet weak var narcoticsPrice: UILabel!
    @IBOutlet weak var robotsPrice: UILabel!
    
    // P/L label
    @IBOutlet weak var waterPL: UILabel!
    @IBOutlet weak var fursPL: UILabel!
    @IBOutlet weak var foodPL: UILabel!
    @IBOutlet weak var orePL: UILabel!
    @IBOutlet weak var gamesPL: UILabel!
    @IBOutlet weak var firearmsPL: UILabel!
    @IBOutlet weak var medicinePL: UILabel!
    @IBOutlet weak var machinesPL: UILabel!
    @IBOutlet weak var narcoticsPL: UILabel!
    @IBOutlet weak var robotsPL: UILabel!
    
    // "All" buttons, so they can be set to "Dump" if necessary
    @IBOutlet weak var waterAllLabel: UIButton!
    @IBOutlet weak var fursAllLabel: UIButton!
    @IBOutlet weak var foodAllLabel: UIButton!
    @IBOutlet weak var oreAllLabel: UIButton!
    @IBOutlet weak var gamesAllLabel: UIButton!
    @IBOutlet weak var firearmsAllLabel: UIButton!
    @IBOutlet weak var medicineAllLabel: UIButton!
    @IBOutlet weak var machinesAllLabel: UIButton!
    @IBOutlet weak var narcoticsAllLabel: UIButton!
    @IBOutlet weak var robotsAllLabel: UIButton!
    
    // things at the bottom
    

    @IBOutlet weak var baysAvailableLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!

    func sellAll(commodity: TradeItemType) {
        let quantity = player.commanderShip.getQuantity(commodity)
        player.sell(commodity, quantity: quantity)
        recurringUpdate()
        loadPrices()
    }
    
    // "All" buttons
    @IBAction func waterAll() {
        sellAll(TradeItemType.Water)
    }
    
    @IBAction func fursAll() {
        sellAll(TradeItemType.Furs)
    }
    
    @IBAction func foodAll() {
        sellAll(TradeItemType.Food)
    }
    
    @IBAction func oreAll() {
        sellAll(TradeItemType.Ore)
    }

    @IBAction func gamesAll() {
        sellAll(TradeItemType.Games)
    }
    
    @IBAction func firearmsAll() {
        sellAll(TradeItemType.Firearms)
    }
    
    @IBAction func medicineAll() {
        sellAll(TradeItemType.Medicine)
    }
    
    @IBAction func machinesAll() {
        sellAll(TradeItemType.Machines)
    }
    
    @IBAction func narcoticsAll() {
        sellAll(TradeItemType.Narcotics)
    }
    
    @IBAction func robotsAll() {
        sellAll(TradeItemType.Robots)
    }
    
    // sell buttons--need sender, unfortunately
    
    @IBAction func sellWater(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Water) != 0 {
            buySellCommodity = TradeItemType.Water
            performSegueWithIdentifier("sellModal", sender: sender)
        }
    }
    
    @IBAction func sellFurs(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Furs) != 0 {
            buySellCommodity = TradeItemType.Furs
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellFood(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Food) != 0 {
            buySellCommodity = TradeItemType.Food
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellOre(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Ore) != 0 {
            buySellCommodity = TradeItemType.Ore
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellGames(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Games) != 0 {
            buySellCommodity = TradeItemType.Games
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellFirearms(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Firearms) != 0 {
            buySellCommodity = TradeItemType.Firearms
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }

    @IBAction func sellMedicine(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Medicine) != 0 {
            buySellCommodity = TradeItemType.Medicine
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }

    @IBAction func sellMachines(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Machines) != 0 {
            buySellCommodity = TradeItemType.Machines
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellNarcotics(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Narcotics) != 0 {
            buySellCommodity = TradeItemType.Narcotics
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    @IBAction func sellRobots(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Robots) != 0 {
            buySellCommodity = TradeItemType.Robots
            performSegueWithIdentifier("sellModal", sender: sender)
        }

    }
    
    override func viewDidLoad() {
        
        recurringUpdate()
        loadPrices()
        buyAsOpposedToSell = false    
    }
    
    func recurringUpdate() {
        waterQuantity.setTitle("\(player.commanderShip.getQuantity(.Water))", forState: controlState)
        fursQuantity.setTitle("\(player.commanderShip.getQuantity(.Furs))", forState: controlState)
        foodQuantity.setTitle("\(player.commanderShip.getQuantity(.Food))", forState: controlState)
        oreQuantity.setTitle("\(player.commanderShip.getQuantity(.Ore))", forState: controlState)
        gamesQuantity.setTitle("\(player.commanderShip.getQuantity(.Games))", forState: controlState)
        firearmsQuantity.setTitle("\(player.commanderShip.getQuantity(.Firearms))", forState: controlState)
        medicineQuantity.setTitle("\(player.commanderShip.getQuantity(.Medicine))", forState: controlState)
        machinesQuantity.setTitle("\(player.commanderShip.getQuantity(.Machines))", forState: controlState)
        narcoticsQuantity.setTitle("\(player.commanderShip.getQuantity(.Narcotics))", forState: controlState)
        robotsQuantity.setTitle("\(player.commanderShip.getQuantity(.Robots))", forState: controlState)
        
        cashLabel.text = "Cash: \(player.credits) cr."
        
        baysAvailableLabel.text = "Bays: \(player.commanderShip.baysFilled)/\(player.commanderShip.cargoBays)"
    }
    
    func loadPrices() {
        waterPrice.text = "\(galaxy.currentSystem!.waterSell) cr."
        fursPrice.text = "\(galaxy.currentSystem!.fursSell) cr."
        foodPrice.text = "\(galaxy.currentSystem!.foodSell) cr."
        orePrice.text = "\(galaxy.currentSystem!.oreSell) cr."
        gamesPrice.text = "\(galaxy.currentSystem!.gamesSell) cr."
        firearmsPrice.text = "\(galaxy.currentSystem!.firearmsSell) cr."
        medicinePrice.text = "\(galaxy.currentSystem!.medicineSell) cr."
        machinesPrice.text = "\(galaxy.currentSystem!.machinesSell) cr."
        narcoticsPrice.text = "\(galaxy.currentSystem!.narcoticsSell) cr."
        robotsPrice.text = "\(galaxy.currentSystem!.robotsSell) cr."
        
        waterPL.text = "\(player.getPLString(.Water))"
        fursPL.text = "\(player.getPLString(.Furs))"
        foodPL.text = "\(player.getPLString(.Food))"
        orePL.text = "\(player.getPLString(.Ore))"
        gamesPL.text = "\(player.getPLString(.Games))"
        firearmsPL.text = "\(player.getPLString(.Firearms))"
        medicinePL.text = "\(player.getPLString(.Medicine))"
        machinesPL.text = "\(player.getPLString(.Machines))"
        narcoticsPL.text = "\(player.getPLString(.Narcotics))"
        robotsPL.text = "\(player.getPLString(.Robots))"
        
        // handle dump buttons
        if galaxy.currentSystem!.waterSell == 0 {
            waterAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.fursSell == 0 {
            fursAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.foodSell == 0 {
            foodAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.oreSell == 0 {
            oreAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.gamesSell == 0 {
            gamesAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.firearmsSell == 0 {
            firearmsAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.medicineSell == 0 {
            medicineAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.machinesSell == 0 {
            machinesAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.narcoticsSell == 0 {
            narcoticsAllLabel.setTitle("Dump", forState: controlState)
        }
        if galaxy.currentSystem!.robotsSell == 0 {
            robotsAllLabel.setTitle("Dump", forState: controlState)
        }
        
    }
    
    // this updates quantities when this page becomes active
    override func viewWillAppear(animated: Bool) {
        recurringUpdate()
        buyAsOpposedToSell = false
        loadPrices()
        
//        print("DEBUG*********SELL VC TESTING***************")
//        galaxy.currentSystem = galaxy.planets[52]
//        galaxy.currentSystem!.food = 555
//        print("should say 555 if referential: \(galaxy.planets[52].food)")
        
        
    }
    
    func buyModalDidFinish(controller: BuyModalVC) {                    // DELEGATE FUNCTION
        recurringUpdate()
        loadPrices()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // magic required to make delegate work
        if segue.identifier == "sellModal" {
            let modalVC: BuyModalVC = segue.destinationViewController as! BuyModalVC
            modalVC.delegate = self
        }
    }
}
