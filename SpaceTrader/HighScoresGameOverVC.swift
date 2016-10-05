//
//  HighScoresGameOverVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class HighScoresGameOverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    @IBAction func doneButton(_ sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "NewGameVC")
        self.present(vc, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreArchive.highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HighScoresCell = self.tableView.dequeueReusableCell(withIdentifier: "HighScoreCell")! as! HighScoresCell
        cell.setCell(highScoreArchive.highScores[(indexPath as NSIndexPath).row].name, days: highScoreArchive.highScores[(indexPath as NSIndexPath).row].days, score: highScoreArchive.highScores[(indexPath as NSIndexPath).row].score, netWorth: highScoreArchive.highScores[(indexPath as NSIndexPath).row].worth)
        
        return cell
    }
    
}
