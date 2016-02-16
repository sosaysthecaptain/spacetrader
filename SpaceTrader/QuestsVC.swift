//
//  QuestsVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/15/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class QuestsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.tableView.registerClass(QuestStringCell.self, forCellReuseIdentifier: "customCell")
        
        self.edgesForExtendedLayout = UIRectEdge.None
    }

    // TABLE VIEW METHODS************************************************************************
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of open quests: \(player.specialEvents.quests.count)")
        return player.specialEvents.quests.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("generating cell for quest #\(indexPath.row)")
        let cell: QuestStringCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as! QuestStringCell

        cell.setCell(player.specialEvents.quests[indexPath.row].questString)
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("\(indexPath.row) selected")
//    }
    
    

}

class QuestStringCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(text: String) {
        print("setCell called. Passed text: \(text)")
        textView.text = text
    }
    
}


