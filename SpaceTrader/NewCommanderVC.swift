//
//  NewCommanderVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 9/11/15.
//  Copyright (c) 2015 Marc Auger. All rights reserved.
//

import UIKit

class NewCommanderVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var difficultyLevel: UILabel!
    @IBOutlet weak var OKButton: PurpleButtonTurnsGray!
    @IBOutlet weak var skillPoints: UILabel!
    @IBOutlet weak var pilotPoints: UILabel!
    @IBOutlet weak var fighterPoints: UILabel!
    @IBOutlet weak var traderPoints: UILabel!
    @IBOutlet weak var engineerPoints: UILabel!
    
    @IBOutlet weak var difficultyStepper: PurpleStepper!
    @IBOutlet weak var pilotStepper: PurpleStepper!
    @IBOutlet weak var fighterStepper: PurpleStepper!
    @IBOutlet weak var traderStepper: PurpleStepper!
    @IBOutlet weak var engineerStepper: PurpleStepper!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // layout constraints
    @IBOutlet weak var titleFromTopConstraint: NSLayoutConstraint!          // 20
    @IBOutlet weak var textBoxFromTopConstraint: NSLayoutConstraint!        // 70
    @IBOutlet weak var difficultyFromNameConstraint: NSLayoutConstraint!    // 30
    @IBOutlet weak var skillPointsFromRuleConstraint: NSLayoutConstraint!
    @IBOutlet weak var ruleHeightConstraint: NSLayoutConstraint!            // 45
    @IBOutlet weak var pilotFromSkillPointsConstraint: NSLayoutConstraint!              // 20
    @IBOutlet weak var fighterFromPilotConstraint: NSLayoutConstraint!      // 20
    @IBOutlet weak var traderFromFighterConstraint: NSLayoutConstraint!     // 20
    @IBOutlet weak var engineerFromTraderConstraint: NSLayoutConstraint!    // 20
    @IBOutlet weak var okButtonFromBottomConstraint: NSLayoutConstraint!    // 20

    
    
    
    
    
    // status bar hidden
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    // set dark statusBar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    let totalSkill = 20                             // sums to this
    var availableSkill = 16                         // this is skill remaining
    var name = String()
    
