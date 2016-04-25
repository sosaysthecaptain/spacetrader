//
//  BuyVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/17/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import UIKit



class BuyVC: UIViewController, BuyModalVCDelegate {

    @IBOutlet weak var waterQty: UIButton!
    @IBOutlet weak var fursQty: UIButton!
    @IBOutlet weak var foodQty: UIButton!
    @IBOutlet weak var oreQty: UIButton!
    @IBOutlet weak var gamesQty: UIButton!
    @IBOutlet weak var firearmsQty: UIButton!
    @IBOutlet weak var medicineQty: UIButton!
    @IBOutlet weak var machinesQty: UIButton!
    @IBOutlet weak var narcoticsQty: UIButton!
    @IBOutlet weak var robotsQty: UIButton!

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

    @IBOutlet weak var waterProjectedPL: UILabel!
    @IBOutlet weak var fursProjectedPL: UILabel!
    @IBOutlet weak var foodProjectedPL: UILabel!
    @IBOutlet weak var oreProjectedPL: UILabel!
    @IBOutlet weak var gamesProjectedPL: UILabel!
    @IBOutlet weak var firearmsProjectedPL: UILabel!
    @IBOutlet weak var medicineProjectedPL: UILabel!
    @IBOutlet weak var machinesProjectedPL: UILabel!
    @IBOutlet weak var narcoticsProjectedPL: UILabel!
    @IBOutlet weak var robotsProjectedPL: UILabel!
    
    
    @IBOutlet weak var targetSystemLabel: StandardLabel!
    @IBOutlet weak var targetSystemDescriptionLabel: SmallNotBold!
    
    //@IBOutlet weak var targetSystemLabel: UILabel!
    //@IBOutlet weak var targetSystemDescriptionLabel: UILabel!
    //@IBOutlet weak var baysLabel: UILabel!
    //@IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var baysCashBox: BaysCashBoxView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var waterMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var fursMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var foodMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var oreMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var gamesMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var firearmsMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var medicineMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var machinesMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var narcoticsMaxButton: PurpleButtonVanishes!
    @IBOutlet weak var robotsMaxButton: PurpleButtonVanishes!
    
    let maxCharactersBeforeShrinkingText = 8
    let textSizeToShrinkTo: CGFloat = 13
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controlState = UIControlState()
        buyAsOpposedToSell = true
        
        updateUI()


        
        
        // experiment
        robotsQty.setTitle("", forState: controlState)
        

