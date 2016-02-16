//
//  GalacticChartVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/9/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit

class GalacticChartVC: UIViewController, ShortRangeChartDelegate {
    
    @IBOutlet weak var targetSystemLabel: UILabel!
    @IBOutlet weak var portableSingularityJump: CustomButton!
    
    
    override func viewDidAppear(animated: Bool) {
        targetSystemDidChange()
    }
    
    
    @IBOutlet weak var galacticChart: GalacticChartView! {
        didSet {
            galacticChart.delegate = self
        }
    }
    @IBOutlet weak var shortRangeChart: ShortRangeChartView! {
        didSet {
            shortRangeChart.delegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        if player.portableSingularity {
            portableSingularityJump.enabled = true
        } else {
            portableSingularityJump.enabled = false
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageHandler:", name: "singularityWarpSegueNotification", object: nil)
    }
    
    func messageHandler(notification: NSNotification) {
        // force load the VC, to avoid getting tied up in the nav controller
        
        let vc : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("warpViewVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func targetSystemDidChange() {
        galacticChart.redrawSelf()
        shortRangeChart.redrawSelf()
        targetSystemLabel.text = "Target System: \(galaxy.targetSystem!.name)"
    }
    
    @IBAction func usePortableSinglularity(sender: AnyObject) {
        let title = "Use Portable Singularity"
        let message = "Are you sure you want to use your portable singularity?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
            self.warpByPortableSingularity()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // nothing, dismiss alert
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func warpByPortableSingularity() {
        travelBySingularity = true
        galaxy.warpWithSingularity()
    }
}
