//
//  NewGameVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class NewGameVC: UIViewController {
    

    
    @IBOutlet weak var backgroundImage: UIImageView!
    var foundGame = false
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var loadGameButton: UIButton!
    @IBOutlet weak var highScoresButton: UIButton!
    
    // layout constraints
    @IBOutlet weak var newGameTrailingConstraint: NSLayoutConstraint!   // 40
    @IBOutlet weak var newGameTopConstraint: NSLayoutConstraint!        // 60
    @IBOutlet weak var loadFromNewConstraint: NSLayoutConstraint!       // 25
    @IBOutlet weak var highFromLoadConstraint: NSLayoutConstraint!      // 25
    
    
    
    
    override func viewDidLoad() {
        if loadAutosavedGame() {
            foundGame = true
        } else {
            //print("no autosaved game found.")
            print("NewGameVC autosave functionality disabled")
        }

        // send view to background. Not possible to do this in IB
        self.view.sendSubview(toBack: backgroundImage)
        
        // layout constraints
        // adjust sizes if needed
        let screenSize: CGRect = UIScreen.main.bounds
        
        if screenSize.height > 730 {
            // 5.5" screen
            newGameTrailingConstraint.constant = 65
            newGameTopConstraint.constant = 65
            loadFromNewConstraint.constant = 30
            highFromLoadConstraint.constant = 30
            
            newGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 28)!
            loadGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 28)!
            highScoresButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 28)!
            
        } else if screenSize.height > 660 {
            // 4.7" screen
            newGameTrailingConstraint.constant = 55
            newGameTopConstraint.constant = 60
            loadFromNewConstraint.constant = 25
            highFromLoadConstraint.constant = 25
            
            newGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            loadGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            highScoresButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            
        } else if screenSize.height > 560 {
            // 4.0" screen
            newGameTrailingConstraint.constant = 36
            newGameTopConstraint.constant = 45
            loadFromNewConstraint.constant = 25
            highFromLoadConstraint.constant = 25
            
            newGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            loadGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            highScoresButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            
        } else {
            // 3.5" screen
            newGameTrailingConstraint.constant = 36
            newGameTopConstraint.constant = 30
            loadFromNewConstraint.constant = 20
            highFromLoadConstraint.constant = 20
            
            newGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            loadGameButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            highScoresButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if foundGame {
            performSegue(withIdentifier: "restoreSegue", sender: nil)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func newGamePressed(_ sender: AnyObject) {
        let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "newCommander")
        self.present(vc, animated: true, completion: nil)
    }

    
    // PERSISTANCE METHODS
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    func loadAutosavedGame() -> Bool {
//        print("loadAutoavedGame firing")
//        print("this version has been disabled. Returning false.")
//        return false
        
        let path = fileInDocumentsDirectory("autosave.plist")

        if let autosaveGame = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? AutosavedGame {
//            print("autosave.plist found")

            if autosaveGame.savedCommander.endGameType != EndGameStatus.gameNotOver {
                return false
            }
            player = autosaveGame.savedCommander
            galaxy = autosaveGame.savedGalaxy
            
            return true
        } else {
//            print("loadAutosavedGame finds no autosave.plist")
            return false
        }
    }
    
}
