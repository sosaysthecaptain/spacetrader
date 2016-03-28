//
//  DesignNaSVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/28/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class DesignNaSVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sizeLabel: StandardLabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var continueButton: PurpleButtonTurnsGray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepper.minimumValue = 0
        stepper.maximumValue = 4
        stepper.value = 2
        updateUI()
        
        // needed to recognize tap that would dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
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
    
    @IBAction func continueTapped(sender: AnyObject) {
        // verify user entered a name
        if nameTextField.text!.characters.count == 0 {
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
            player.selectedConstructShipName = nameTextField.text!
            performSegueWithIdentifier("BYOSsecondPageSegue", sender: nil)
        }
    }
    
    @IBAction func stepperWasPressed(sender: AnyObject) {
        updateUI()
    }
    
    // CALL THIS FROM stepperWasPressed
    func updateUI() {
        switch stepper.value {
            case 0:
                sizeLabel.text = "Tiny"
                player.selectedConstructShipSize = SizeType.Tiny
            case 1:
                sizeLabel.text = "Small"
                player.selectedConstructShipSize = SizeType.Small
            case 2:
                sizeLabel.text = "Medium"
                player.selectedConstructShipSize = SizeType.Medium
            case 3:
                sizeLabel.text = "Large"
                player.selectedConstructShipSize = SizeType.Large
            case 4:
                sizeLabel.text = "Huge"
                player.selectedConstructShipSize = SizeType.Huge
            default:
                print("error")
        }
    }
    
    // set back button text for child VCs to "Back"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

}
