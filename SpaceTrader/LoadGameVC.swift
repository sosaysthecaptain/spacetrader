//
//  LoadGameVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/15/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class LoadGameVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("load game. Games available to load:")
        for game in savedGames {
            print(game.name)
        }
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.edgesForExtendedLayout = UIRectEdge.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGame(game: NamedSavedGame) {
        // clear commander, galaxy
        player = Commander(commanderName: "new", difficulty: DifficultyType.beginner, pilotSkill: 1, fighterSkill: 1, traderSkill: 1, engineerSkill: 1)
        galaxy = Galaxy()
        
        // load new values for those two
        player = game.savedCommander
        galaxy = game.savedGalaxy
        
        // go to system info
        let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainTabBarController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func deleteGame(index: Int) {
        print("deleting \(index)")
        savedGames.removeAtIndex(index)
        tableView.reloadData()
        // not saving archive. That will be done on applicationWillResignActive
    }
    
    // tableView methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedGames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: LoadGameCellTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("LoadGameCell")! as! LoadGameCellTableViewCell
        let title = savedGames[indexPath.row].name
        let netWorth = savedGames[indexPath.row].savedCommander.netWorth
        let days = savedGames[indexPath.row].savedCommander.days
        
        cell.setCell(title, netWorth: netWorth, days: days)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // prompt user
        let title = "Load Game?"
        let message = "Your current game will be lost."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            self.loadGame(savedGames[indexPath.row])
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteGame(indexPath.row)
        }
    }

}
