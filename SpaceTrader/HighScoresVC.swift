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

        self.edgesForExtendedLayout = UIRectEdge.None
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

    @IBAction func doneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
//        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NewGameVC")
//        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreArchive.highScores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HighScoresCell = self.tableView.dequeueReusableCellWithIdentifier("HighScoreCell")! as! HighScoresCell
        cell.setCell(highScoreArchive.highScores[indexPath.row].name, days: highScoreArchive.highScores[indexPath.row].days, score: highScoreArchive.highScores[indexPath.row].score, netWorth: highScoreArchive.highScores[indexPath.row].worth)
        
        return cell
    }
    
}