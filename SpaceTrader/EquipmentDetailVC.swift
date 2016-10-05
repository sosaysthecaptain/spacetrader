//
//  EquipmentDetailVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/1/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class EquipmentDetailVC: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var buyPrice: UILabel!
    @IBOutlet weak var sellPrice: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var blurb: UITextView!
    @IBOutlet weak var buyButtonLabel: PurpleButtonTurnsGray!
    
    
    var chosenItem: UniversalGadget?
    var buyNotSell: Bool?
    
    var numRelevantSlots = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()

        // Do any additional setup after loading the view.
    }

    @IBAction func buySellButton(_ sender: AnyObject) {
        
        if buyNotSell! {
            if numRelevantSlots == 0 {
                // fail on account of slots
                let title = "Not Enough Slots"
                let message = "You have already filled all of your available slots for this type of item."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                    
                }))
                self.present(alertController, animated: true, completion: nil)
            } else {
                // check money
                if player.credits >= chosenItem!.price {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let buyPriceFormatted = numberFormatter.string(from: NSNumber(value: chosenItem!.price))!
                    
                    // ask and do transaction
                    let title = "Buy \(chosenItem!.name)"
                    let message = "Do you wish to buy this item for \(buyPriceFormatted) credits?"
                    
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default ,handler: {
                        (alert: UIAlertAction!) -> Void in
                        // buy item
                        self.buyItem()
                    }))
                    alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel ,handler: {
                        (alert: UIAlertAction!) -> Void in
                        //do nothing
                    }))
                    self.present(alertController, animated: true, completion: nil)

                } else {
                    // fail cuz broke
                    let title = "Not Enough Money"
                    let message = "You do not have enough money to buy this item."
                    
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                        (alert: UIAlertAction!) -> Void in
                        // do nothing
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            // sell
            let title = "Sell Item"
            let message = "Are you sure you want to sell this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                self.sellItem()
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func setData() {
        imageOutlet.image = chosenItem!.image
        nameLabel.text = chosenItem!.name
        typeLabel.text = chosenItem!.type
        powerLabel.text = chosenItem!.power
        blurb.text = chosenItem!.blurb
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let buyPriceFormatted = numberFormatter.string(from: NSNumber(value: chosenItem!.price))!
        buyPrice.text = "\(buyPriceFormatted) cr."
        let sellPriceFormatted = numberFormatter.string(from: NSNumber(value: chosenItem!.sellPrice))!
        sellPrice.text = "\(sellPriceFormatted) cr."
        
        let controlState = UIControlState()
        if buyNotSell! {
            buyButtonLabel.setTitle("Buy", for: controlState)
        } else {
            buyButtonLabel.setTitle("Sell", for: controlState)
        }
        
        // numRelevantSlots
        if chosenItem!.typeIndex == 0 {
            numRelevantSlots = player.commanderShip.weaponSlots - player.commanderShip.weapon.count
            print("number of relevant slots: \(numRelevantSlots)")
        } else if chosenItem!.typeIndex == 1 {
            numRelevantSlots = player.commanderShip.shieldSlots - player.commanderShip.shield.count
            print("number of relevant slots: \(numRelevantSlots)")
        } else {
            numRelevantSlots = player.commanderShip.gadgetSlots - player.commanderShip.gadget.count
            print("number of relevant slots: \(numRelevantSlots)")
        }
        
        
    }
    
    func buyItem() {
        print("buying item")
        player.credits -= chosenItem!.price
        
        if chosenItem!.typeIndex == 0 {
            player.commanderShip.weapon.append(chosenItem!.weaponItem!)
        } else if chosenItem!.typeIndex == 1 {
            player.commanderShip.shield.append(chosenItem!.shieldItem!)
        } else if chosenItem!.typeIndex == 2 {
            player.commanderShip.gadget.append(chosenItem!.gadgetItem!)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func sellItem() {
        print("selling item")
        player.credits += chosenItem!.sellPrice
        
        if chosenItem!.typeIndex == 0 {
            var index = 0
            var removeAtIndex: Int?
            for item in player.commanderShip.weapon {
                if item.type == chosenItem!.wType {
                    removeAtIndex = index
                }
                index += 1
            }
            if removeAtIndex != nil {
                player.commanderShip.weapon.remove(at: removeAtIndex!)
            }
        } else if chosenItem!.typeIndex == 1 {
            var index = 0
            var removeAtIndex: Int?
            for item in player.commanderShip.shield {
                if item.type == chosenItem!.sType {
                    removeAtIndex = index
                }
                index += 1
            }
            if removeAtIndex != nil {
                player.commanderShip.shield.remove(at: removeAtIndex!)
            }
        } else if chosenItem!.typeIndex == 2 {
            var index = 0
            var removeAtIndex: Int?
            for item in player.commanderShip.gadget {
                if item.type == chosenItem!.gType {
                    removeAtIndex = index
                }
                index += 1
            }
            if removeAtIndex != nil {
                player.commanderShip.gadget.remove(at: removeAtIndex!)
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }

}
