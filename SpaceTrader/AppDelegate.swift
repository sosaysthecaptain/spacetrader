//
//  AppDelegate.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/4/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // set tab bar tint color
        UITabBar.appearance().tintColor = mainPurple
        
        // set button bar tint color
        UINavigationBar.appearance().tintColor = mainPurple
        
        // set navigation controller font
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 20)!
        ]
        
        // set global textView font
        UITextView.appearance().font = UIFont(name: "AvenirNext-DemiBold", size: 14)!
        
        // set navigation bar button font
        let controlState = UIControlState()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 16)!], for: controlState)
        
        // THIS WAS OVERRIDING OTHER THINGS
        // set global font, used wherever not set otherwise
        //UILabel.appearance().font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        if player.endGameType == EndGameStatus.gameNotOver {
            saveState()
            saveSavedGameArchive()
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // loadState not being called here because of triggering segue issue
        // will be called from initial VC instead.
        
        loadSavedGameArchive()
        loadHighScores()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // PERSISTANCE METHODS
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    func saveState() {
        // will need to make sure game is currently active
        
//        print("saved games to be saved:")
//        for game in savedGames {
//            print(game.name)
//        }
        
        let path = fileInDocumentsDirectory("autosave.plist")
        //let autosaveGame = SavedGame(name: "Autosave", cdr: player, gxy: galaxy, gameInProgress: gameInProgress, savedGames: savedGames)
        let autosaveGame = AutosavedGame(name: "Autosave", cdr: player, gxy: galaxy, gameInProgress: gameInProgress)

        NSKeyedArchiver.archiveRootObject(autosaveGame, toFile: path)
        //print("GAME AUTOSAVED. PATH: \(path)")  // this works. Game is saving without incident
    }
    
    
    // LOADSTATE IS ABANDONED--NEW VERSION LIVES IN NewGameVC
    
    func loadSavedGameArchive() {
        
        let path = fileInDocumentsDirectory("savedGameArchive.plist")
        
        if let savedGameArchive = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SavedGameArchive {
            
            savedGames = savedGameArchive.savedGames
            
            //print("saved games recovered from archive:")
//            for game in savedGames {
//                print(game.name)
//            }
        }
        
    }
    
    func saveSavedGameArchive() {
        let path = fileInDocumentsDirectory("savedGameArchive.plist")
        let savedGameFileForArchive = SavedGameArchive(savedGames: savedGames)
        NSKeyedArchiver.archiveRootObject(savedGameFileForArchive, toFile: path)
    }
    
    func loadHighScores() {
        let path = fileInDocumentsDirectory("highScores.plist")
        
        if let highScoreArchiveTemp = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? HighScoreArchive {
            
            highScoreArchive = highScoreArchiveTemp
            
//            print("high scores recovered from archive:")
//            for score in highScoreArchive.highScores {
//                print("name: \(score.name), score: \(score.score)")
//            }
        }
    }
}




