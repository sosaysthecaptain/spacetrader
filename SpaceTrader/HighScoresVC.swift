//
//  HighScoresVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class HighScoresVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
//        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NewGameVC")
//        self.presentViewController(vc, animated: false, completion: nil)
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
