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
    
    
    @IBOutlet weak var targetSystemLabel: UILabel!
    @IBOutlet weak var targetSystemDescriptionLabel: UILabel!
    @IBOutlet weak var baysLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    @IBOutlet weak var waterMaxButton: CustomButton!
    @IBOutlet weak var fursMaxButton: CustomButton!
    @IBOutlet weak var foodMaxButton: CustomButton!
    @IBOutlet weak var oreMaxButton: CustomButton!
    @IBOutlet weak var gamesMaxButton: CustomButton!
    @IBOutlet weak var firearmsMaxButton: CustomButton!
    @IBOutlet weak var medicineMaxButton: CustomButton!
    @IBOutlet weak var machinesMaxButton: CustomButton!
    @IBOutlet weak var narcoticsMaxButton: CustomButton!
    @IBOutlet weak var robotsMaxButton: CustomButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controlState = UIControlState()
        buyAsOpposedToSell = true

        // DUMMY DATA
//        currentSystem.water = 20
//        currentSystem.furs = 1
//        currentSystem.food = 7
//        currentSystem.ore = 57
//        currentSystem.games = 12
//        currentSystem.firearms = 38
//        currentSystem.robots = 1            // REMOVE
//        
//        currentSystem.waterBuy = 37
//        currentSystem.fursBuy = 274
//        currentSystem.foodBuy = 108
//        currentSystem.oreBuy = 397
//        currentSystem.gamesBuy = 158
//        currentSystem.firearmsBuy = 1101
//        currentSystem.robotsBuy = 50        // REMOVE
        
