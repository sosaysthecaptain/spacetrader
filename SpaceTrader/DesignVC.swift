//
//  DesignVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/1/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class DesignVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var sizeSpecialtyLabel: UILabel!
    @IBOutlet weak var skillSpecialtyLabel: UILabel!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView3: UITextView!
    
    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    func updateUI() {
        // set intro text
        textView1.text = "Welcome to \(galaxy.currentSystem!.shipyard.rawValue) Shipyards! Our best engineer, \(galaxy.currentSystem!.shipyardEngineer.rawValue), is at your service."
        
        // set image
        let logoCorellian = UIImage(named: "sy-corellian")!
        let logoIncom = UIImage(named: "sy-incom")!
        let logoKuat = UIImage(named: "sy-kuat")!
        let logoSienar = UIImage(named: "sy-sienar")!
        let logoSorosuub = UIImage(named: "sy-sorosuub")!
        
        switch galaxy.currentSystem!.shipyard {
            case ShipyardID.corellian:
                logoView.image = logoCorellian
            case ShipyardID.incom:
                logoView.image = logoIncom
            case ShipyardID.kuat:
                logoView.image = logoKuat
            case ShipyardID.sienar:
                logoView.image = logoSienar
            case ShipyardID.sorosuub:
                logoView.image = logoSorosuub
            default:
                print("error")
        }
        
        // set size & skill labels
        sizeSpecialtyLabel.text = galaxy.currentSystem!.shipyardSizeSpecialty.rawValue
        skillSpecialtyLabel.text = galaxy.currentSystem!.shipyardSkill.rawValue
        
        // set explanation line
        //textView2.text = "THIS NOT IMPLEMENTED EITHER"
        switch galaxy.currentSystem!.shipyardSkill {
            case ShipyardSkills.crew:
                textView2.text = "\(ShipyardSkillDescriptions.crew.rawValue)"
            case ShipyardSkills.fuel:
                textView2.text = "\(ShipyardSkillDescriptions.fuel.rawValue)"
            case ShipyardSkills.hull:
                textView2.text = "\(ShipyardSkillDescriptions.hull.rawValue)"
            case ShipyardSkills.shielding:
                textView2.text = "\(ShipyardSkillDescriptions.shielding.rawValue)"
            case ShipyardSkills.weaponry:
                textView2.text = "\(ShipyardSkillDescriptions.weaponry.rawValue)"
            default:
                print("error")
        }
    }
    
    // called by tap gesture recognizer, dismisses keyboard
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // delegate protocol that makes the return button close the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // set back button text for child VCs to "Back"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

}
