//
//  Mercenaries2VC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/25/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class Mercenaries2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // force navigation bar to be shown
//        var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:320, height:80))
//        self.view .addSubview(navBar)
    }


    @IBAction func donePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