//        targetSystem.waterSell = 45
//        targetSystem.fursSell = 290
//        targetSystem.foodSell = 0
//        targetSystem.oreSell = 441
//        targetSystem.gamesSell = 178
//        targetSystem.firearmsSell = 752
        
        systemsInRange.append(StarSystem(
            name: "Tarchannen",
            techLevel: TechLevelType.techLevel2,
            politics: PoliticsType.confederacy,
            status: StatusType.none,
            xCoord: 5,
            yCoord: 5,
            specialResources: SpecialResourcesType.none,
            size: SizeType.Small))
        
        systemsInRange.append(StarSystem(
            name: "Meridian",
            techLevel: TechLevelType.techLevel7,
            politics: PoliticsType.technocracy,
            status: StatusType.none,
            xCoord: 6,
            yCoord: 6,
            specialResources: SpecialResourcesType.none,
            size: SizeType.Tiny))
        // END DUMMY DATA
        
        updateUI()


        
        
        // experiment
        robotsQty.setTitle("", forState: controlState)
        

        
        // fill out info at the bottom
        
        targetSystemLabel.text = "Target system: \(galaxy.targetSystem!.name)"
        cashLabel.text = "Cash: \(player.credits) cr."
        
        
    }
    
    func getPPLString(targetSell: Int, currentBuy: Int) -> String {
        let value = targetSell - currentBuy
        var sign: String = ""
        if value > 0 {
            sign = "+"
        } else {
            sign = ""
        }
        let string = "\(sign)\(value) cr."
        //print(string)
        return string
    }
    
    
    @IBAction func buyWaterTapped(sender: AnyObject) {
        //print("buy water tapped, sender side")
        buySellCommodity = TradeItemType.Water
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyFursTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Furs
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyFoodTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Food
        buyAsOpposedToSell = true
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyOreTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Ore
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyGamesTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Games
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyFirearmsTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Firearms
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyMedicineTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Medicine
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyMachinesTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Machines
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyNarcoticsTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Narcotics
        performSegueWithIdentifier("buyModal", sender: sender)
    }
    
    @IBAction func buyRobotsTapped(sender: AnyObject) {
        buySellCommodity = TradeItemType.Robots
        performSegueWithIdentifier("buyModal", sender: sender)
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
        // ISSUE: should display positive P/L numbers in smaller font. Need to learn how to change font size of label programmatically
        
        targetSystemLabel.text = "Target system: \(galaxy.targetSystem!.name)"
        baysLabel.text = "Bays: \(player.commanderShip.baysFilled)/\(player.commanderShip.cargoBays)"    // FIX
        cashLabel.text = "Cash: \(player.credits) cr."
        
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
        
      
        
        // set description string
        targetSystemDescriptionLabel.text = galaxy.getShortDescriptorString(galaxy.targetSystem!)
        
    }
    
    func updateUI() {    // things that don't change with buying and selling; only called once
        updateUI2()
        
        // set prices
        waterPrice.text = "\(galaxy.currentSystem!.waterBuy) cr."
        fursPrice.text = "\(galaxy.currentSystem!.fursBuy) cr."
        foodPrice.text = "\(galaxy.currentSystem!.foodBuy) cr."
        orePrice.text = "\(galaxy.currentSystem!.oreBuy) cr."
        gamesPrice.text = "\(galaxy.currentSystem!.gamesBuy) cr."
        firearmsPrice.text = "\(galaxy.currentSystem!.firearmsBuy) cr."
        medicinePrice.text = "\(galaxy.currentSystem!.medicineBuy) cr."
        machinesPrice.text = "\(galaxy.currentSystem!.machinesBuy) cr."
        narcoticsPrice.text = "\(galaxy.currentSystem!.narcoticsBuy) cr."
        robotsPrice.text = "\(galaxy.currentSystem!.robotsBuy) cr."
        
        // set P/L
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
            waterProjectedPL.text = "--"
            
        }
        if galaxy.currentSystem!.fursBuy == 0 {
            //fursQty.setTitle("", forState: controlState)
            fursQty.enabled = false
            fursMaxButton.enabled = false
            fursPrice.text = "not sold"
            fursProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.foodBuy == 0 {
            //foodQty.setTitle("", forState: controlState)
            foodQty.enabled = false
            foodMaxButton.enabled = false
            foodPrice.text = "not sold"
            foodProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.oreBuy == 0 {
            //oreQty.setTitle("", forState: controlState)
            oreQty.enabled = false
            oreMaxButton.enabled = false
            orePrice.text = "not sold"
            oreProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.gamesBuy == 0 {
            //gamesQty.setTitle("", forState: controlState)
            gamesQty.enabled = false
            gamesMaxButton.enabled = false
            gamesPrice.text = "not sold"
            gamesProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.firearmsBuy == 0 {
            //firearmsQty.setTitle("", forState: controlState)
            firearmsQty.enabled = false
            firearmsMaxButton.enabled = false
            firearmsPrice.text = "not sold"
            firearmsProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.medicineBuy == 0 {
            //medicineQty.setTitle("", forState: controlState)
            medicineQty.enabled = false
            medicineMaxButton.enabled = false
            medicinePrice.text = "not sold"
            medicineProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.machinesBuy == 0 {
            //machinesQty.setTitle("", forState: controlState)
            machinesQty.enabled = false
            machinesMaxButton.enabled = false
            machinesPrice.text = "not sold"
            machinesProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.narcoticsBuy == 0 {
            //narcoticsQty.setTitle("", forState: controlState)
            narcoticsQty.enabled = false
            narcoticsMaxButton.enabled = false
            narcoticsPrice.text = "not sold"
            narcoticsProjectedPL.text = "--"
        }
        if galaxy.currentSystem!.robotsBuy == 0 {
            //robotsQty.setTitle("", forState: controlState)
            robotsQty.enabled = false
            robotsMaxButton.enabled = false
            robotsPrice.text = "not sold"
            robotsProjectedPL.text = "--"
        }
        
        highlightProfitOpportunities()
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
    }
   
    // PROBABLY USE DIFFERENT HIGHLIGHTING SCHEME
    func highlightProfitOpportunities() {
        if getPPL(TradeItemType.Water) > 0 {
            waterProjectedPL.textColor = UIColor.redColor()
        } else {
            waterProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Furs) > 0 {
            fursProjectedPL.textColor = UIColor.redColor()
        } else {
            fursProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Food) > 0 {
            foodProjectedPL.textColor = UIColor.redColor()
        } else {
            foodProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Ore) > 0 {
            oreProjectedPL.textColor = UIColor.redColor()
        } else {
            oreProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Games) > 0 {
            gamesProjectedPL.textColor = UIColor.redColor()
        } else {
            gamesProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Firearms) > 0 {
            firearmsProjectedPL.textColor = UIColor.redColor()
        } else {
            firearmsProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Medicine) > 0 {
            medicineProjectedPL.textColor = UIColor.redColor()
        } else {
            medicineProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Machines) > 0 {
            machinesProjectedPL.textColor = UIColor.redColor()
        } else {
            machinesProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Narcotics) > 0 {
            narcoticsProjectedPL.textColor = UIColor.redColor()
        } else {
            narcoticsProjectedPL.textColor = UIColor.blackColor()
        }
        if getPPL(TradeItemType.Robots) > 0 {
            robotsProjectedPL.textColor = UIColor.redColor()
        } else {
            robotsProjectedPL.textColor = UIColor.blackColor()
        }
    }
    
    func getPPL(commodity: TradeItemType) -> Int {
        // avoid red "--"
        if galaxy.currentSystem!.getBuyPrice(commodity) == 0 {
            return 0
        }
        return galaxy.targetSystem!.getSellPrice(commodity) - galaxy.currentSystem!.getBuyPrice(commodity)
    }
    
}


