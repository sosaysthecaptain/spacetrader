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
    

    //@IBOutlet weak var baysAvailableLabel: UILabel!
    //@IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var baysCashBox: BaysCashBoxView!
    

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
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }
    }
    
    @IBAction func sellFurs(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Furs) != 0 {
            buySellCommodity = TradeItemType.Furs
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellFood(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Food) != 0 {
            buySellCommodity = TradeItemType.Food
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellOre(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Ore) != 0 {
            buySellCommodity = TradeItemType.Ore
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellGames(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Games) != 0 {
            buySellCommodity = TradeItemType.Games
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellFirearms(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Firearms) != 0 {
            buySellCommodity = TradeItemType.Firearms
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }

    @IBAction func sellMedicine(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Medicine) != 0 {
            buySellCommodity = TradeItemType.Medicine
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }

    @IBAction func sellMachines(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Machines) != 0 {
            buySellCommodity = TradeItemType.Machines
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellNarcotics(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Narcotics) != 0 {
            buySellCommodity = TradeItemType.Narcotics
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellRobots(sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Robots) != 0 {
            buySellCommodity = TradeItemType.Robots
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegueWithIdentifier("sellPicker", sender: sender)
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
        
        // redraw baysCashBox
        baysCashBox.redrawSelf()
    }
    
    func loadPrices() {
        // format prices
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        let waterPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.waterSell)
        let fursPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.fursSell)
        let foodPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.foodSell)
        let orePriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.oreSell)
        let gamesPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.gamesSell)
        let firearmsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.firearmsSell)
        let medicinePriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.medicineSell)
        let machinesPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.machinesSell)
        let narcoticsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.narcoticsSell)
        let robotsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.robotsSell)

        
        // display prices with "cr." appended
        waterPrice.text = "\(waterPriceFormatted!) cr."
        fursPrice.text = "\(fursPriceFormatted!) cr."
        foodPrice.text = "\(foodPriceFormatted!) cr."
        orePrice.text = "\(orePriceFormatted!) cr."
        gamesPrice.text = "\(gamesPriceFormatted!) cr."
        firearmsPrice.text = "\(firearmsPriceFormatted!) cr."
        medicinePrice.text = "\(medicinePriceFormatted!) cr."
        machinesPrice.text = "\(machinesPriceFormatted!) cr."
        narcoticsPrice.text = "\(narcoticsPriceFormatted!) cr."
        robotsPrice.text = "\(robotsPriceFormatted!) cr."
        
        // make prices smaller if long
        let maxCharactersBeforeShrinkingText = 8
        let textSizeToShrinkTo: CGFloat = 13
        
        if waterPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            waterPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            fursPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            foodPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if orePrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            orePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            gamesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            firearmsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicinePrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            medicinePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            machinesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            narcoticsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsPrice.text!.characters.count > maxCharactersBeforeShrinkingText {
            robotsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        
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
        
        // if positive, turn PL labels purple (CONSIDER USING LIGHT GRAY FOR LOSS)
        if (waterPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Water) < galaxy.currentSystem!.waterSell) {
            waterPL.textColor = mainPurple
        } else {
            waterPL.textColor = inactiveGray
        }
        if (fursPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Furs) < galaxy.currentSystem!.fursSell) {
            fursPL.textColor = mainPurple
        } else {
            fursPL.textColor = inactiveGray
        }
        if (foodPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Food) < galaxy.currentSystem!.foodSell) {
            foodPL.textColor = mainPurple
        } else {
            foodPL.textColor = inactiveGray
        }
        if (orePL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Ore) < galaxy.currentSystem!.oreSell) {
            orePL.textColor = mainPurple
        } else {
            orePL.textColor = inactiveGray
        }
        if (gamesPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Games) < galaxy.currentSystem!.gamesSell) {
            gamesPL.textColor = mainPurple
        } else {
            gamesPL.textColor = inactiveGray
        }
        if (firearmsPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Firearms) < galaxy.currentSystem!.firearmsSell) {
            firearmsPL.textColor = mainPurple
        } else {
            firearmsPL.textColor = inactiveGray
        }
        if (medicinePL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Medicine) < galaxy.currentSystem!.medicineSell) {
            medicinePL.textColor = mainPurple
        } else {
            medicinePL.textColor = inactiveGray
        }
        if (machinesPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Machines) < galaxy.currentSystem!.machinesSell) {
            machinesPL.textColor = mainPurple
        } else {
            machinesPL.textColor = inactiveGray
        }
        if (narcoticsPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Narcotics) < galaxy.currentSystem!.narcoticsSell) {
            narcoticsPL.textColor = mainPurple
        } else {
            narcoticsPL.textColor = inactiveGray
        }
        if (robotsPL.text != "--") && (player.commanderShip.getPricePaid(TradeItemType.Robots) < galaxy.currentSystem!.robotsSell) {
            robotsPL.textColor = mainPurple
        } else {
            robotsPL.textColor = inactiveGray
        }
        
        // make PL string smaller if long
        if waterPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            waterPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            fursPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            foodPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if orePL.text!.characters.count > maxCharactersBeforeShrinkingText {
            orePL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            gamesPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            firearmsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicinePL.text!.characters.count > maxCharactersBeforeShrinkingText {
            medicinePL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            machinesPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            narcoticsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            robotsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        
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
