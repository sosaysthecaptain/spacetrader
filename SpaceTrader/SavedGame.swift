//
//  SavedGame.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/15/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import Foundation

class AutosavedGame: NSObject, NSCoding {
    // autosave stuff
    var name: String = ""
    //let timestamp:
    
    var savedCommander: Commander
    var savedGalaxy: Galaxy
    var gameInProgress: Bool
    
    init(name: String, cdr: Commander, gxy: Galaxy, gameInProgress: Bool) {
        self.name = name
        self.savedCommander = cdr
        self.savedGalaxy = gxy
        self.gameInProgress = gameInProgress
        
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.savedCommander = decoder.decodeObject(forKey: "savedCommander") as! Commander
        self.savedGalaxy = decoder.decodeObject(forKey: "savedGalaxy") as! Galaxy
        self.gameInProgress = decoder.decodeBool(forKey: "gameInProgress")

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(name, forKey: "name")
        encoder.encode(savedCommander, forKey: "savedCommander")
        encoder.encode(savedGalaxy, forKey: "savedGalaxy")
        encoder.encode(gameInProgress, forKey: "gameInProgress")
    }
}

class NamedSavedGame: NSObject, NSCoding {
    var name: String = ""
    // timestamp
    var savedCommander: Commander
    var savedGalaxy: Galaxy
    
    init(name: String, cdr: Commander, gxy: Galaxy) {
        self.name = name
        self.savedCommander = cdr
        self.savedGalaxy = gxy
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.savedCommander = decoder.decodeObject(forKey: "savedCommander") as! Commander
        self.savedGalaxy = decoder.decodeObject(forKey: "savedGalaxy") as! Galaxy
        
        super.init()
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(name, forKey: "name")
        encoder.encode(savedCommander, forKey: "savedCommander")
        encoder.encode(savedGalaxy, forKey: "savedGalaxy")
    }

}

class SavedGameArchive: NSObject, NSCoding {
    var savedGames: [NamedSavedGame]
    
    init(savedGames: [NamedSavedGame]) {
        self.savedGames = savedGames
    }
    
    required init(coder decoder: NSCoder) {
        self.savedGames = decoder.decodeObject(forKey: "savedGames") as! [NamedSavedGame]
        
        super.init()
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(savedGames, forKey: "savedGames")
    }
}
