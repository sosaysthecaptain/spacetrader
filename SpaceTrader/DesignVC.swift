//
//  DesignVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/1/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class DesignVC: UIViewController {

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
    
    
    @IBAction func continueButton(sender: AnyObject) {
        // verify user entered a name
    }
    
    @IBAction func stepperWasPressed(sender: AnyObject) {
        updateUI()
    }
    

}
