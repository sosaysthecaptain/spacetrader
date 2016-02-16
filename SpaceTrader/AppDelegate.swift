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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        saveState()
        saveSavedGameArchive()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // loadState not being called here because of triggering segue issue
        // will be called from initial VC instead.
        
        loadSavedGameArchive()
        loadHighScores()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // PERSISTANCE METHODS
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    func saveState() {
        // will need to make sure game is currently active
        
        print("saved games to be saved:")
        for game in savedGames {
            print(game.name)
        }
        
        let path = fileInDocumentsDirectory("autosave.plist")
        //let autosaveGame = SavedGame(name: "Autosave", cdr: player, gxy: galaxy, gameInProgress: gameInProgress, savedGames: savedGames)
        let autosaveGame = AutosavedGame(name: "Autosave", cdr: player, gxy: galaxy, gameInProgress: gameInProgress)

        NSKeyedArchiver.archiveRootObject(autosaveGame, toFile: path)
    }
    
    
    // LOADSTATE IS ABANDONED--NEW VERSION LIVES IN NewGameVC
    
    func loadSavedGameArchive() {
        let path = fileInDocumentsDirectory("savedGameArchive.plist")
        
        if let savedGameArchive = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SavedGameArchive {
            
            savedGames = savedGameArchive.savedGames
            
            print("saved games recovered from archive:")
            for game in savedGames {
                print(game.name)
            }
        }
        
    }
    
    func saveSavedGameArchive() {
        let path = fileInDocumentsDirectory("savedGameArchive.plist")
        let savedGameFileForArchive = SavedGameArchive(savedGames: savedGames)
        NSKeyedArchiver.archiveRootObject(savedGameFileForArchive, toFile: path)
    }
    
    func loadHighScores() {
        let path = fileInDocumentsDirectory("highScores.plist")
        
        if let highScoreArchiveTemp = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? HighScoreArchive {
            
            highScoreArchive = highScoreArchiveTemp
            
            print("high scores recovered from archive:")
            for score in highScoreArchive.highScores {
                print("name: \(score.name), score: \(score.score)")
            }
        }
    }
}




