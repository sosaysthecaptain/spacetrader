//
//  MercenariesVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class MercenariesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    
    var currentCrew: [String] = []
    var availableMercenaries: [String] = []
    
    var hireNotFire = true
    var selectedMercenary: CrewMember?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "topCell")
        self.tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "bottomCell")
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        initializeArrays()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeArrays()
        self.tableView1.reloadData()
        self.tableView2.reloadData()
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TABLE VIEW FUNCTIONS****************************************************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableView1 {
            return currentCrew.count
        } else {
            return availableMercenaries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell: UITableViewCell = self.tableView1.dequeueReusableCell(withIdentifier: "topCell")!
            cell.textLabel?.text = self.currentCrew[(indexPath as NSIndexPath).row]
            
            //set font used in table view cell label
            cell.textLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            return cell
        } else {
            let cell: UITableViewCell = self.tableView2.dequeueReusableCell(withIdentifier: "bottomCell")!
            cell.textLabel?.text = self.availableMercenaries[(indexPath as NSIndexPath).row]
            
            //set font used in table view cell label
            cell.textLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableView1 {
            if (indexPath as NSIndexPath).row < player.commanderShip.crew.count {
                hireNotFire = false
                selectedMercenary = player.commanderShip.crew[(indexPath as NSIndexPath).row]
                performSegue(withIdentifier: "mercenaryDetail", sender: selectedMercenary)
            }
            // call segue
        } else {
            hireNotFire = true
            selectedMercenary = galaxy.currentSystem!.mercenaries[(indexPath as NSIndexPath).row]
            performSegue(withIdentifier: "mercenaryDetail", sender: selectedMercenary)
        }
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func initializeArrays() {
        currentCrew = []
        availableMercenaries = []
        
        // CURRENT CREW
        for mercenary in player.commanderShip.crew {
            currentCrew.append("\(mercenary.name)")
        }
        
        // handle no crew quarters
        if player.commanderShip.crewQuarters == 0 {
            currentCrew.append("No quarters available")
        }
        
        // handle empty quarters
        let emptyQuarters = player.commanderShip.crewQuarters - player.commanderShip.crew.count - 1
        if emptyQuarters > 0 {
            for _ in 0..<emptyQuarters {
                currentCrew.append("<vacancy>")
            }
        }
        
        // AVAILABLE MERCENARIES
        for mercenary in galaxy.currentSystem!.mercenaries {
            availableMercenaries.append("\(mercenary.name)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "mercenaryDetail") {
            let vc = (segue.destination as! MercenaryDetailVC)
            vc.selectedMercenary = selectedMercenary
            vc.hireNotFire = hireNotFire
        }
        
    }
}