        //cashLabel.text = "Cash: \(player.credits) cr."
        
        
    }
    
    func getPPLString(targetSell: Int, currentBuy: Int) -> String {
        let value = targetSell - currentBuy
        var sign: String = ""
        if value > 0 {
            sign = "+"
        } else {
            sign = ""
        }
        
        // format value
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        let valueFormatted = numberFormatter.stringFromNumber(value)
        
        // append sign and return
        let string = "\(sign)\(valueFormatted!) cr."
        //print(string)
        return string
    }
    
    
    @IBAction func buyWaterTapped(sender: AnyObject) {
        if galaxy.currentSystem!.water != 0 {
            buySellCommodity = TradeItemType.Water
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFursTapped(sender: AnyObject) {
        if galaxy.currentSystem!.furs != 0 {
            buySellCommodity = TradeItemType.Furs
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFoodTapped(sender: AnyObject) {
        if galaxy.currentSystem!.food != 0 {
            buySellCommodity = TradeItemType.Food
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyOreTapped(sender: AnyObject) {
        if galaxy.currentSystem!.ore != 0 {
            buySellCommodity = TradeItemType.Ore
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyGamesTapped(sender: AnyObject) {
        if galaxy.currentSystem!.games != 0 {
            buySellCommodity = TradeItemType.Games
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFirearmsTapped(sender: AnyObject) {
        if galaxy.currentSystem!.firearms != 0 {
            buySellCommodity = TradeItemType.Firearms
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyMedicineTapped(sender: AnyObject) {
        if galaxy.currentSystem!.medicine != 0 {
            buySellCommodity = TradeItemType.Medicine
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyMachinesTapped(sender: AnyObject) {
        if galaxy.currentSystem!.machines != 0 {
            buySellCommodity = TradeItemType.Machines
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyNarcoticsTapped(sender: AnyObject) {
        if galaxy.currentSystem!.narcotics != 0 {
            buySellCommodity = TradeItemType.Narcotics
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyRobotsTapped(sender: AnyObject) {
        if galaxy.currentSystem!.robots != 0 {
            buySellCommodity = TradeItemType.Robots
            performSegueWithIdentifier("buyPicker", sender: sender)
        }
    }
    
    // Max functions
    
    @IBAction func waterMax() {
        if galaxy.currentSystem!.water > 0 {
            player.buy(TradeItemType.Water, quantity: player.getMax(TradeItemType.Water))
            updateUI()
        }
    }
    
    @IBAction func fursMax() {
        if galaxy.currentSystem!.furs > 0 {
            player.buy(TradeItemType.Furs, quantity: player.getMax(TradeItemType.Furs))
            updateUI()
        }
    }
    
    @IBAction func foodMax() {
        if galaxy.currentSystem!.food > 0 {
            player.buy(TradeItemType.Food, quantity: player.getMax(TradeItemType.Food))
            updateUI()
        }
    }
    
    @IBAction func oreMax() {
        if galaxy.currentSystem!.ore > 0 {
            player.buy(TradeItemType.Ore, quantity: player.getMax(TradeItemType.Ore))
            updateUI()
        }
    }
    
    @IBAction func gamesMax() {
        if galaxy.currentSystem!.games > 0 {
            player.buy(TradeItemType.Games, quantity: player.getMax(TradeItemType.Games))
            updateUI()
        }
    }
    
    @IBAction func firearmsMax() {
        if galaxy.currentSystem!.firearms > 0 {
            player.buy(TradeItemType.Firearms, quantity: player.getMax(TradeItemType.Firearms))
            updateUI()
        }
    }
    
    @IBAction func medicineMax() {
        if galaxy.currentSystem!.medicine > 0 {
            player.buy(TradeItemType.Medicine, quantity: player.getMax(TradeItemType.Medicine))
            updateUI()
        }
    }
    
    @IBAction func machinesMax() {
        if galaxy.currentSystem!.machines > 0 {
            player.buy(TradeItemType.Machines, quantity: player.getMax(TradeItemType.Machines))
            updateUI()
        }
    }
    
    @IBAction func narcoticsMax() {
        if galaxy.currentSystem!.narcotics > 0 {
            player.buy(TradeItemType.Narcotics, quantity: player.getMax(TradeItemType.Narcotics))
            updateUI()
        }
    }
    
    @IBAction func robotsMax() {
        if galaxy.currentSystem!.robots > 0 {
            player.buy(TradeItemType.Robots, quantity: player.getMax(TradeItemType.Robots))
            updateUI()
        }
    }
    
    
    @IBAction func systemCycleBack() {
        galaxy.cycleBackward()
        //updateUIInitial()
        updateUI()
        
    }
    
    @IBAction func systemCycleForward(sender: AnyObject) {
        galaxy.cycleForward()
        //updateUIInitial()
        updateUI()
    }
    
    
    
    func buyModalDidFinish(controller: BuyModalVC) {                    // DELEGATE FUNCTION
        //updateUIInitial()
        updateUI()
    }
    
    
    func updateUI2() {   // called initially, also when transaction completed
        
        // set target system label
        
        // redraw baysCashBox
        baysCashBox.redrawSelf()
        
        let controlState = UIControlState()
        
        // set quantities
        waterQty.setTitle("\(galaxy.currentSystem!.water)", forState: controlState)
        //waterQty.frame = CGRectMake(0.0,0.0,100,100)
        //self.view.addSubview(waterQty)
        
        
        fursQty.setTitle("\(galaxy.currentSystem!.furs)", forState: controlState)
        foodQty.setTitle("\(galaxy.currentSystem!.food)", forState: controlState)
        oreQty.setTitle("\(galaxy.currentSystem!.ore)", forState: controlState)
        gamesQty.setTitle("\(galaxy.currentSystem!.games)", forState: controlState)
        firearmsQty.setTitle("\(galaxy.currentSystem!.firearms)", forState: controlState)
        medicineQty.setTitle("\(galaxy.currentSystem!.medicine)", forState: controlState)
        machinesQty.setTitle("\(galaxy.currentSystem!.machines)", forState: controlState)
        narcoticsQty.setTitle("\(galaxy.currentSystem!.narcotics)", forState: controlState)
        robotsQty.setTitle("\(galaxy.currentSystem!.robots)", forState: controlState)
        
        
        
        // set target system & description string
        targetSystemLabel.text = "Target system: \(galaxy.targetSystem!.name)"
        targetSystemDescriptionLabel.text = galaxy.getShortDescriptorString(galaxy.targetSystem!)
        
    }
    
    func updateUI() {    // things that don't change with buying and selling; only called once
        updateUI2()
        
        // set formatted prices
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        let waterPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.waterBuy)
        let fursPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.fursBuy)
        let foodPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.foodBuy)
        let orePriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.oreBuy)
        let gamesPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.gamesBuy)
        let firearmsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.firearmsBuy)
        let medicinePriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.medicineBuy)
        let machinesPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.machinesBuy)
        let narcoticsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.narcoticsBuy)
        let robotsPriceFormatted = numberFormatter.stringFromNumber(galaxy.currentSystem!.robotsBuy)
        
        
        // set prices
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
        
        
        // set P/L, with formatting info
        waterProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.waterSell, currentBuy: galaxy.currentSystem!.waterBuy))"
        fursProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.fursSell, currentBuy: galaxy.currentSystem!.fursBuy))"
        foodProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.foodSell, currentBuy: galaxy.currentSystem!.foodBuy))"
        oreProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.oreSell, currentBuy: galaxy.currentSystem!.oreBuy))"
        gamesProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.gamesSell, currentBuy: galaxy.currentSystem!.gamesBuy))"
        firearmsProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.firearmsSell, currentBuy: galaxy.currentSystem!.firearmsBuy))"
        medicineProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.medicineSell, currentBuy: galaxy.currentSystem!.medicineBuy))"
        machinesProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.machinesSell, currentBuy: galaxy.currentSystem!.machinesBuy))"
        narcoticsProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.narcoticsSell, currentBuy: galaxy.currentSystem!.narcoticsBuy))"
        robotsProjectedPL.text = "\(getPPLString(galaxy.targetSystem!.robotsSell, currentBuy: galaxy.currentSystem!.robotsBuy))"
        
 
        // P/L: handle commodities not traded in target system
        if galaxy.targetSystem!.waterSell == 0 {
            
            waterProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.fursSell == 0 {
            fursProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.foodSell == 0 {
            foodProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.oreSell == 0 {
            oreProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.gamesSell == 0 {
            gamesProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.firearmsSell == 0 {
            firearmsProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.medicineSell == 0 {
            medicineProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.machinesSell == 0 {
            machinesProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.narcoticsSell == 0 {
            narcoticsProjectedPL.text = "--"
        }
        if galaxy.targetSystem!.robotsSell == 0 {
            robotsProjectedPL.text = "--"
        }
        
        

        // handle things not traded. Do so if buy price is zero.
        if galaxy.currentSystem!.waterBuy == 0 {
            
            //waterQty.setTitle("", forState: controlState)
            waterQty.enabled = false
            waterMaxButton.enabled = false
            waterPrice.text = "not sold"
            waterPrice.textColor = inactiveGray
            waterProjectedPL.text = "--"
            
        }
        if galaxy.currentSystem!.fursBuy == 0 {
            //fursQty.setTitle("", forState: controlState)
            fursQty.enabled = false
            fursMaxButton.enabled = false
            fursPrice.text = "not sold"
            fursPrice.textColor = inactiveGray
            fursProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.foodBuy == 0 {
            //foodQty.setTitle("", forState: controlState)
            foodQty.enabled = false
            foodMaxButton.enabled = false
            foodPrice.text = "not sold"
            foodPrice.textColor = inactiveGray
            foodProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.oreBuy == 0 {
            //oreQty.setTitle("", forState: controlState)
            oreQty.enabled = false
            oreMaxButton.enabled = false
            orePrice.text = "not sold"
            orePrice.textColor = inactiveGray
            oreProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.gamesBuy == 0 {
            //gamesQty.setTitle("", forState: controlState)
            gamesQty.enabled = false
            gamesMaxButton.enabled = false
            gamesPrice.text = "not sold"
            gamesPrice.textColor = inactiveGray
            gamesProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.firearmsBuy == 0 {
            //firearmsQty.setTitle("", forState: controlState)
            firearmsQty.enabled = false
            firearmsMaxButton.enabled = false
            firearmsPrice.text = "not sold"
            firearmsPrice.textColor = inactiveGray
            firearmsProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.medicineBuy == 0 {
            //medicineQty.setTitle("", forState: controlState)
            medicineQty.enabled = false
            medicineMaxButton.enabled = false
            medicinePrice.text = "not sold"
            medicinePrice.textColor = inactiveGray
            medicineProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.machinesBuy == 0 {
            //machinesQty.setTitle("", forState: controlState)
            machinesQty.enabled = false
            machinesMaxButton.enabled = false
            machinesPrice.text = "not sold"
            machinesPrice.textColor = inactiveGray
            machinesProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.narcoticsBuy == 0 {
            //narcoticsQty.setTitle("", forState: controlState)
            narcoticsQty.enabled = false
            narcoticsMaxButton.enabled = false
            narcoticsPrice.text = "not sold"
            narcoticsPrice.textColor = inactiveGray
            narcoticsProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.robotsBuy == 0 {
            //robotsQty.setTitle("", forState: controlState)
            robotsQty.enabled = false
            robotsMaxButton.enabled = false
            robotsPrice.text = "not sold"
            robotsPrice.textColor = inactiveGray
            robotsProjectedPL.text = "--"
        }
        
        // shrink price string if too long
        if shouldShrink(waterPrice.text!) {
            waterPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(fursPrice.text!) {
            fursPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(foodPrice.text!) {
            foodPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(orePrice.text!) {
            orePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(gamesPrice.text!) {
            gamesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(firearmsPrice.text!) {
            firearmsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(medicinePrice.text!) {
            medicinePrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(machinesPrice.text!) {
            machinesPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(narcoticsPrice.text!) {
            narcoticsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if shouldShrink(robotsPrice.text!) {
            robotsPrice.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }

        
        highlightProfitOpportunities()
        
        // shrink P/L label if too long
        if waterProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            waterProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            fursProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            foodProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if oreProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            oreProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            gamesProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            firearmsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicineProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            medicineProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            machinesProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            narcoticsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsProjectedPL.text!.characters.count > maxCharactersBeforeShrinkingText {
            robotsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // magic required to make delegate work
        if segue.identifier == "buyModal" {
            let modalVC: BuyModalVC = segue.destinationViewController as! BuyModalVC
            modalVC.delegate = self
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //updateUIInitial()
        updateUI()
        buyAsOpposedToSell = true
        
        // return scroll view to top
        let topScrollPoint = CGPointMake(0.0, -60.0)
        scrollView.setContentOffset(topScrollPoint, animated: false)
    }
   
    // turns profit opportunity labels purple, losses gray
    func highlightProfitOpportunities() {
        let profitColor = mainPurple
        let lossColor = inactiveGray
        
        if getPPL(TradeItemType.Water) > 0 {
            waterProjectedPL.textColor = profitColor
        } else {
            waterProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Furs) > 0 {
            fursProjectedPL.textColor = mainPurple
        } else {
            fursProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Food) > 0 {
            foodProjectedPL.textColor = mainPurple
        } else {
            foodProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Ore) > 0 {
            oreProjectedPL.textColor = mainPurple
        } else {
            oreProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Games) > 0 {
            gamesProjectedPL.textColor = mainPurple
        } else {
            gamesProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Firearms) > 0 {
            firearmsProjectedPL.textColor = mainPurple
        } else {
            firearmsProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Medicine) > 0 {
            medicineProjectedPL.textColor = mainPurple
        } else {
            medicineProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Machines) > 0 {
            machinesProjectedPL.textColor = mainPurple
        } else {
            machinesProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Narcotics) > 0 {
            narcoticsProjectedPL.textColor = mainPurple
        } else {
            narcoticsProjectedPL.textColor = lossColor
        }
        if getPPL(TradeItemType.Robots) > 0 {
            robotsProjectedPL.textColor = mainPurple
        } else {
            robotsProjectedPL.textColor = lossColor
        }
    }
    
    // returns true if text should be shrunk to fit the P/L column, false otherwise
    func shouldShrink(text: String) -> Bool {
        // true if "not sold"
        if text == "not sold" {
            return true
        }
        
        // true if over limit
        if text.characters.count > maxCharactersBeforeShrinkingText {
            return true
        }
        
        // false otherwise
        return false
    }
    
    func getPPL(commodity: TradeItemType) -> Int {
        // avoid red "--"
        if galaxy.currentSystem!.getBuyPrice(commodity) == 0 {
            return 0
        }
        return galaxy.targetSystem!.getSellPrice(commodity) - galaxy.currentSystem!.getBuyPrice(commodity)
    }
    
}


