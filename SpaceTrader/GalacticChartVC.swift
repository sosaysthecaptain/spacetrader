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
    @IBOutlet weak var portableSingularityJump: GrayButtonVanishes!
    
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        // enable jump button if player has a portable singularity
        if player.portableSingularity {
            portableSingularityJump.isEnabled = true
        } else {
            portableSingularityJump.isEnabled = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(GalacticChartVC.messageHandler(_:)), name: NSNotification.Name(rawValue: "singularityWarpSegueNotification"), object: nil)
    }
    
    @objc func messageHandler(_ notification: Notification) {
        // force load the VC, to avoid getting tied up in the nav controller
        
        let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "warpViewVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeButton() {
        self.dismiss(animated: true, completion: nil)
    }

    func targetSystemDidChange() {
        galacticChart.redrawSelf()
        shortRangeChart.redrawSelf()
        targetSystemLabel.text = "\(galaxy.targetSystem!.name)"
        
        // if target system is current system or in range, disable jump if enable
        if galaxy.targetSystemInRange || (galaxy.currentSystem!.name == galaxy.targetSystem!.name) {
            portableSingularityJump.isEnabled = false
        } else {
            // otherwise enable it, but only if the player has a portable singularity
            if player.portableSingularity {
                portableSingularityJump.isEnabled = true
            } else {
                portableSingularityJump.isEnabled = false
            }
        }
    }
    
    @IBAction func usePortableSinglularity(_ sender: AnyObject) {
        let title = "Use Portable Singularity"
        let message = "Are you sure you want to use your portable singularity?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
            self.warpByPortableSingularity()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // nothing, dismiss alert
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func warpByPortableSingularity() {
        travelBySingularity = true
        galaxy.warpWithSingularity()
    }
}
