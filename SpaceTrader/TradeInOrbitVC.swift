//
//  TradeInOrbitVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/23/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

protocol TradeInOrbitDelegate: class {
    func tradeDidFinish(_ controller: TradeInOrbitVC)
}

class TradeInOrbitVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var thirdTextView: UITextView!
    @IBOutlet weak var fourthTextView: UITextView!
    
    @IBOutlet weak var quantityLabel: PurpleHeader!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var cancelButton: GrayButtonTurnsLighter!
    @IBOutlet weak var tradeButton: PurpleButtonTurnsGray!
    
    weak var delegate: TradeInOrbitDelegate?
    
    // these things initialized to arbitrary values
    var encounterTypeIsBuy = false
    var commodityToTrade = TradeItemType.Water
    var tradeOfferAmount = 0
    var askPrice = 0
    var max = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        // determine if buying or selling
        if galaxy.currentJourney!.currentEncounter!.type == EncounterType.traderBuy {
            encounterTypeIsBuy = true
        } else {
            encounterTypeIsBuy = false
        }
        
        // determine what commodity
        if encounterTypeIsBuy {
            // choose whatever player has the most of
            commodityToTrade = player.commanderShip.getItemWithLargestQuantity
            
            // figure out how much of it trader is offering to buy
            tradeOfferAmount = Int(Double(galaxy.currentJourney!.currentEncounter!.opponent.ship.cargoBays) * 0.75)
            if tradeOfferAmount == 0 {
                tradeOfferAmount = 4
            }
            
            // generate ask price
            let localBuyPrice = galaxy.currentSystem!.getBuyPrice(commodityToTrade)
            askPrice = localBuyPrice + (rand(Int(Double(localBuyPrice) * 0.3))) - (rand(Int(Double(localBuyPrice) * 0.3))) + 10
            // handle case where not sold locally and asking price is zero
            if askPrice == 0 {
                askPrice = galaxy.getAverageSalePrice(commodityToTrade)
            }
            
            // calculate max
//            let maxAfford = player.credits / askPrice
//            let maxRoom = player.commanderShip.baysAvailable
//            max = min(maxAfford, maxRoom, tradeOfferAmount)
            let maxRoom = galaxy.currentJourney!.currentEncounter!.opponent.ship.cargoBays - 3
            max = min(player.commanderShip.getQuantity(commodityToTrade), maxRoom)
            
            // set labels
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let askPriceFormatted = numberFormatter.string(from: NSNumber(value: askPrice))!
            
            titleLabel.text = "Sell \(commodityToTrade.rawValue)"
            firstTextView.text = "The trader wants to buy \(commodityToTrade.rawValue) at \(askPriceFormatted) cr. each."
            secondTextView.text = "You have \(player.commanderShip.getQuantity(commodityToTrade)) units in your hold."
            thirdTextView.text = "The trader offers to buy \(max) units. How many do you want to sell?"
            fourthTextView.text = "You paid \(player.commanderShip.getPricePaid(commodityToTrade)) per unit, and the sell price at your destination is \(galaxy.targetSystem!.getSellPrice(commodityToTrade))."
        } else {
            // SELL
            // arbitrarily choose commodity
            let commodities = [TradeItemType.Water, TradeItemType.Furs, TradeItemType.Food, TradeItemType.Ore, TradeItemType.Games, TradeItemType.Firearms, TradeItemType.Medicine, TradeItemType.Machines, TradeItemType.Narcotics, TradeItemType.Robots]
            let random = rand(10)
            commodityToTrade = commodities[random]
            
            // calculate tradeOfferAmount
            tradeOfferAmount = Int(Double(galaxy.currentJourney!.currentEncounter!.opponent.ship.cargoBays) * 0.75)
            if tradeOfferAmount == 0 {
                tradeOfferAmount = 4
            }
            
            // generate ask price
            let localBuyPrice = galaxy.currentSystem!.getBuyPrice(commodityToTrade)
            askPrice = localBuyPrice + (rand(Int(Double(localBuyPrice) * 0.3))) - (rand(Int(Double(localBuyPrice) * 0.3))) - 10
            // handle case where not sold locally and asking price is zero
            if askPrice == 0 {
                askPrice = galaxy.getAverageSalePrice(commodityToTrade)
            }
            
            //print("local buy price is \(localBuyPrice), asking \(askPrice)")            // DEBUG
            
            // calculate max
            let maxAfford = player.credits / askPrice
            let maxRoom = player.commanderShip.baysAvailable
            max = min(maxAfford, maxRoom, tradeOfferAmount)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let askPriceFormatted = numberFormatter.string(from: NSNumber(value: askPrice))!
            
            //let yourProfit = galaxy. - askPriceFormatted
            // LOOKING AT TARGETSYSTEM--REASSIGNMENT HAS NOT YET OCCURED
            
            titleLabel.text = "Buy \(commodityToTrade.rawValue)"
            firstTextView.text = "The trader wants to sell \(commodityToTrade.rawValue) at \(askPriceFormatted) cr. each."
            secondTextView.text = "The trader has \(tradeOfferAmount) units for sale."
            thirdTextView.text = "You have money and space for \(max) units. How many do you want to buy?"
            fourthTextView.text = "The sell price at your destination is \(galaxy.targetSystem!.getSellPrice(commodityToTrade))."
            
            // handle case of not traded at destination
            if galaxy.targetSystem!.getSellPrice(commodityToTrade) == 0 {
                fourthTextView.text = "\(commodityToTrade) is not traded in at your destination."
            }
        }
        
        // update slider stuff
        slider.minimumValue = 0
        slider.maximumValue = Float(max)
        slider.value = 0
        updateQuantityLabel()
    }
    
    func updateQuantityLabel() {
        quantityLabel.text = "\(Int(slider.value)) Units"
        
        if Int(slider.value) == 0 {
            tradeButton.isEnabled = false
        } else {
            tradeButton.isEnabled = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func sliderDidMove(_ sender: AnyObject) {
        updateQuantityLabel()
    }

    @IBAction func cancelTapped(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: {
            //galaxy.currentJourney!.currentEncounter!.concludeEncounter()
            self.delegate?.tradeDidFinish(self)
        })
    }
    
    @IBAction func tradeTapped(_ sender: AnyObject) {
        // perform trade
        if encounterTypeIsBuy{
            player.commanderShip.removeCargo(commodityToTrade, quantity: Int(slider.value))
            player.credits += (askPrice * Int(slider.value))
            
            // launch alert
            let title: String = "Trade Completed"
            let message: String = "Thanks for selling the \(commodityToTrade.rawValue). It's been a pleasure doing business with you."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // end encounter, close VC
                //galaxy.currentJourney!.currentEncounter!.concludeEncounter()
                self.dismiss(animated: false, completion: {
                        //galaxy.currentJourney!.currentEncounter!.concludeEncounter()
                    // fire delegate method here
                    self.delegate?.tradeDidFinish(self)
                })
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            // sell
            
            player.commanderShip.addCargo(commodityToTrade, quantity: Int(slider.value), pricePaid: askPrice)
            player.credits -= askPrice * Int(slider.value)
            
            // launch alert
            let title: String = "Trade Completed"
            let message: String = "Thanks for buying the \(commodityToTrade.rawValue). It's been a pleasure doing business with you."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // end encounter, close VC
                self.dismiss(animated: false, completion: {
                    // fire delegate method here
                    
                    self.delegate?.tradeDidFinish(self)
                })
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
