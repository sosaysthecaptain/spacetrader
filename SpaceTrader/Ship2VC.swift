//
//  Ship2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/24/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class Ship2VC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // test arrays
    let section0 = ["first thing", "second thing", "third thing"]
    let section1 = ["first other thing", "second other thing", "third other thing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // fix bug whereby table view starts halfway down the page
        self.edgesForExtendedLayout = UIRectEdge.None
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DataViewTableCell = tableView.dequeueReusableCellWithIdentifier("dataViewCell") as! DataViewTableCell
        
        if indexPath.section == 0 {
            cell.setLabels("I'm a key label", valueLabel: "value here")
            cell.accessoryType = .DisclosureIndicator
            //cell.textLabel?.text = section0[indexPath.row]
        } else if indexPath.section == 1 {
            cell.setLabels("I'm a key label", valueLabel: "second section value")
//            cell.textLabel?.text = section1[indexPath.row]
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section0.count
        } else if section == 1 {
            return section1.count
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("selected \(indexPath.section), \(indexPath.row)")
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Section 0 header"
        } else if section == 1 {
            return "Section 1 header"
        } else {
            return "error"
        }
    }
}

class DataViewTableCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: StandardLabel!
    @IBOutlet weak var valueLabel: LightGrayLabel!
    
    func setLabels(keyLabel: String, valueLabel: String) {
        self.keyLabel.text = keyLabel
        self.valueLabel.text = valueLabel
    }
    
}
