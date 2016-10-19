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
    var ships: [ShipType] = [ShipType.flea, ShipType.gnat, ShipType.firefly, ShipType.mosquito, ShipType.bumblebee, ShipType.beetle, ShipType.hornet, ShipType.grasshopper, ShipType.termite, ShipType.wasp]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: BuyShipCell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell")! as! BuyShipCell
        let ship = self.ships[(indexPath as NSIndexPath).row]
        cell.setCell(ship)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("You selected cell #\(indexPath.row)!")
        chosenShip = items[(indexPath as NSIndexPath).row]
        chosenShipType = ships[(indexPath as NSIndexPath).row]
        //print("You selected \(chosenShip)")
        performSegue(withIdentifier: "shipDetail", sender: chosenShip)
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "shipDetail") {
            
            let vc = (segue.destination as! ShipDetailVC)
            vc.ship = chosenShip
            vc.typeOfShip = chosenShipType
        }
        
    }

}
