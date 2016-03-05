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
    
    @IBOutlet weak var shipNameTextField: UITextField!
    @IBOutlet weak var shipSizeLabel: UILabel!
    @IBOutlet weak var sizeStepper: UIStepper!
    
    let sizes = ["Tiny", "Small", "Medium", "Large", "Huge"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // needed to recognize tap that would dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        sizeStepper.value = 1
        updateUI()
    }

    func updateUI() {
        switch sizeStepper.value {
            case 0:
                shipSizeLabel.text = "Tiny"
                player.selectedConstructShipSize = SizeType.Tiny
            case 1:
                shipSizeLabel.text = "Small"
                player.selectedConstructShipSize = SizeType.Small
            case 2:
                shipSizeLabel.text = "Medium"
                player.selectedConstructShipSize = SizeType.Medium
            case 3:
                shipSizeLabel.text = "Large"
                player.selectedConstructShipSize = SizeType.Large
            case 4:
                shipSizeLabel.text = "Huge"
                player.selectedConstructShipSize = SizeType.Huge
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func continueButton(sender: AnyObject) {
        // verify user entered a name
        if shipNameTextField.text!.characters.count == 0 {
            // alert, need to specify a name before proceeding
            let title = "Enter a Name"
            let message = "To proceed, please enter a name for your new ship."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ,handler: {
                (alert: UIAlertAction!) -> Void in
                // do nothing
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // if name entered, set name & go to second page
            player.selectedConstructShipName = shipNameTextField.text!
            performSegueWithIdentifier("BYOSsecondPageSegue", sender: nil)
        }
    }
    
    @IBAction func stepperWasPressed(sender: AnyObject) {
        updateUI()
    }
    

}
