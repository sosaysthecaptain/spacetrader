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

        self.tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "topCell")
        self.tableView2.registerClass(UITableViewCell.self, forCellReuseIdentifier: "bottomCell")
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        initializeArrays()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        initializeArrays()
        self.tableView1.reloadData()
        self.tableView2.reloadData()
    }
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // TABLE VIEW FUNCTIONS****************************************************************************
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableView1 {
            return currentCrew.count
        } else {
            return availableMercenaries.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell: UITableViewCell = self.tableView1.dequeueReusableCellWithIdentifier("topCell")!
            cell.textLabel?.text = self.currentCrew[indexPath.row]
            return cell
        } else {
            let cell: UITableViewCell = self.tableView2.dequeueReusableCellWithIdentifier("bottomCell")!
            cell.textLabel?.text = self.availableMercenaries[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == tableView1 {
            if indexPath.row < player.commanderShip.crew.count {
                hireNotFire = false
                selectedMercenary = player.commanderShip.crew[indexPath.row]
                performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
            }
            // call segue
        } else {
            hireNotFire = true
            selectedMercenary = galaxy.currentSystem!.mercenaries[indexPath.row]
            performSegueWithIdentifier("mercenaryDetail", sender: selectedMercenary)
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "mercenaryDetail") {
            let vc = (segue.destinationViewController as! MercenaryDetailVC)
            vc.selectedMercenary = selectedMercenary
            vc.hireNotFire = hireNotFire
        }
        
    }
}
