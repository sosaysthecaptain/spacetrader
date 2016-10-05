//
//  BuyModalVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/23/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


protocol BuyModalVCDelegate: class {
    func buyModalDidFinish(_ controller: BuyModalVC)
    
}

// OBSOLETE
class BuyModalVC: UIViewController  {       // the one that calls the function in the delegate

    
    weak var delegate: BuyModalVCDelegate?  // not enough. Must also set delegate.
    
    @IBOutlet weak var buyButtonForLabel: UIButton!
    
    var modalClosed = false
    var tradeItem: TradeItemType!
    var tradeItemName: String = buySellCommodity!.rawValue  // need name here
    var tradeItemPrice: Int {
        get {
            switch buySellCommodity! {
            case .Water:
                return currentSystem.waterBuy
            case .Furs:
                return currentSystem.fursBuy
            case .Food:
                return currentSystem.foodBuy
            case .Ore:
                return currentSystem.oreBuy
            case .Games:
                return currentSystem.gamesBuy
            case .Firearms:
                return currentSystem.firearmsBuy
            case .Medicine:
                return currentSystem.medicineBuy
            case .Machines:
                return currentSystem.machinesBuy
            case .Narcotics:
                return currentSystem.narcoticsBuy
            case .Robots:
                return currentSystem.robotsBuy
            default:
                return 0
            }
        }
    }
    
    var tradeItemSellPrice: Int {
        get {
            switch buySellCommodity! {
                case .Water:
                    return currentSystem.waterSell
                case .Furs:
                    return currentSystem.fursSell
                case .Food:
                    return currentSystem.foodSell
                case .Ore:
                    return currentSystem.oreSell
                case .Games:
                    return currentSystem.gamesSell
                case .Firearms:
                    return currentSystem.firearmsSell
                case .Medicine:
                    return currentSystem.medicineSell
                case .Machines:
                    return currentSystem.machinesSell
                case .Narcotics:
                    return currentSystem.narcoticsSell
                case .Robots:
                    return currentSystem.robotsSell
                default:
                    return 0
            }
        }
    }
    
    var max = player.getMax(buySellCommodity!)      // BUG ALERT: this causes the game to crash if you tap one of the nonexistent buttons for something not stocked in the system in question. Rather than checking here, need to make those buttons nonexistent.
    
    @IBOutlet weak var headerField: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var textField: UITextView!
        
    override func viewDidLoad() {
        quantityField.becomeFirstResponder()
        
        tradeItem = buySellCommodity
        //tradeItemName = BuySellCommodity()        // figure out how to render this from the enum w/o a switch
        
        
        
        if buyAsOpposedToSell {
            headerField.text = "Buy \(tradeItemName)"
            textField.text = "At \(tradeItemPrice) cr. each, you can buy up to \(max). How many do you want to buy?"
        } else {
            let quantityAvailableToSell = player.commanderShip.getQuantity(buySellCommodity!)
            let averagePricePaid = player.commanderShip.getPricePaid(buySellCommodity!)
            print("quantity: \(quantityAvailableToSell), average price paid: \(averagePricePaid)")
            
            let profitLoss = tradeItemSellPrice - averagePricePaid
            
            var pOrL = String()
            if profitLoss >= 0 {
                pOrL = "profit"
            } else {
                pOrL = "loss"
            }
            
            headerField.text = "Sell \(tradeItemName)"
            textField.text = "You can sell \(quantityAvailableToSell) at up to \(tradeItemSellPrice) cr. each. You paid \(averagePricePaid) cr. per unit. Your \(pOrL) per unit is \(abs(profitLoss)) cr. How many do you want to sell?"
            
            // set text of buy button
            let controlState = UIControlState()
            buyButtonForLabel.setTitle("Sell", for: controlState)
        }
        
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: false, completion: nil)
    }
   
    @IBAction func buy() {
        // wrap all this in an if to handle buy vs sell
        if buyAsOpposedToSell {
            if quantityField.text != nil {
                let quantity = Int(quantityField.text!)
                if quantity <= max {
                    player.buy(buySellCommodity!, quantity: quantity!)
                    delegate?.buyModalDidFinish(self)
                    self.dismiss(animated: false, completion: nil)
                } else {
                    self.dismiss(animated: false, completion: nil)
                    print("max exceeded; buy failed")
                }
            }
        } else {
            if quantityField.text != nil {
                let quantity = Int(quantityField.text!)
                player.sell(buySellCommodity!, quantity: quantity!)
                delegate?.buyModalDidFinish(self)
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    }

    
    
}
