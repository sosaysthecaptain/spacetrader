//
//  EncounterNotificationModalVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/22/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class EncounterNotificationModalVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var button1Label: UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        super.viewDidLoad()
        
        titleLabel.text = galaxy.currentJourney!.currentEncounter!.notificationTitle
        textLabel.text = galaxy.currentJourney!.currentEncounter!.notificationText
    }

    @IBAction func button1Action(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        galaxy.currentJourney!.currentEncounter!.concludeEncounter()
    }
    
}
