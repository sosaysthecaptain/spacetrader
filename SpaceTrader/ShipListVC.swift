//
//  ShipListVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 11/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit


class ShipListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chosenShip: String!
    var chosenShipType: ShipType!
    
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["Flea", "Gnat", "Firefly", "Mosquito", "Bumblebee", "Beetle", "Hornet", "Grasshopper", "Termite", "Wasp"]
    var ships: [ShipType] = [ShipType.Flea, ShipType.Gnat, ShipType.Firefly, ShipType.Mosquito, ShipType.Bumblebee, ShipType.Beetle, ShipType.Hornet, ShipType.Grasshopper, ShipType.Termite, ShipType.Wasp]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BuyShipCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell")! as! BuyShipCell
        let ship = self.ships[indexPath.row]
        cell.setCell(ship)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("You selected cell #\(indexPath.row)!")
        chosenShip = items[indexPath.row]
        chosenShipType = ships[indexPath.row]
        print("You selected \(chosenShip)")
        performSegueWithIdentifier("shipDetail", sender: chosenShip)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "shipDetail") {
            
            let vc = (segue.destinationViewController as! ShipDetailVC)
            vc.ship = chosenShip
            vc.typeOfShip = chosenShipType
        }
        
    }

}
