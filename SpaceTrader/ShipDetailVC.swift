//
//  ShipDetailVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/23/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit


class ShipDetailVC: UIViewController {

    var ship: String!
    var typeOfShip: ShipType!
    var prototypeShip: SpaceShip!
    
    var price: Int = 0
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var cargoLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var hullLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    @IBOutlet weak var shieldLabel: UILabel!
    @IBOutlet weak var gadgetLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var buyButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVars()
        
        setData()
        
        // handle not for sale
        // handle player can't afford
    }
    
    @IBAction func buy(sender: AnyObject) {
        // HANDLE TRIBBLES
        
        // check if enough money
        if player.credits < price {
            let title = "Not Enough Money"
            let message = "You do not have enough money to buy this ship."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // player can afford ship
            // escape pod?
            if player.escapePod && (player.credits >= (price + 200)) {
                let title = "Transfer Escape Pod"
                let message = "I'll transfer your escape pod to your new ship for 200 credits."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Do it!", style: UIAlertActionStyle.Default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                    self.buyNewShip(true)
                }))
                alertController.addAction(UIAlertAction(title: "No thanks", style: UIAlertActionStyle.Default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.buyNewShip(false)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                buyNewShip(false)
            }

        }
        
        // alert asking of user wants to buy
    }
    
    
    func setData() {
        
        switch typeOfShip! {
            case ShipType.Flea:
                image.image = UIImage(named: "ship0")
            case ShipType.Gnat:
                image.image = UIImage(named: "ship1")
            case ShipType.Firefly:
                image.image = UIImage(named: "ship2")
            case ShipType.Mosquito:
                image.image = UIImage(named: "ship3")
            case ShipType.Bumblebee:
                image.image = UIImage(named: "ship4")
            case ShipType.Beetle:
                image.image = UIImage(named: "ship5")
            case ShipType.Hornet:
                image.image = UIImage(named: "ship6")
            case ShipType.Grasshopper:
                image.image = UIImage(named: "ship7")
            case ShipType.Termite:
                image.image = UIImage(named: "ship8")
            case ShipType.Wasp:
                image.image = UIImage(named: "ship9")
            default:
                print("error")
        }
        
        nameLabel.text = prototypeShip.name
        sizeLabel.text = prototypeShip.size
        cargoLabel.text = "\(prototypeShip.cargoBays)"
        rangeLabel.text = "\(prototypeShip.fuelTanks) parsecs"
        hullLabel.text = "\(prototypeShip.hullStrength)"
        weaponLabel.text = "\(prototypeShip.weaponSlots)"
        shieldLabel.text = "\(prototypeShip.shieldSlots)"
        gadgetLabel.text = "\(prototypeShip.gadgetSlots)"
        crewLabel.text = "\(prototypeShip.crewQuarters)"
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let priceFormatted = numberFormatter.stringFromNumber(price)
        priceLabel.text = "\(priceFormatted!) credits"
        
        let controlState = UIControlState()
        buyButton.setTitle("Buy \(ship)", forState: controlState)
        
        // disable when not available
        let currentSystemTechLevel = galaxy.currentSystem!.techLevelInt
        let shipTechLevelInt = getTechLevelInt(prototypeShip.minTechLevel)
        
        if currentSystemTechLevel < shipTechLevelInt {
            priceLabel.text = "not sold"
            buyButton.enabled = false
        }
        
        // handle "got one"
        if typeOfShip == player.commanderShip.type {
            priceLabel.text = "got one"
            buyButton.enabled = false
        }
        
    }
    
    func initializeVars() {
        prototypeShip = SpaceShip(type: typeOfShip, IFFStatus: IFFStatusType.Player)
        
        price = prototypeShip.price
        price -= player.commanderShip.value
    }
    
    func buyNewShip(transferEscapePod: Bool) {
        // determine if special equipment on board
        var specialEquipment: Bool = false
        let morgansLaser = player.commanderShip.getMorgansLaserStatus()
        let fuelCompactor = player.commanderShip.getFuelCompactorStatus()
        let lightningShield = player.commanderShip.getLightningShieldStatus()
        
        if morgansLaser || fuelCompactor || lightningShield {
            specialEquipment = true
        }
        
        let title = "Buy New Ship"
        var message = "Are you sure you want to trade in your \(player.commanderShip.name) for a new \(prototypeShip.name)?"
        
        if transferEscapePod || specialEquipment {
            message = "Are you sure you want to trade in your \(player.commanderShip.name) for a new \(prototypeShip.name), and transfer your unique equipment to the new ship?"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
            self.completeTransaction(transferEscapePod)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // nothing, dismiss alert
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func completeTransaction(transferEscapePod: Bool) {
        if transferEscapePod {
            player.escapePod = true
        } else {
            player.escapePod = false
        }
        
        // transfer crew
        for crewMember in player.commanderShip.crew {
            if prototypeShip.crewQuarters >= prototypeShip.crew.count {
                prototypeShip.crew.append(crewMember)
            }
        }
        
        player.credits -= price
        
        // get special stuff status
        let morgansLaser = player.commanderShip.getMorgansLaserStatus()
        let fuelCompactor = player.commanderShip.getFuelCompactorStatus()
        let lightningShield = player.commanderShip.getLightningShieldStatus()
        
        // swap ship
        player.commanderShip = prototypeShip
        
        // add back special stuff
        player.commanderShip.resetSpecialEquipment(morgansLaser, fuelCompactor: fuelCompactor, lightningShield: lightningShield)
        
        setData()
    }

}
