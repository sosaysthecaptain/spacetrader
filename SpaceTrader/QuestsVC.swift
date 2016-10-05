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
        
        self.edgesForExtendedLayout = UIRectEdge()
    }

    // TABLE VIEW METHODS************************************************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of open quests: \(player.specialEvents.quests.count)")
        return player.specialEvents.quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("generating cell for quest #\((indexPath as NSIndexPath).row)")
        let cell: QuestStringCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as! QuestStringCell

        cell.setCell(player.specialEvents.quests[(indexPath as NSIndexPath).row].questString)
        
        
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(_ text: String) {
        print("setCell called. Passed text: \(text)")
        textView.text = text
        textView.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        
        // set text vertical alignment to center
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
}


