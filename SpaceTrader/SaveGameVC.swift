//
//  SaveGameVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/15/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class SaveGameVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        // make this only work if user has entered something in the text field
        let newSavedGame = NamedSavedGame(name: textField.text!, cdr: player, gxy: galaxy)
        savedGames.append(newSavedGame)
       
        saveSavedGameArchive()
        

        
        let title = "Game Saved"
        let message = "Your game has been saved."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // go back to menu
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // PERSISTANCE METHODS
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    func saveSavedGameArchive() {
        // will need to make sure game is currently active
        
        
        let path = fileInDocumentsDirectory("savedGameArchive.plist")
        let savedGameFileForArchive = SavedGameArchive(savedGames: savedGames)
        
//        print("saved games present in global:")
//        for game in savedGames {
//            print(game.name)
//        }
//        
//        print("saved games that made it into saved array:")
//        for game in savedGameFileForArchive.savedGames {
//            print(game.name)
//        }
        
        NSKeyedArchiver.archiveRootObject(savedGameFileForArchive, toFile: path)
    }

}
