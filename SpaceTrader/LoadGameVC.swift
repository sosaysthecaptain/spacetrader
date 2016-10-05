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
        self.edgesForExtendedLayout = UIRectEdge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGame(_ game: NamedSavedGame) {
        // clear commander, galaxy
        player = Commander(commanderName: "new", difficulty: DifficultyType.beginner, pilotSkill: 1, fighterSkill: 1, traderSkill: 1, engineerSkill: 1)
        galaxy = Galaxy()
        
        // load new values for those two
        player = game.savedCommander
        galaxy = game.savedGalaxy
        
        // go to system info
        let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "mainTabBarController")
        self.present(vc, animated: true, completion: nil)
    }
    
    func deleteGame(_ index: Int) {
        print("deleting \(index)")
        savedGames.remove(at: index)
        tableView.reloadData()
        // not saving archive. That will be done on applicationWillResignActive
    }
    
    // tableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoadGameCellTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LoadGameCell")! as! LoadGameCellTableViewCell
        let title = savedGames[(indexPath as NSIndexPath).row].name
        let netWorth = savedGames[(indexPath as NSIndexPath).row].savedCommander.netWorth
        let days = savedGames[(indexPath as NSIndexPath).row].savedCommander.days
        
        cell.setCell(title, netWorth: netWorth, days: days)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // prompt user
        let title = "Load Game?"
        let message = "Your current game will be lost."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            self.loadGame(savedGames[(indexPath as NSIndexPath).row])
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
        // deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteGame((indexPath as NSIndexPath).row)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

}
