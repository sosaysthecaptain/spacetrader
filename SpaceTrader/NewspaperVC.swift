//
//  NewspaperVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 12/2/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class NewspaperVC: UIViewController {

    @IBOutlet weak var newspaperTitleLabel: UILabel!
    @IBOutlet weak var story1TextView: UITextView!
    @IBOutlet weak var story2TextView: UITextView!
    @IBOutlet weak var story3TextView: UITextView!
    @IBOutlet weak var story4TextView: UITextView!
    @IBOutlet weak var story5TextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        newspaperTitleLabel.text = galaxy.currentSystem!.localNewspaperTitle
        story1TextView.text = galaxy.currentSystem!.newspaper.stories[0]
        story2TextView.text = galaxy.currentSystem!.newspaper.stories[1]
        story3TextView.text = galaxy.currentSystem!.newspaper.stories[2]
        story4TextView.text = galaxy.currentSystem!.newspaper.stories[3]
        story5TextView.text = galaxy.currentSystem!.newspaper.stories[4]
    }

    @IBAction func doneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }


}