//    var difficulty: Int = 2 {
//        didSet {
//            // crappy kludge
//            switch difficulty {
//            case 0:
//                difficultyLevel.text = "Beginner"
//            case 1:
//                difficultyLevel.text = "Easy"
//            case 2:
//                difficultyLevel.text = "Normal"
//            case 3:
//                difficultyLevel.text = "Hard"
//            case 4:
//                difficultyLevel.text = "Impossible"
//            default:
//                difficultyLevel.text = "UH OH"
//            }
//        }
//    }
    
    @IBAction func difficultyStepperChanged(_ sender: AnyObject) {
        switch difficultyStepper.value {
            case 0:
                difficultyLevel.text = "Beginner"
            case 1:
                difficultyLevel.text = "Easy"
            case 2:
                difficultyLevel.text = "Normal"
            case 3:
                difficultyLevel.text = "Hard"
            case 4:
                difficultyLevel.text = "Impossible"
            default:
                difficultyLevel.text = "UH OH"
        }
    }
    
    
    @IBAction func pilotStepperChanged(_ sender: AnyObject) {
        stepperChanged()
    }
    
    @IBAction func fighterStepperChanged(_ sender: AnyObject) {
        stepperChanged()
    }

    
    @IBAction func traderStepperChanged(_ sender: AnyObject) {
        stepperChanged()
    }
    
    @IBAction func engineerStepperChanged(_ sender: AnyObject) {
        stepperChanged()
    }
    
    func stepperChanged() {
        // find skillPointsRemaining
        
        availableSkill = totalSkill - (Int(pilotStepper.value) + Int(fighterStepper.value) + Int(traderStepper.value) + Int(engineerStepper.value))
        
        //availableSkill = Int(pilotStepper.value) + Int(fighterStepper.value) + Int(traderStepper.value) + Int(engineerStepper.value)
        
        // set maximums--current, if no more skill points available, else 9.
        if availableSkill < 1 {
            pilotStepper.maximumValue = pilotStepper.value
        } else {
            pilotStepper.maximumValue = 9
        }
        if availableSkill < 1 {
            fighterStepper.maximumValue = fighterStepper.value
        } else {
            fighterStepper.maximumValue = 9
        }
        if availableSkill < 1 {
            traderStepper.maximumValue = traderStepper.value
        } else {
            traderStepper.maximumValue = 9
        }
        if availableSkill < 1 {
            engineerStepper.maximumValue = engineerStepper.value
        } else {
            engineerStepper.maximumValue = 9
        }
        
        // set labels
        pilotPoints.text = "\(Int(pilotStepper.value))"
        fighterPoints.text = "\(Int(fighterStepper.value))"
        traderPoints.text = "\(Int(traderStepper.value))"
        engineerPoints.text = "\(Int(engineerStepper.value))"
        
        skillPoints.text = "\(availableSkill)"
        
        // enable/disable "OK" button as appropriate
        // second condition is invisible cheat--leave it blank and get 100k
        if availableSkill == 0 || ((availableSkill == 16) && difficultyStepper.value == 2) {
            OKButton.isEnabled = true
        } else {
            OKButton.isEnabled = false
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        // set starfield background z index appropriately
        self.view.sendSubview(toBack: backgroundImage)
        
        nameField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewCommanderVC.DismissKeyboard))
        view.addGestureRecognizer(tap)

        // WIPE EXISTING GAME
        player = Commander(commanderName: "NIL", difficulty: DifficultyType.beginner, pilotSkill: 1, fighterSkill: 1, traderSkill: 1, engineerSkill: 1)
        
        // fix new commander bug, which crashes app by trying to save after only this much has been loaded
        player.endGameType = EndGameStatus.retired      // will be set to GameNotOver when commander properly instantiated
        
        galaxy = Galaxy()
        
        // set stepper values
        difficultyStepper.minimumValue = 0
        difficultyStepper.maximumValue = 4
        difficultyStepper.value = 2
        
        pilotStepper.minimumValue = 1
        pilotStepper.maximumValue = 9
        pilotStepper.value = 1
        
        fighterStepper.minimumValue = 1
        fighterStepper.maximumValue = 9
        fighterStepper.value = 1
        
        traderStepper.minimumValue = 1
        traderStepper.maximumValue = 9
        traderStepper.value = 1
        
        engineerStepper.minimumValue = 1
        engineerStepper.maximumValue = 9
        engineerStepper.value = 1
        
        // adjust sizes if needed
        let screenSize: CGRect = UIScreen.main.bounds
        
        // handle 3.5" screen
        if screenSize.height < 485 {
            titleFromTopConstraint.constant = 10
            textBoxFromTopConstraint.constant = 50
            difficultyFromNameConstraint.constant = 20
            ruleHeightConstraint.constant = 25
            skillPointsFromRuleConstraint.constant = 0
            pilotFromSkillPointsConstraint.constant = 18
            fighterFromPilotConstraint.constant = 18
            traderFromFighterConstraint.constant = 18
            engineerFromTraderConstraint.constant = 18
            okButtonFromBottomConstraint.constant = 10
            
//            @IBOutlet weak var titleFromTopConstraint: NSLayoutConstraint!          // 20
//            @IBOutlet weak var textBoxFromTopConstraint: NSLayoutConstraint!        // 70
//            @IBOutlet weak var difficultyFromNameConstraint: NSLayoutConstraint!    // 30
//            @IBOutlet weak var ruleHeightConstraint: NSLayoutConstraint!            // 45
//            @IBOutlet weak var pilotFromSkillPointsConstraint: UIView!              // 20
//            @IBOutlet weak var fighterFromPilotConstraint: NSLayoutConstraint!      // 20
//            @IBOutlet weak var traderFromFighterConstraint: NSLayoutConstraint!     // 20
//            @IBOutlet weak var engineerFromTraderConstraint: NSLayoutConstraint!    // 20
//            @IBOutlet weak var okButtonFromBottomConstraint: NSLayoutConstraint!    // 20
        }
    }
    
    @objc func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OkButton() {
        var kludgeDifficulty = DifficultyType.normal
        
        switch difficultyStepper.value {
            case 0:
                kludgeDifficulty = DifficultyType.beginner
            case 1:
                kludgeDifficulty = DifficultyType.easy
            case 2:
                kludgeDifficulty = DifficultyType.normal
            case 3:
                kludgeDifficulty = DifficultyType.hard
            case 4:
                kludgeDifficulty = DifficultyType.impossible
            default:
                print("fix difficulty switch")
            
        }
        
        // must check that information is complete--name must be present and valid.
        
        if nameField.text?.characters.count == 0 {
            name = "Sampson"
        } else {
            name = nameField.text!
        }

        player = Commander(commanderName: name, difficulty: kludgeDifficulty, pilotSkill: Int(pilotStepper.value), fighterSkill: Int(fighterStepper.value), traderSkill: Int(traderStepper.value), engineerSkill: Int(engineerStepper.value))
        player.endGameType = EndGameStatus.gameNotOver
        galaxy.createGalaxy()
        
        // give player a pulse laser
        let pulseLaser = Weapon(type: WeaponType.pulseLaser)
        player.commanderShip.weapon.append(pulseLaser)
        
        // if skill level is beginner, set the lottery special
        if player.difficulty == DifficultyType.beginner {
            galaxy.currentSystem!.specialEvent = SpecialEventID.lotteryWinner
            player.specialEvents.setSpecialEvent()      // must do this since not warping to initial system
        }
        
        // THIS IS PURELY FOR TESTING SPECIAL EVENTS
        if player.difficulty == DifficultyType.normal {
            //galaxy.currentSystem!.specialEvent = SpecialEventID.alienArtifact
            //player.specialEvents.setSpecialEvent()
        }
        
        // THIS IS THE PLACE TO SET THINGS DIFFERENTLY FOR TESTING*******************************
        //galaxy.currentSystem!.specialEvent = SpecialEventID.princessQonos
        //galaxy.setSpecial("Utopia", id: SpecialEventID.retirement)


        
        // dragonfly at zalkon
//        for system in galaxy.planets {
//            if system.name == "Zalkon" {
//                //system.specialEvent = SpecialEventID.scarabIsDestroyed
//                system.dragonflyIsHere = true
//            }
//        }
        
        //player.policeRecord = PoliceRecordType.dubiousScore
        
        //player.escapePod = true
//
//        
//        
//        let bigShip = SpaceShip(type: ShipType.wasp, IFFStatus: IFFStatusType.Player)
//        player.commanderShip = bigShip
//
//        player.portableSingularity = true
//        player.permanentPortableSingularity = true
//
//        let reflectiveShield = Shield(type: ShieldType.reflectiveShield)
//        reflectiveShield.currentStrength = reflectiveShield.power // / 2
//        player.commanderShip.shield.append(reflectiveShield)
//        player.commanderShip.shield.append(reflectiveShield)
//
        //player.commanderShip.hull = 132
//        
//        let photonDisruptor = Weapon(type: WeaponType.photonDisruptor)
//        let militaryLaser = Weapon(type: WeaponType.militaryLaser)
//        let laser = Weapon(type: WeaponType.pulseLaser)
        //player.commanderShip.weapon.append(laser)
        //player.commanderShip.weapon.append(photonDisruptor)
//        player.commanderShip.weapon.append(militaryLaser)
//        player.commanderShip.weapon.append(militaryLaser)
//        player.commanderShip.weapon.append(militaryLaser)
//
//        let zeethibal = CrewMember(ID: MercenaryName.zeethibal, pilot: 9, fighter: 9, trader: 9, engineer: 9)
//        player.commanderShip.crew.append(zeethibal)
//
//        player.policeRecord = PoliceRecordType.heroScore
//
//
//        player.credits = 500000     // for testing, give player money
//
        // testing tribbles
        //player.commanderShip.tribbles = 1000

        
        // END TESTING STUFF ********************************************************************
        
        
        
        // segue should probably not be "show". Talk to steph about this.
        self.performSegue(withIdentifier: "newCommanderToMain", sender: nil)
    }



    
    // REMAINING ISSUES:
    // - done button on keyboard must make keyboard go away
    // (- very crappy implementation of difficulty label)
    // (- everything about the view)
    // - ok button

    
}
