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
    
    @IBOutlet weak var buyButton: PurpleButtonTurnsGray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVars()
        
        setData()
        
        // handle not for sale
        // handle player can't afford
    }
    
    @IBAction func buy(_ sender: AnyObject) {
        // HANDLE TRIBBLES
        
        // check if enough money & crew slots
        if player.credits < price {
            let title = "Not Enough Money"
            let message = "You do not have enough money to buy this ship."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.present(alertController, animated: true, completion: nil)
        } else if player.commanderShip.crew.count > prototypeShip.crewQuarters + 1 {
            
            let title = "Too Many Crewmembers"
            let message = "The new ship you picked doesn't have enough quarters for all of your crewmembers. First you will have to fire one or more of them."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            // else, proceed, ask about escape pod
            if player.escapePod && (player.credits >= (price + 200)) {
                let title = "Transfer Escape Pod"
                let message = "I'll transfer your escape pod to your new ship for 200 credits."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Do it!", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                    self.buyNewShip(true)
                }))
                alertController.addAction(UIAlertAction(title: "No thanks", style: UIAlertActionStyle.cancel ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.buyNewShip(false)
                }))
                self.present(alertController, animated: true, completion: nil)
            } else {
                buyNewShip(false)
            }
            
        }
        
        // alert asking of user wants to buy
    }
    
    
    func setData() {
        
        switch typeOfShip! {
        case ShipType.flea:
            image.image = UIImage(named: "ship0")
        case ShipType.gnat:
            image.image = UIImage(named: "ship1")
        case ShipType.firefly:
            image.image = UIImage(named: "ship2")
        case ShipType.mosquito:
            image.image = UIImage(named: "ship3")
        case ShipType.bumblebee:
            image.image = UIImage(named: "ship4")
        case ShipType.beetle:
            image.image = UIImage(named: "ship5")
        case ShipType.hornet:
            image.image = UIImage(named: "ship6")
        case ShipType.grasshopper:
            image.image = UIImage(named: "ship7")
        case ShipType.termite:
            image.image = UIImage(named: "ship8")
        case ShipType.wasp:
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
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let priceFormatted = numberFormatter.string(from: NSNumber(value: price))!
        priceLabel.text = "\(priceFormatted) credits"
        
        let controlState = UIControlState()
        buyButton.setTitle("Buy \(ship!)", for: controlState)
        
        // disable when not available
        let currentSystemTechLevel = galaxy.currentSystem!.techLevelInt
        let shipTechLevelInt = getTechLevelInt(prototypeShip.minTechLevel)
        
        if currentSystemTechLevel < shipTechLevelInt {
            priceLabel.text = "not sold"
            buyButton.isEnabled = false
        }
        
        // handle "got one"
        if typeOfShip == player.commanderShip.type {
            priceLabel.text = "got one"
            buyButton.isEnabled = false
        }
        
    }
    
    func initializeVars() {
        prototypeShip = SpaceShip(type: typeOfShip, IFFStatus: IFFStatusType.Player)
        
        price = prototypeShip.price
        price -= player.commanderShip.value
        if player.commanderShip.tribbles > 0 {
            price += Int(Double(player.commanderShip.value) * 0.5)
        }
    }
    
    func buyNewShip(_ transferEscapePod: Bool) {
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
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
            self.completeTransaction(transferEscapePod)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel ,handler: {
            (alert: UIAlertAction!) -> Void in
            // nothing, dismiss alert
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func completeTransaction(_ transferEscapePod: Bool) {
        if transferEscapePod {
            player.escapePod = true
        } else {
            player.escapePod = false
        }
        
        player.commanderShip.tribbles = 0
        
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
