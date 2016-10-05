//
//  SaveGameVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/15/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class SaveGameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        
        // set up textField delegate
        textField.delegate = self
        
        // initially set save button to inactive, since there can't be any text in the textField yet
        saveButton.isEnabled = false
    }

    // when textField edited, see if chars, if so enable save button
    @IBAction func textFieldWasEdited(_ sender: AnyObject) {
        if textField.text!.characters.count > 0 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    // dismiss keyboard on "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // dismiss keyboard when tap on background
//    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        textField.resignFirstResponder()
//        self.view.endEditing(true)
//    }
    
    
    @IBAction func saveButton(_ sender: AnyObject) {
        // make this only work if user has entered something in the text field
        let newSavedGame = NamedSavedGame(name: textField.text!, cdr: player, gxy: galaxy)
        savedGames.append(newSavedGame)
       
        saveSavedGameArchive()
        

        
        let title = "Game Saved"
        let message = "Your game has been saved."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // go back to menu
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // PERSISTANCE METHODS
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
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
