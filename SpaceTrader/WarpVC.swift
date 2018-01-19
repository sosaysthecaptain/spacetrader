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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // layout constraints
    @IBOutlet weak var ruleViewHeight: NSLayoutConstraint!  // 18-45
    @IBOutlet weak var spacerHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewfromGalacticChartConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shortRangeChartHeightConstraint: NSLayoutConstraint!
    
    
    
    
    @IBAction func cycleBackwards() {
        if galaxy.systemsInRange.count < 2 {
            fuelAlert()
        }
        
        galaxy.cycleBackward()
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    @IBAction func cycleForwards() {
        if galaxy.systemsInRange.count < 2 {
            fuelAlert()
        }
        
        galaxy.cycleForward()
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    func fuelAlert() {
        let title = "Fuel Needed"
        let message = "You do not have enough fuel to reach any other system."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
            (alert: UIAlertAction!) -> Void in
            // do nothing
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func warpButton() {
        if galaxy.targetSystemInRange {
            // if button read "Warp"
            // check if grounded, otherwise warp
            if player.grounded {
                let title = "Large Debt"
                let message = "Your debt is too large. You are not allowed to leave this system until your debt is lowered."
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default ,handler: {
                    (alert: UIAlertAction!) -> Void in
                    // do nothing
                }))
                self.present(alertController, animated: true, completion: nil)
            } else {
                galaxy.warp()
                updateView()
                shortRangeChart.redrawSelf()
            }
        } else {
            // if button read "Track"
            galaxy.setTracked(galaxy.targetSystem!.name)
            updateView()
            shortRangeChart.redrawSelf()
        }
    }
    
    @IBAction func galacticChartButton(_ sender: AnyObject) {
        
    }

    

    override func viewDidLoad() {
        
        updateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(WarpVC.messageHandler(_:)), name: NSNotification.Name(rawValue: "fireWarpViewSegueNotification"), object: nil)
    }
    
    @objc func messageHandler(_ notification: Notification) {
        performSegue(withIdentifier: "warpScreenSegue", sender: nil)
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
            warpButtonLabel.setTitle("Warp", for: controlState)
        } else {
            let controlState = UIControlState()
            warpButtonLabel.setTitle("Track", for: controlState)
        }
        
        // disable "warp" button if targetSystem == currentSystem
        if galaxy.targetSystem!.name == galaxy.currentSystem!.name {
            warpButtonLabel.isEnabled = false
        } else {
            warpButtonLabel.isEnabled = true
        }
        
        // set "Untracked" to enabled only if a system is tracked
        if galaxy.trackedSystem != nil {
            untrackButtonLabel.isEnabled = true
        } else {
            untrackButtonLabel.isEnabled = false
        }
        
        // shrink text to accomodate small screen
        let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.width < 350 {
            targetSystemLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
        }
        
        // for larger screens, expand rule, make things not cramped
        if screenSize.height > 660 {
            ruleViewHeight.constant = 45
            spacerHeight.constant = 15
            scrollViewfromGalacticChartConstraint.constant = 15
        }
        
        // for 4s, adjust things
        if screenSize.height < 490 {
            print("displaying short range chart on 3.5 inch screen")
            shortRangeChartHeightConstraint.constant = 150 // (rather than 200)
        }
        
        // bring untrack and warp button labels in front of scrollView
        self.view.bringSubview(toFront: warpButtonLabel)
        self.view.bringSubview(toFront: untrackButtonLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if galaxy.justArrived {
//            galaxy.justArrived = false
//            self.tabBarController?.selectedIndex = 0
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if galaxy.justArrived {
            galaxy.justArrived = false
            self.tabBarController?.selectedIndex = 0
        }
        
        updateView()
        shortRangeChart.redrawSelf()
        
        // return scrollView to top
        let topScrollPoint = CGPoint(x: 0.0, y: -60.0)
        scrollView.setContentOffset(topScrollPoint, animated: false)
    }
    
    func targetSystemDidChange() {
        updateView()
    }
    
    @IBAction func untrackPressed(_ sender: AnyObject) {
        // set tracked system to nil, update both view and chart
        galaxy.trackedSystem = nil
        updateView()
        shortRangeChart.redrawSelf()
    }
    
    
}
