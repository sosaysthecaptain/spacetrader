//
//  ShipVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/15/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

// OBSOLETE, SUPERCEDED BY SHIP2VC
class ShipVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var crewQuartersLabel: UILabel!
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
   
    var tableView1TextArray: [String] = []
    var tableView2TextArray: [String] = ["Test initial item"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "topCell")
        self.tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "bottomCell")
        
        updateData()
    }
    
    func updateData() {
        typeLabel.text = player.commanderShip.name
        crewQuartersLabel.text = "\(player.commanderShip.crewSlotsFilled)/\(player.commanderShip.crewQuarters)"
        
        tableView2TextArray = player.commanderShip.specialCargoStrings  // load special cargo data
        
        print("loading specialCargoStrings:")
        for item in player.commanderShip.specialCargoStrings {
            print(item)
        }
        
        class equipmentEntry {
            var name: String
            var quantity: Int
            
            init(name: String, quantity: Int) {
                self.name = name
                self.quantity = quantity
            }
        }
        
        var equipmentOnBoard: [equipmentEntry] = []
        
        for item in player.commanderShip.weapon {
            // if item is not already in equipmentOnBoard, add it
            var alreadyInList = false
            for item2 in equipmentOnBoard {
                // update quantity if already present
                if item2.name == item.name {
                    item2.quantity += 1
                    alreadyInList = true
                }
            }
            // add it if not present yet, quantity 1
            if !alreadyInList {
                let newEntry = equipmentEntry(name: item.name, quantity: 1)
                equipmentOnBoard.append(newEntry)
            }
        }
        
        for item in player.commanderShip.shield {
            // if item is not already in equipmentOnBoard, add it
            var alreadyInList = false
            for item2 in equipmentOnBoard {
                // update quantity if already present
                if item2.name == item.name {
                    item2.quantity += 1
                    alreadyInList = true
                }
            }
            // add it if not present yet, quantity 1
            if !alreadyInList {
                let newEntry = equipmentEntry(name: item.name, quantity: 1)
                equipmentOnBoard.append(newEntry)
            }
        }
        
        for item in player.commanderShip.gadget {
            // if item is not already in equipmentOnBoard, add it
            var alreadyInList = false
            for item2 in equipmentOnBoard {
                // update quantity if already present
                if item2.name == item.name {
                    item2.quantity += 1
                    alreadyInList = true
                }
            }
            // add it if not present yet, quantity 1
            if !alreadyInList {
                let newEntry = equipmentEntry(name: item.name, quantity: 1)
                equipmentOnBoard.append(newEntry)
            }
        }
        
        // equipment
        tableView1TextArray = []
        for entry in equipmentOnBoard {
            var plural = false
            var newString = ""
            if entry.quantity > 1 {
                plural = true
            }
            if plural {
                newString = "\(entry.quantity) \(entry.name)s"
            } else {
                newString = "\(entry.quantity) \(entry.name)"
            }
            
                
            tableView1TextArray.append(newString)
        }
        
        // report empty slots
        let emptyWeaponString = "<\(player.commanderShip.weaponSlots - player.commanderShip.weapon.count) empty weapon slots>"
        tableView1TextArray.append(emptyWeaponString)
        let emptyShieldString = "<\(player.commanderShip.shieldSlots - player.commanderShip.shield.count) empty shield slots>"
        tableView1TextArray.append(emptyShieldString)
        let emptyGadgetString = "<\(player.commanderShip.gadgetSlots - player.commanderShip.gadget.count) empty gadget slots>"
        tableView1TextArray.append(emptyGadgetString)
        
        
        self.tableView1.reloadData()
        self.tableView2.reloadData()
    }



    // TABLE VIEW METHODS*************************************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return tableView1TextArray.count
        } else {
            return tableView2TextArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableView1 {
            let cell: UITableViewCell = self.tableView1.dequeueReusableCell(withIdentifier: "topCell")!
            cell.textLabel?.text = self.tableView1TextArray[(indexPath as NSIndexPath).row]
            
            //set font used in table view cell label
            cell.textLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            return cell
        } else {
            let cell: UITableViewCell = self.tableView2.dequeueReusableCell(withIdentifier: "bottomCell")!
            cell.textLabel?.text = self.tableView2TextArray[(indexPath as NSIndexPath).row]
            
            //set font used in table view cell label
            cell.textLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView1 {
            //print("indexPath.row: \(indexPath.row), shipItems.count: \(shipItems.count)")
            
        } else {
            
        }
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
