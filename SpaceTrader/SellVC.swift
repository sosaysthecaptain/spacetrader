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
    @IBOutlet weak var scrollView: UIScrollView!
    
    

    func sellAll(_ commodity: TradeItemType) {
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
    
    @IBAction func sellWater(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Water) != 0 {
            buySellCommodity = TradeItemType.Water
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }
    }
    
    @IBAction func sellFurs(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Furs) != 0 {
            buySellCommodity = TradeItemType.Furs
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellFood(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Food) != 0 {
            buySellCommodity = TradeItemType.Food
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellOre(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Ore) != 0 {
            buySellCommodity = TradeItemType.Ore
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellGames(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Games) != 0 {
            buySellCommodity = TradeItemType.Games
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellFirearms(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Firearms) != 0 {
            buySellCommodity = TradeItemType.Firearms
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }

    @IBAction func sellMedicine(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Medicine) != 0 {
            buySellCommodity = TradeItemType.Medicine
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }

    @IBAction func sellMachines(_ sender: AnyObject) {
        if player.commanderShip.getQuantity(TradeItemType.Machines) != 0 {
            buySellCommodity = TradeItemType.Machines
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellNarcotics(_ sender: AnyObject) {
        // DEBUG
        print("sell narcotics pressed")
        
        if player.commanderShip.getQuantity(TradeItemType.Narcotics) != 0 {
            buySellCommodity = TradeItemType.Narcotics
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    @IBAction func sellRobots(_ sender: AnyObject) {
        // DEBUG
        print("sell robots pressed")
        
        if player.commanderShip.getQuantity(TradeItemType.Robots) != 0 {
            buySellCommodity = TradeItemType.Robots
            //performSegueWithIdentifier("sellModal", sender: sender)
            performSegue(withIdentifier: "sellPicker", sender: sender)
        }

    }
    
    override func viewDidLoad() {
        loadPrices()
        recurringUpdate()
        buyAsOpposedToSell = false    
    }
    
    func readoutPrices() {              // debug
        print("SellVC price readout")
        print("  waterSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Water))")
        print("  fursSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Furs))")
        print("  foodSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Food))")
        print("  oreSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Ore))")
        print("  gamesSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Games))")
        print("  firearmsSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Firearms))")
        print("  medicineSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Medicine))")
        print("  machinesSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Machines))")
        print("  narcoticsSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Narcotics))")
        print("  robotsSell: \(galaxy.currentSystem!.getSellPrice(TradeItemType.Robots))")
    }
    
    
    func recurringUpdate() {
        waterQuantity.setTitle("\(player.commanderShip.getQuantity(.Water))", for: controlState)
        fursQuantity.setTitle("\(player.commanderShip.getQuantity(.Furs))", for: controlState)
        foodQuantity.setTitle("\(player.commanderShip.getQuantity(.Food))", for: controlState)
        oreQuantity.setTitle("\(player.commanderShip.getQuantity(.Ore))", for: controlState)
        gamesQuantity.setTitle("\(player.commanderShip.getQuantity(.Games))", for: controlState)
        firearmsQuantity.setTitle("\(player.commanderShip.getQuantity(.Firearms))", for: controlState)
        medicineQuantity.setTitle("\(player.commanderShip.getQuantity(.Medicine))", for: controlState)
        machinesQuantity.setTitle("\(player.commanderShip.getQuantity(.Machines))", for: controlState)
        narcoticsQuantity.setTitle("\(player.commanderShip.getQuantity(.Narcotics))", for: controlState)
        robotsQuantity.setTitle("\(player.commanderShip.getQuantity(.Robots))", for: controlState)
        
        // redraw baysCashBox
        baysCashBox.redrawSelf()
    }
    
    func loadPrices() {
        // format prices
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let waterPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Water)))!
        let fursPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Furs)))!
        let foodPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Food)))!
        let orePriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Ore)))!
        let gamesPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Games)))!
        let firearmsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Firearms)))!
        let medicinePriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Medicine)))!
        let machinesPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Machines)))!
        let narcoticsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Narcotics)))!
        let robotsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.getSellPrice(TradeItemType.Robots)))!

        
        // display prices with "cr." appended
        waterPrice.text = "\(waterPriceFormatted) cr."
        fursPrice.text = "\(fursPriceFormatted) cr."
        foodPrice.text = "\(foodPriceFormatted) cr."
        orePrice.text = "\(orePriceFormatted) cr."
        gamesPrice.text = "\(gamesPriceFormatted) cr."
        firearmsPrice.text = "\(firearmsPriceFormatted) cr."
        medicinePrice.text = "\(medicinePriceFormatted) cr."
        machinesPrice.text = "\(machinesPriceFormatted) cr."
        narcoticsPrice.text = "\(narcoticsPriceFormatted) cr."
        robotsPrice.text = "\(robotsPriceFormatted) cr."
        
        // make prices smaller if long
        let maxCharactersBeforeShrinkingText = 8
        let textSizeToShrinkTo: CGFloat = 13
        
        if waterPrice.text!.count > maxCharactersBeforeShrinkingText {
            waterPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursPrice.text!.count > maxCharactersBeforeShrinkingText {
            fursPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodPrice.text!.count > maxCharactersBeforeShrinkingText {
            foodPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if orePrice.text!.count > maxCharactersBeforeShrinkingText {
            orePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesPrice.text!.count > maxCharactersBeforeShrinkingText {
            gamesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsPrice.text!.count > maxCharactersBeforeShrinkingText {
            firearmsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicinePrice.text!.count > maxCharactersBeforeShrinkingText {
            medicinePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesPrice.text!.count > maxCharactersBeforeShrinkingText {
            machinesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsPrice.text!.count > maxCharactersBeforeShrinkingText {
            narcoticsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsPrice.text!.count > maxCharactersBeforeShrinkingText {
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
        if waterPL.text!.count > maxCharactersBeforeShrinkingText {
            waterPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursPL.text!.count > maxCharactersBeforeShrinkingText {
            fursPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodPL.text!.count > maxCharactersBeforeShrinkingText {
            foodPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if orePL.text!.count > maxCharactersBeforeShrinkingText {
            orePL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesPL.text!.count > maxCharactersBeforeShrinkingText {
            gamesPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsPL.text!.count > maxCharactersBeforeShrinkingText {
            firearmsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicinePL.text!.count > maxCharactersBeforeShrinkingText {
            medicinePL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesPL.text!.count > maxCharactersBeforeShrinkingText {
            machinesPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsPL.text!.count > maxCharactersBeforeShrinkingText {
            narcoticsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsPL.text!.count > maxCharactersBeforeShrinkingText {
            robotsPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        
        // handle dump buttons
        //print("DUMP DEBUG: narcoticsPriceFormatted: \(narcoticsPriceFormatted)")
        if waterPriceFormatted == "0" {
            waterAllLabel.setTitle("Dump", for: controlState)
            waterAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            waterPrice.text = "no trade"
            waterPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            waterPrice.textColor = inactiveGray
        } else {
            waterAllLabel.setTitle("All", for: controlState)
            waterAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if fursPriceFormatted == "0" {
            fursAllLabel.setTitle("Dump", for: controlState)
            fursAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            fursPrice.text = "no trade"
            fursPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            fursPrice.textColor = inactiveGray
        } else {
            fursAllLabel.setTitle("All", for: controlState)
            fursAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if foodPriceFormatted == "0" {
            foodAllLabel.setTitle("Dump", for: controlState)
            foodAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            foodPrice.text = "no trade"
            foodPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            foodPrice.textColor = inactiveGray
        } else {
            foodAllLabel.setTitle("All", for: controlState)
            foodAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if orePriceFormatted == "0" {
            oreAllLabel.setTitle("Dump", for: controlState)
            oreAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            orePrice.text = "no trade"
            orePrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            orePrice.textColor = inactiveGray
        } else {
            oreAllLabel.setTitle("All", for: controlState)
            oreAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if gamesPriceFormatted == "0" {
            gamesAllLabel.setTitle("Dump", for: controlState)
            gamesAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            gamesPrice.text = "no trade"
            gamesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            gamesPrice.textColor = inactiveGray
        } else {
            gamesAllLabel.setTitle("All", for: controlState)
            gamesAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if firearmsPriceFormatted == "0" {
            print("DEBUG: firearms price is zero")
            firearmsAllLabel.setTitle("Dump", for: controlState)
            firearmsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            firearmsPrice.text = "no trade"
            firearmsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            firearmsPrice.textColor = inactiveGray
        } else {
            print("DEBUG: firearms price is NOT zero")
            firearmsAllLabel.setTitle("All", for: controlState)
            firearmsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if medicinePriceFormatted == "0" {
            medicineAllLabel.setTitle("Dump", for: controlState)
            medicineAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            medicinePrice.text = "no trade"
            medicinePrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            medicinePrice.textColor = inactiveGray
        } else {
            medicineAllLabel.setTitle("All", for: controlState)
            medicineAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if machinesPriceFormatted == "0" {
            machinesAllLabel.setTitle("Dump", for: controlState)
            machinesAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            machinesPrice.text = "no trade"
            machinesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            machinesPrice.textColor = inactiveGray
        } else {
            machinesAllLabel.setTitle("All", for: controlState)
            machinesAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if narcoticsPriceFormatted == "0" {
            narcoticsAllLabel.setTitle("Dump", for: controlState)
            narcoticsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            narcoticsPrice.text = "no trade"
            narcoticsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            narcoticsPrice.textColor = inactiveGray
        } else {
            narcoticsAllLabel.setTitle("All", for: controlState)
            narcoticsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        if robotsPriceFormatted == "0" {
            robotsAllLabel.setTitle("Dump", for: controlState)
            robotsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
            robotsPrice.text = "no trade"
            robotsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
            robotsPrice.textColor = inactiveGray
        } else {
            robotsAllLabel.setTitle("All", for: controlState)
            robotsAllLabel.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        }
        
    }
    
    // this updates quantities when this page becomes active
    override func viewWillAppear(_ animated: Bool) {
        print("sellVC viewWillAppear")
        readoutPrices()
        
        //loadPrices()        // trying this before recurringUpdate
        recurringUpdate()
        buyAsOpposedToSell = false
        loadPrices()
        
//        print("DEBUG*********SELL VC TESTING***************")
//        galaxy.currentSystem = galaxy.planets[52]
//        galaxy.currentSystem!.food = 555
//        print("should say 555 if referential: \(galaxy.planets[52].food)")
        
        // return scroll view to top
        let topScrollPoint = CGPoint(x: 0.0, y: -60.0)
        scrollView.setContentOffset(topScrollPoint, animated: false)
        
        self.viewDidLoad()
    }
    
    func buyModalDidFinish(_ controller: BuyModalVC) {                    // DELEGATE FUNCTION
        recurringUpdate()
        loadPrices()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // magic required to make delegate work
        if segue.identifier == "sellModal" {
            let modalVC: BuyModalVC = segue.destination as! BuyModalVC
            modalVC.delegate = self
        }
    }
}
