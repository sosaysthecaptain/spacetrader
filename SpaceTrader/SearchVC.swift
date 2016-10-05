//
//  SearchVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/7/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        textField.becomeFirstResponder()    // keyboard appears on load
    }

    func textFieldShouldReturn(_ textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        // do search, set either target or tracked
        let enteredString = textField.text!.lowercased()
        for planet in galaxy.planets {
            if planet.name.lowercased() == enteredString {
                galaxy.targetSystem = planet
                if !galaxy.targetSystemInRange {
                    galaxy.setTracked(planet.name)
                }
            }
        }
        navigationController?.popToRootViewController(animated: true)
        return true;
    }
}
