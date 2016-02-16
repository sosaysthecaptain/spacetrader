//
//  GameOverVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {
    
    var madeHighScores = false
    var score = 0

    override func viewDidLoad() {
        // set background image based on game over type
        // this can be found at player.endGameType
        
        // create HighScore object
        let newHighScore = HighScore(name: player.commanderName, status: player.endGameType, days: player.days, worth: player.netWorth, difficulty: player.difficulty)
        madeHighScores = highScoreArchive.addScore(newHighScore)
        self.score = newHighScore.score
        
        // save high scores archive to file
        saveHighScoresArchive()
        
        // autosave game, so loader will see that game is over and not try to play it again
        saveState()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // wait, display alert
        sleep(1)
        
        // sleep seems to keep this VC around for a second. Otherwise it loads and instantly dismisses
        
        var title = ""
        var message = ""
        
        // number formatter business
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        let scoreFormatted = numberFormatter.stringFromNumber(score)
        
        if madeHighScores {
            
            title = "High Score!"
            message = "You scored \(scoreFormatted!) and made the high score list."
        } else {
            title = "Score"
            message = "You scored \(scoreFormatted!). You did not make the high score list."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            print("supposed to perform segue to gameOverHighScores now")
            self.performSegueWithIdentifier("gameOverHighScores", sender: nil)
//            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HighScoresNavController")
//            self.presentViewController(vc, animated: false, completion: nil)
            
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
    
    func saveHighScoresArchive() {
        let path = fileInDocumentsDirectory("highScores.plist")
        NSKeyedArchiver.archiveRootObject(highScoreArchive, toFile: path)
    }
    
    func saveState() {
        let path = fileInDocumentsDirectory("autosave.plist")
        let autosaveGame = AutosavedGame(name: "Autosave", cdr: player, gxy: galaxy, gameInProgress: gameInProgress)
        NSKeyedArchiver.archiveRootObject(autosaveGame, toFile: path)
    }

        
        
}
