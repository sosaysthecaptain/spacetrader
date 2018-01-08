//
//  HighScore.swift
//  SpaceTrader
//
//  Created by Marc Auger on 1/20/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import Foundation

class HighScore: NSObject, NSCoding {
    let name: String
    let status: EndGameStatus
    let days: Int
    let worth: Int
    let difficulty: DifficultyType
    var score: Int
    
    init(name: String, status: EndGameStatus, days: Int, worth: Int, difficulty: DifficultyType) {
        self.name = name
        self.status = status
        self.days = days
        self.worth = worth
        self.difficulty = difficulty
        
        // int for difficulty
        var difficultyInt: Int {
            switch difficulty {
            case DifficultyType.beginner:
                return 1
            case DifficultyType.easy:
                return 2
            case DifficultyType.normal:
                return 3
            case DifficultyType.hard:
                return 4
            case DifficultyType.impossible:
                return 5
            }
        
        }
        
        self.score = 0      // MEANS OF CALCULATING SCORE GOES HERE
        //print("calculating score. worth = \(worth), difficultyInt = \(difficultyInt), days = \(days)")
        
        if status == EndGameStatus.killed {
            //self.score = Int((0.9 * Double(worth) / Double(50000) * Double(difficultyInt))
            self.score = Int(((0.9 * Float(worth)) / 500) * Float(difficultyInt))
        } else if status == EndGameStatus.retired {
            //self.score = Int((0.95 * Double(worth) / Double(50000) * Double(difficultyInt))
            self.score = Int(((0.95 * Float(worth)) / 500) * Float(difficultyInt))
        } else {
            var d = (difficultyInt * 100) - days
            if d < 0 {
                d = 0
            }
            
            self.score = Int(difficultyInt * ((worth + (d * 1000)) / 10))
        }
        
        // avoid giving credit for dying immediately
        if self.score < 75 {
            self.score = 0
        }
        //print("score assigned to \(self.score)")
        
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.status = EndGameStatus(rawValue: decoder.decodeInteger(forKey: "status"))!
        self.days = decoder.decodeInteger(forKey: "days")
        self.worth = decoder.decodeInteger(forKey: "worth")
        self.difficulty = DifficultyType(rawValue: decoder.decodeObject(forKey: "difficulty") as! String!)!
        self.score = decoder.decodeInteger(forKey: "score")

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(name, forKey: "name")
        encoder.encode(status.rawValue, forKey: "status")
        encoder.encode(days, forKey: "days")
        encoder.encode(worth, forKey: "worth")
        encoder.encode(difficulty.rawValue, forKey: "difficulty")
        encoder.encode(score, forKey: "score")
    }
}

class HighScoreArchive: NSObject, NSCoding {
    var highScores: [HighScore]
    
    override init() {
        highScores = []
    }
    
    func sort() {
        let newArray = highScores.sorted(by: {$0.score > $1.score})       // does this work?
        highScores = newArray
        
        // delete everything after top ten
        print("initial count: \(highScores.count)")
        while highScores.count > 10 {
            highScores.remove(at: highScores.count - 1)
        }
        print("truncated. New count: \(highScores.count)")
    }
    
    func addScore(_ score: HighScore) -> Bool {
        // if score is below 100, don't bother
        if score.score < 100 {
            return false
        }
        
        // adds score, tells user if he made the high scores
        self.highScores.append(score)
        self.sort()
        
        // if lowest in highscores is not > score, return true
        var min = 99999999
        for item in self.highScores {
            if item.score < min {
                min = score.score
            }
        }
        if self.highScores.count == 0 {
            return true
        } else if min > score.score {
            return false
        }
        return true
    }
    
    // NSCODING METHODS
    required init(coder decoder: NSCoder) {
        self.highScores = decoder.decodeObject(forKey: "highScores") as! [HighScore]

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(highScores, forKey: "highScores")
    }
    
}
