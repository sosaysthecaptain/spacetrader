//
//  BuyEquipmentCell.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/25/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class BuyEquipmentCell: UITableViewCell {

    @IBOutlet weak var equipmentTitleLabel: UILabel!
    @IBOutlet weak var equipmentPriceLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(item: UniversalGadgetType) {
        let deviceTypeInt = getUniversalGadgetType(item)
        
        var prototypeWeapon: Weapon!
        var prototypeShield: Shield!
        var prototypeGadget: Gadget!
        
        switch item {
            case UniversalGadgetType.pulseLaser:
                prototypeWeapon = Weapon(type: WeaponType.pulseLaser)
            case UniversalGadgetType.beamLaser:
                prototypeWeapon = Weapon(type: WeaponType.beamLaser)
            case UniversalGadgetType.militaryLaser:
                prototypeWeapon = Weapon(type: WeaponType.militaryLaser)
            case UniversalGadgetType.photonDisruptor:
                prototypeWeapon = Weapon(type: WeaponType.photonDisruptor)
            case UniversalGadgetType.morgansLaser:
                prototypeWeapon = Weapon(type: WeaponType.morgansLaser)
            case UniversalGadgetType.energyShield:
                prototypeShield = Shield(type: ShieldType.energyShield)
            case UniversalGadgetType.reflectiveShield:
                prototypeShield = Shield(type: ShieldType.reflectiveShield)
            case UniversalGadgetType.lightningShield:
                prototypeShield = Shield(type: ShieldType.lightningShield)
            case UniversalGadgetType.CargoBays:
                prototypeGadget = Gadget(type: GadgetType.CargoBays)
            case UniversalGadgetType.AutoRepair:
                prototypeGadget = Gadget(type: GadgetType.AutoRepair)
            case UniversalGadgetType.Navigation:
                prototypeGadget = Gadget(type: GadgetType.Navigation)
            case UniversalGadgetType.Targeting:
                prototypeGadget = Gadget(type: GadgetType.Targeting)
            case UniversalGadgetType.Cloaking:
                prototypeGadget = Gadget(type: GadgetType.Cloaking)
            default:
                print("not a stock item")
        }
        
        if deviceTypeInt == 0 {
            equipmentTitleLabel.text = prototypeWeapon.name
            imageLabel.image = prototypeWeapon.image
            
            let price = prototypeWeapon.price
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            let priceFormatted = numberFormatter.stringFromNumber(price)
            equipmentPriceLabel.text = "\(priceFormatted!) credits"
        } else if deviceTypeInt == 1 {
            equipmentTitleLabel.text = prototypeShield.name
            imageLabel.image = prototypeShield.image
            
            let price = prototypeShield.price
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            let priceFormatted = numberFormatter.stringFromNumber(price)
            equipmentPriceLabel.text = "\(priceFormatted!) credits"
        } else {
            equipmentTitleLabel.text = prototypeGadget.name
            imageLabel.image = prototypeGadget.image
            
            let price = prototypeGadget.price
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            let priceFormatted = numberFormatter.stringFromNumber(price)
            equipmentPriceLabel.text = "\(priceFormatted!) credits"
        }
        
    }

}
