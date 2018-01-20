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
        robotsQty.setTitle("", for: controlState)
        

        //cashLabel.text = "Cash: \(player.credits) cr."
        
        
    }
    
    func readoutPrices() {
        print("buyVC price readout")
        print("  waterBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Water))")
        print("  fursBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Furs))")
        print("  foodBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Food))")
        print("  oreBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Ore))")
        print("  gamesBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Games))")
        print("  firearmsBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Firearms))")
        print("  medicineBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Medicine))")
        print("  machinesBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Machines))")
        print("  narcoticsBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Narcotics))")
        print("  robotsBuy: \(galaxy.currentSystem!.getBuyPrice(TradeItemType.Robots))")
    }
    
    func getPPLString(_ targetSell: Int, currentBuy: Int) -> String {
        let value = targetSell - currentBuy
        var sign: String = ""
        if value > 0 {
            sign = "+"
        } else {
            sign = ""
        }
        
        // format value
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let valueFormatted = numberFormatter.string(from: NSNumber(value: value))!
        
        // append sign and return
        let string = "\(sign)\(valueFormatted) cr."
        //print(string)
        return string
    }
    
    
    @IBAction func buyWaterTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.water != 0 {
            buySellCommodity = TradeItemType.Water
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFursTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.furs != 0 {
            buySellCommodity = TradeItemType.Furs
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFoodTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.food != 0 {
            buySellCommodity = TradeItemType.Food
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyOreTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.ore != 0 {
            buySellCommodity = TradeItemType.Ore
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyGamesTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.games != 0 {
            buySellCommodity = TradeItemType.Games
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyFirearmsTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.firearms != 0 {
            buySellCommodity = TradeItemType.Firearms
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyMedicineTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.medicine != 0 {
            buySellCommodity = TradeItemType.Medicine
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyMachinesTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.machines != 0 {
            buySellCommodity = TradeItemType.Machines
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyNarcoticsTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.narcotics != 0 {
            buySellCommodity = TradeItemType.Narcotics
            performSegue(withIdentifier: "buyPicker", sender: sender)
        }
    }
    
    @IBAction func buyRobotsTapped(_ sender: AnyObject) {
        if galaxy.currentSystem!.robots != 0 {
            buySellCommodity = TradeItemType.Robots
            performSegue(withIdentifier: "buyPicker", sender: sender)
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
    
    @IBAction func systemCycleForward(_ sender: AnyObject) {
        galaxy.cycleForward()
        //updateUIInitial()
        updateUI()
    }
    
    
    
    func buyModalDidFinish(_ controller: BuyModalVC) {                    // DELEGATE FUNCTION
        //updateUIInitial()
        updateUI()
    }
    
    
    func updateUI2() {   // called initially, also when transaction completed
        
        // set target system label
        
        // redraw baysCashBox
        baysCashBox.redrawSelf()
        
        let controlState = UIControlState()
        
        // set quantities
        waterQty.setTitle("\(galaxy.currentSystem!.water)", for: controlState)
        //waterQty.frame = CGRectMake(0.0,0.0,100,100)
        //self.view.addSubview(waterQty)
        
        
        fursQty.setTitle("\(galaxy.currentSystem!.furs)", for: controlState)
        foodQty.setTitle("\(galaxy.currentSystem!.food)", for: controlState)
        oreQty.setTitle("\(galaxy.currentSystem!.ore)", for: controlState)
        gamesQty.setTitle("\(galaxy.currentSystem!.games)", for: controlState)
        firearmsQty.setTitle("\(galaxy.currentSystem!.firearms)", for: controlState)
        medicineQty.setTitle("\(galaxy.currentSystem!.medicine)", for: controlState)
        machinesQty.setTitle("\(galaxy.currentSystem!.machines)", for: controlState)
        narcoticsQty.setTitle("\(galaxy.currentSystem!.narcotics)", for: controlState)
        robotsQty.setTitle("\(galaxy.currentSystem!.robots)", for: controlState)
        
        
        
        // set target system & description string
        targetSystemLabel.text = "Target system: \(galaxy.targetSystem!.name)"
        targetSystemDescriptionLabel.text = galaxy.getShortDescriptorString(galaxy.targetSystem!)
        
    }
    
    func updateUI() {    // things that don't change with buying and selling; only called once
        updateUI2()
        
        // set formatted prices
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let waterPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.waterBuy))!
        let fursPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.fursBuy))!
        let foodPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.foodBuy))!
        let orePriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.oreBuy))!
        let gamesPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.gamesBuy))!
        let firearmsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.firearmsBuy))!
        let medicinePriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.medicineBuy))!
        let machinesPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.machinesBuy))!
        let narcoticsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.narcoticsBuy))!
        let robotsPriceFormatted = numberFormatter.string(from: NSNumber(value: galaxy.currentSystem!.robotsBuy))!
        
        
        // set prices
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
            waterQty.isEnabled = false
            waterMaxButton.isEnabled = false
            waterPrice.text = "not sold"
            waterPrice.textColor = inactiveGray
            waterProjectedPL.text = "--"
            
        } else {
            waterQty.isEnabled = true
            waterMaxButton.isEnabled = true
            waterPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.fursBuy == 0 {
            //fursQty.setTitle("", forState: controlState)
            fursQty.isEnabled = false
            fursMaxButton.isEnabled = false
            fursPrice.text = "not sold"
            fursPrice.textColor = inactiveGray
            fursProjectedPL.text = "--"
        } else {
            fursQty.isEnabled = true
            fursMaxButton.isEnabled = true
            fursPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.foodBuy == 0 {
            //foodQty.setTitle("", forState: controlState)
            foodQty.isEnabled = false
            foodMaxButton.isEnabled = false
            foodPrice.text = "not sold"
            foodPrice.textColor = inactiveGray
            foodProjectedPL.text = "--"
        } else {
            fursQty.isEnabled = true
            fursMaxButton.isEnabled = true
            fursPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.oreBuy == 0 {
            //oreQty.setTitle("", forState: controlState)
            oreQty.isEnabled = false
            oreMaxButton.isEnabled = false
            orePrice.text = "not sold"
            orePrice.textColor = inactiveGray
            oreProjectedPL.text = "--"
        } else {
            oreQty.isEnabled = true
            oreMaxButton.isEnabled = true
            orePrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.gamesBuy == 0 {
            //gamesQty.setTitle("", forState: controlState)
            gamesQty.isEnabled = false
            gamesMaxButton.isEnabled = false
            gamesPrice.text = "not sold"
            gamesPrice.textColor = inactiveGray
            gamesProjectedPL.text = "--"
        } else {
            gamesQty.isEnabled = true
            gamesMaxButton.isEnabled = true
            gamesPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.firearmsBuy == 0 {
            //firearmsQty.setTitle("", forState: controlState)
            firearmsQty.isEnabled = false
            firearmsMaxButton.isEnabled = false
            firearmsPrice.text = "not sold"
            firearmsPrice.textColor = inactiveGray
            firearmsProjectedPL.text = "--"
        } else {
            firearmsQty.isEnabled = true
            firearmsMaxButton.isEnabled = true
            firearmsPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.medicineBuy == 0 {
            //medicineQty.setTitle("", forState: controlState)
            medicineQty.isEnabled = false
            medicineMaxButton.isEnabled = false
            medicinePrice.text = "not sold"
            medicinePrice.textColor = inactiveGray
            medicineProjectedPL.text = "--"
        } else {
            medicineQty.isEnabled = true
            medicineMaxButton.isEnabled = true
            medicinePrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.machinesBuy == 0 {
            //machinesQty.setTitle("", forState: controlState)
            machinesQty.isEnabled = false
            machinesMaxButton.isEnabled = false
            machinesPrice.text = "not sold"
            machinesPrice.textColor = inactiveGray
            machinesProjectedPL.text = "--"
        } else {
            machinesQty.isEnabled = true
            machinesMaxButton.isEnabled = true
            machinesPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.narcoticsBuy == 0 {
            //narcoticsQty.setTitle("", forState: controlState)
            narcoticsQty.isEnabled = false
            narcoticsMaxButton.isEnabled = false
            narcoticsPrice.text = "not sold"
            narcoticsPrice.textColor = inactiveGray
            narcoticsProjectedPL.text = "--"
        } else {
            narcoticsQty.isEnabled = true
            narcoticsMaxButton.isEnabled = true
            narcoticsPrice.textColor = UIColor.black
        }
        if galaxy.currentSystem!.robotsBuy == 0 {
            //robotsQty.setTitle("", forState: controlState)
            robotsQty.isEnabled = false
            robotsMaxButton.isEnabled = false
            robotsPrice.text = "not sold"
            robotsPrice.textColor = inactiveGray
            robotsProjectedPL.text = "--"
        } else {
            robotsQty.isEnabled = true
            robotsMaxButton.isEnabled = true
            robotsPrice.textColor = UIColor.black
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
        if waterProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            waterProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if fursProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            fursProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if foodProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            foodProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if oreProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            oreProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if gamesProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            gamesProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if firearmsProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            firearmsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if medicineProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            medicineProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if machinesProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            machinesProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if narcoticsProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            narcoticsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
        if robotsProjectedPL.text!.count > maxCharactersBeforeShrinkingText {
            robotsProjectedPL.font = UIFont(name: "AvenirNext-DemiBold", size: textSizeToShrinkTo)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // magic required to make delegate work
        if segue.identifier == "buyModal" {
            let modalVC: BuyModalVC = segue.destination as! BuyModalVC
            modalVC.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("buyVC viewWillAppear")
        readoutPrices()
        
        //updateUIInitial()
        updateUI()
        buyAsOpposedToSell = true
        
        // return scroll view to top
        let topScrollPoint = CGPoint(x: 0.0, y: 0.0)
        //let topScrollPoint = CGPoint(x: 0.0, y: 0.0)
        scrollView.setContentOffset(topScrollPoint, animated: false)
        //print("setContentOffset done")
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
    func shouldShrink(_ text: String) -> Bool {
        // true if "not sold"
        if text == "not sold" {
            return true
        }
        
        // true if over limit
        if text.count > maxCharactersBeforeShrinkingText {
            return true
        }
        
        // false otherwise
        return false
    }
    
    func getPPL(_ commodity: TradeItemType) -> Int {
        // avoid red "--"
        if galaxy.currentSystem!.getBuyPrice(commodity) == 0 {
            return 0
        }
        return galaxy.targetSystem!.getSellPrice(commodity) - galaxy.currentSystem!.getBuyPrice(commodity)
    }
    
}


