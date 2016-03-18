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
    

    
    
    //@IBOutlet weak var backgroundImage: UIImageView!
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    // set dark statusBar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    @IBAction func difficultyStepperChanged(sender: AnyObject) {
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
    
    
    @IBAction func pilotStepperChanged(sender: AnyObject) {
        stepperChanged()
    }
    
    @IBAction func fighterStepperChanged(sender: AnyObject) {
        stepperChanged()
    }

    
    @IBAction func traderStepperChanged(sender: AnyObject) {
        stepperChanged()
    }
    
    @IBAction func engineerStepperChanged(sender: AnyObject) {
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        // set starfield background z index appropriately
        //self.view.sendSubviewToBack(backgroundImage)
        
        nameField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

        // WIPE EXISTING GAME
        player = Commander(commanderName: "NIL", difficulty: DifficultyType.beginner, pilotSkill: 1, fighterSkill: 1, traderSkill: 1, engineerSkill: 1)
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
    }
    
    func DismissKeyboard(){
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
        
        if nameField.text == nil {
            name = "Sampson"
        } else {
            name = nameField.text!
        }

        player = Commander(commanderName: name, difficulty: kludgeDifficulty, pilotSkill: Int(pilotStepper.value), fighterSkill: Int(fighterStepper.value), traderSkill: Int(traderStepper.value), engineerSkill: Int(engineerStepper.value))
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
            galaxy.currentSystem!.specialEvent = SpecialEventID.spaceMonster
            player.specialEvents.setSpecialEvent()
        }
        
        // THIS IS THE PLACE TO SET THINGS DIFFERENTLY FOR TESTING*******************************
        
        //player.policeRecord = PoliceRecordType.dubiousScore
        
        player.escapePod = true
        
        
        
        let bigShip = SpaceShip(type: ShipType.Grasshopper, IFFStatus: IFFStatusType.Player)
        player.commanderShip = bigShip
        
        let reflectiveShield = Shield(type: ShieldType.reflectiveShield)
//        reflectiveShield.currentStrength = reflectiveShield.power // / 2
        player.commanderShip.shield.append(reflectiveShield)
        
        //player.commanderShip.hull = 50
        
        let photonDisruptor = Weapon(type: WeaponType.photonDisruptor)
        let beamLaser = Weapon(type: WeaponType.beamLaser)
        player.commanderShip.weapon.append(photonDisruptor)
        player.commanderShip.weapon.append(beamLaser)
//
//        let reflectiveShield = Shield(type: ShieldType.reflectiveShield)
//        reflectiveShield.currentStrength = reflectiveShield.power
//        player.commanderShip.shield.append(reflectiveShield)
        
        let zeethibal = CrewMember(ID: MercenaryName.zeethibal, pilot: 9, fighter: 9, trader: 9, engineer: 9)
        player.commanderShip.crew.append(zeethibal)
        
        //player.policeRecord = PoliceRecordType.heroScore
        
        
        player.credits = 1000000     // for testing, give player money

        
        // END TESTING STUFF ********************************************************************
        
        
        
        // segue should probably not be "show". Talk to steph about this.
        self.performSegueWithIdentifier("newCommanderToMain", sender: nil)
    }



    
    // REMAINING ISSUES:
    // - done button on keyboard must make keyboard go away
    // (- very crappy implementation of difficulty label)
    // (- everything about the view)
    // - ok button

    
}
