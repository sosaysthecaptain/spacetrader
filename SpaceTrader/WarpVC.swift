//
//  WarpVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 10/3/15.
//  Copyright © 2015 Marc Auger. All rights reserved.
//

import UIKit


class WarpVC: UIViewController, ShortRangeChartDelegate {

    @IBOutlet weak var shortRangeChart: ShortRangeChartView! {
        didSet {
            shortRangeChart.delegate = self
        }
    }
    
    @IBOutlet weak var targetSystemLabel: UILabel!
    //@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var techLevelLabel: UILabel!
    @IBOutlet weak var governmentLabel: UILabel!
    @IBOutlet weak var resourceLabel: UILabel!
    @IBOutlet weak var policeLabel: UILabel!
    @IBOutlet weak var piratesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var warpButtonLabel: PurpleButtonTurnsGray!
    @IBOutlet weak var untrackButtonLabel: GrayButtonVanishes!
    
    @IBAction func cycleBackwards() {
        galaxy.cycleBackward()
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    @IBAction func cycleForwards() {
        galaxy.cycleForward()
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    @IBAction func warpButton() {
        if galaxy.targetSystemInRange {
            // if button read "Warp"
            galaxy.warp()
            updateView()
            shortRangeChart.redrawSelf()
        } else {
            // if button read "Track"
            galaxy.setTracked(galaxy.targetSystem!.name)
            updateView()
            shortRangeChart.redrawSelf()
        }
    }
    
    @IBAction func galacticChartButton(sender: AnyObject) {
        
    }

    

    override func viewDidLoad() {
        
        updateView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageHandler:", name: "fireWarpViewSegueNotification", object: nil)
    }
    
    func messageHandler(notification: NSNotification) {
        performSegueWithIdentifier("warpScreenSegue", sender: nil)
    }
    
    func updateView() {
        let politics = Politics(type: galaxy.targetSystem!.politics)
        
        //nameLabel.text = galaxy.targetSystem!.name
        targetSystemLabel.text = "Target system: \(galaxy.targetSystem!.name)"
        sizeLabel.text = galaxy.targetSystem!.size.rawValue
        techLevelLabel.text = galaxy.targetSystem!.techLevel.rawValue
        governmentLabel.text = galaxy.targetSystem!.politics.rawValue
        resourceLabel.text = galaxy.targetSystem!.specialResources.rawValue
        policeLabel.text = galaxy.getActivityForInt(politics.activityPolice)
        piratesLabel.text = galaxy.getActivityForInt(politics.activityPirates)
        distanceLabel.text = "\(galaxy.getDistance(galaxy.currentSystem!, system2: galaxy.targetSystem!))"
        
        // turn "warp" button into "track" button if system is out of range
        if galaxy.targetSystemInRange {
            let controlState = UIControlState()
            warpButtonLabel.setTitle("Warp", forState: controlState)
        } else {
            let controlState = UIControlState()
            warpButtonLabel.setTitle("Track", forState: controlState)
        }
        
        // disable "warp" button if targetSystem == currentSystem
        if galaxy.targetSystem!.name == galaxy.currentSystem!.name {
            warpButtonLabel.enabled = false
        } else {
            warpButtonLabel.enabled = true
        }
        
        // set "Untracked" to enabled only if a system is tracked
        if galaxy.trackedSystem != nil {
            untrackButtonLabel.enabled = true
        } else {
            untrackButtonLabel.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    func targetSystemDidChange() {
        updateView()
    }
    
    @IBAction func untrackPressed(sender: AnyObject) {
        // set tracked system to nil, update both view and chart
        galaxy.trackedSystem = nil
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    
}
