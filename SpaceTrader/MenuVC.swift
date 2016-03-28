//
//  MenuVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/7/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let section0 = ["New Game", "Load Game", "Save Game", "Retire"]
    let section1 = ["Commander Status", "Ship", "Personnel", "Quests", "Bank"]
    let section2 = ["High Scores"]
    let section3 = ["Options", "About Space Trader"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")


    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        if indexPath.section == 0 {
            cell.textLabel?.text = section0[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = section1[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = section2[indexPath.row]
        } else {
            cell.textLabel?.text = section3[indexPath.row]
        }
        
        // set font
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
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
        } else if section == 2 {
            return section2.count
        } else {
            return section3.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            print("selected: section 0, \(indexPath.row)")
            switch indexPath.row {
            case 0:
                newGame()
            case 1:
                performSegueWithIdentifier("loadGameFromMenu", sender: nil)
            case 2:
                print("save game")
                performSegueWithIdentifier("saveGameSegue", sender: nil)
            case 3:
                self.retire()
            default:
                print("error")
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("commanderStatusSegue", sender: nil)
            case 1:
                performSegueWithIdentifier("shipSegue", sender: nil)
            case 2:
                performSegueWithIdentifier("personnelSegue", sender: nil)
            case 3:
                performSegueWithIdentifier("questsSegue", sender: nil)
            case 4:
                performSegueWithIdentifier("bankSegue", sender: nil)
            default: print("error")
            }
        } else if indexPath.section == 2 {
            performSegueWithIdentifier("highScoresFromMenu", sender: nil)
        } else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("optionsSegue", sender: nil)
            case 1:
                performSegueWithIdentifier("aboutSpaceTraderSegue", sender: nil)
            default: print("error")
            }
            
        }
        
        // handle deselection
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func newGame() {
        let title = "New Game?"
        let message = "Your current game will be lost."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("newCommander")
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func retire() {
        print("retire called")
        
        let title = "Retire?"
        let message = "Are you sure you want to retire?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Retire", style: UIAlertActionStyle.Destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            // end game
            player.endGameType = EndGameStatus.Retired
            
            // load game over VC
            let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("gameOverVC")
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // set back button text for child VCs to "Back"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Menu"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

}
