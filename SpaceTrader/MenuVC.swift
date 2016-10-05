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
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        if (indexPath as NSIndexPath).section == 0 {
            cell.textLabel?.text = section0[(indexPath as NSIndexPath).row]
        } else if (indexPath as NSIndexPath).section == 1 {
            cell.textLabel?.text = section1[(indexPath as NSIndexPath).row]
        } else if (indexPath as NSIndexPath).section == 2 {
            cell.textLabel?.text = section2[(indexPath as NSIndexPath).row]
        } else {
            cell.textLabel?.text = section3[(indexPath as NSIndexPath).row]
        }
        
        // set font
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 {
            print("selected: section 0, \((indexPath as NSIndexPath).row)")
            switch (indexPath as NSIndexPath).row {
            case 0:
                newGame()
            case 1:
                performSegue(withIdentifier: "loadGameFromMenu", sender: nil)
            case 2:
                print("save game")
                performSegue(withIdentifier: "saveGameSegue", sender: nil)
            case 3:
                self.retire()
            default:
                print("error")
            }
        } else if (indexPath as NSIndexPath).section == 1 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                performSegue(withIdentifier: "commanderStatusSegue", sender: nil)
            case 1:
                performSegue(withIdentifier: "shipSegue", sender: nil)
            case 2:
                performSegue(withIdentifier: "personnelSegue", sender: nil)
            case 3:
                performSegue(withIdentifier: "questsSegue", sender: nil)
            case 4:
                performSegue(withIdentifier: "bankSegue", sender: nil)
            default: print("error")
            }
        } else if (indexPath as NSIndexPath).section == 2 {
            performSegue(withIdentifier: "highScoresFromMenu", sender: nil)
        } else if (indexPath as NSIndexPath).section == 3 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                performSegue(withIdentifier: "optionsSegue", sender: nil)
            case 1:
                performSegue(withIdentifier: "aboutSpaceTraderSegue", sender: nil)
            default: print("error")
            }
            
        }
        
        // handle deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func newGame() {
        let title = "New Game?"
        let message = "Your current game will be lost."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "newCommander")
            self.present(vc, animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func retire() {
        print("retire called")
        
        let title = "Retire?"
        let message = "Are you sure you want to retire?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Retire", style: UIAlertActionStyle.destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            // end game
            player.endGameType = EndGameStatus.retired
            
            // load game over VC
            let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "gameOverVC")
            self.present(vc, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // set back button text for child VCs to "Back"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Menu"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

}
