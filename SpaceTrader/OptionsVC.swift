//
//  OptionsVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {
    
    @IBOutlet weak var fullTanksOutlet: UISwitch!
    @IBOutlet weak var hullRepairOutlet: UISwitch!
    @IBOutlet weak var newspaperOutlet: UISwitch!
    @IBOutlet weak var remindLoansOutlet: UISwitch!
    @IBOutlet weak var ignorePiratesOutlet: UISwitch!
    @IBOutlet weak var ignorePoliceOutlet: UISwitch!
    @IBOutlet weak var ignoreTradersOutlet: UISwitch!
    
    // layout constraints
    @IBOutlet weak var fuelTanksFromTopConstraint: NSLayoutConstraint!      // 20
    @IBOutlet weak var hullFromFuelConstraint: NSLayoutConstraint!          // 16
    @IBOutlet weak var newspaperFromHullConstraint: NSLayoutConstraint!     // 16
    @IBOutlet weak var remindLoansFromNewspaper: NSLayoutConstraint!        // 50
    @IBOutlet weak var alwaysIgnoreFromRemindConstraint: NSLayoutConstraint!// 50
    @IBOutlet weak var piratesFromAlwaysConstraint: NSLayoutConstraint!     // 16
    @IBOutlet weak var policeFromPiratesConstraint: NSLayoutConstraint!     // 16
    @IBOutlet weak var tradersFromPoliceConstraint: NSLayoutConstraint!     // 16
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullTanksOutlet.isOn = player.autoFuel
        hullRepairOutlet.isOn = player.autoRepair
        newspaperOutlet.isOn = player.autoNewspaper
        remindLoansOutlet.isOn = player.remindLoans
        ignorePiratesOutlet.isOn = player.ignorePirates
        ignorePoliceOutlet.isOn = player.ignorePolice
        ignoreTradersOutlet.isOn = player.ignoreTraders
        
        // adjust sizes if needed
        let screenSize: CGRect = UIScreen.main.bounds
        
        // handle 3.5" screen
        if screenSize.height < 485 {
            fuelTanksFromTopConstraint.constant = 15
            hullFromFuelConstraint.constant = 14
            newspaperFromHullConstraint.constant = 14
            remindLoansFromNewspaper.constant = 30
            alwaysIgnoreFromRemindConstraint.constant = 30
            piratesFromAlwaysConstraint.constant = 14
            policeFromPiratesConstraint.constant = 14
            tradersFromPoliceConstraint.constant = 14
            
//            @IBOutlet weak var fuelTanksFromTopConstraint: NSLayoutConstraint!      // 20
//            @IBOutlet weak var hullFromFuelConstraint: NSLayoutConstraint!          // 16
//            @IBOutlet weak var newspaperFromHullConstraint: NSLayoutConstraint!     // 16
//            @IBOutlet weak var remindLoansFromNewspaper: NSLayoutConstraint!        // 50
//            @IBOutlet weak var alwaysIgnoreFromRemindConstraint: NSLayoutConstraint!// 50
//            @IBOutlet weak var piratesFromAlwaysConstraint: NSLayoutConstraint!     // 16
//            @IBOutlet weak var policeFromPiratesConstraint: NSLayoutConstraint!     // 16
//            @IBOutlet weak var tradersFromPoliceConstraint: NSLayoutConstraint!     // 16
        }
    }

    @IBAction func fuelTanksToggled(_ sender: AnyObject) {
        if fullTanksOutlet.isOn {
            player.autoFuel = true
        } else {
            player.autoFuel = false
        }
    }
    
    @IBAction func hullRepairToggled(_ sender: AnyObject) {
        if hullRepairOutlet.isOn {
            player.autoRepair = true
        } else {
            player.autoRepair = false
        }
    }
    
    @IBAction func autoNewspaperToggled(_ sender: AnyObject) {
        if newspaperOutlet.isOn {
            player.autoNewspaper = true
        } else {
            player.autoNewspaper = false
        }
    }
    
    @IBAction func remindLoansToggled(_ sender: AnyObject) {
        if remindLoansOutlet.isOn {
            player.remindLoans = true
        } else {
            player.remindLoans = false
        }
    }

    @IBAction func ignorePiratesToggled(_ sender: AnyObject) {
        if ignorePiratesOutlet.isOn {
            player.ignorePirates = true
        } else {
            player.ignorePirates = false
        }
    }
    
    @IBAction func ignorePoliceToggled(_ sender: AnyObject) {
        if ignorePoliceOutlet.isOn {
            player.ignorePolice = true
        } else {
            player.ignorePolice = false
        }
    }
    
    @IBAction func ignoreTradersToggled(_ sender: AnyObject) {
        if ignoreTradersOutlet.isOn {
            player.ignoreTraders = true
        } else {
            player.ignoreTraders = false
        }
    }



}
