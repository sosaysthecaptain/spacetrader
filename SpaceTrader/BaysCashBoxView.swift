//
//  BaysCashBoxView.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/11/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class BaysCashBoxView: UIView {

    // USAGE:
    // view should be drawn to edges (not margins), constrained, and should be 45 high. This includes upper margin.
    // hook up, call redrawSelf() to update labels
    
    override func draw(_ rect: CGRect) {
        // clear everything, so it doesn't just write over previous version
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        // define constants
        let bottom: CGFloat = self.bounds.height - 10
        let top: CGFloat = 10
        let leftEdge: CGFloat = 14
        let rightEdge: CGFloat = self.bounds.width - 14
        
        let boxHeight: CGFloat = 30
        let boxSpacing: CGFloat = 10
        let boxWidth = (rightEdge - leftEdge - boxSpacing) / 2
        
        // define bays box corners
        let baysLeftBottom = CGPoint(x: leftEdge, y: bottom)
        let baysLeftTop = CGPoint(x: leftEdge, y: bottom - boxHeight)
        let baysRightTop = CGPoint(x: leftEdge + boxWidth, y: bottom - boxHeight)
        let baysRightBottom = CGPoint(x: leftEdge + boxWidth, y: bottom)
        
        // draw bays box
        let baysBoxBorder = UIBezierPath()
        baysBoxBorder.move(to: baysLeftBottom)
        baysBoxBorder.addLine(to: baysLeftTop)
        baysBoxBorder.addLine(to: baysRightTop)
        baysBoxBorder.addLine(to: baysRightBottom)
        baysBoxBorder.addLine(to: baysLeftBottom)
        baysBoxBorder.addLine(to: baysLeftTop)       // one more to clean up corner
        baysBoxBorder.lineWidth = 1
        textGray.setStroke()
        baysBoxBorder.stroke()
        
        // define cash box corners
        let cashRightBottom = CGPoint(x: rightEdge, y: bottom)
        let cashRightTop = CGPoint(x: rightEdge, y: bottom - boxHeight)
        let cashLeftTop = CGPoint(x: rightEdge - boxWidth, y: bottom - boxHeight)
        let cashLeftBottom = CGPoint(x: rightEdge - boxWidth, y: bottom)
        
        // draw cash box
        let cashBoxBorder = UIBezierPath()
        cashBoxBorder.move(to: cashLeftBottom)
        cashBoxBorder.addLine(to: cashLeftTop)
        cashBoxBorder.addLine(to: cashRightTop)
        cashBoxBorder.addLine(to: cashRightBottom)
        cashBoxBorder.addLine(to: cashLeftBottom)
        cashBoxBorder.addLine(to: cashLeftTop)       // one more to clean up corner
        cashBoxBorder.lineWidth = 1
        textGray.setStroke()
        cashBoxBorder.stroke()
        
        // establish locations for text
        let baysBoxCenterpoint = CGPoint(x: (leftEdge + (boxWidth / 2)), y: (bottom - (boxHeight / 2)))
        let cashBoxCenterpoint = CGPoint(x: (rightEdge - (boxWidth / 2)), y: (bottom - (boxHeight / 2)))
        
        let baysLabelLocation = CGPoint(x: baysBoxCenterpoint.x - 50, y: baysBoxCenterpoint.y - 15)
        let cashLabelLocation = CGPoint(x: cashBoxCenterpoint.x - 50, y: cashBoxCenterpoint.y - 15)
        
        
        // label text
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let cashFormatted = numberFormatter.string(from: NSNumber(value: player.credits))!
        
        let baysLabelText = "Bays: \(player.commanderShip.baysFilled)/\(player.commanderShip.totalBays)"
        let cashLabelText = "\(cashFormatted) cr."
        
        // create UILabels
        let baysLabel = UILabel(frame: CGRect(origin: baysLabelLocation, size: CGSize(width: 100, height: 30)))
        baysLabel.text = baysLabelText
        baysLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        baysLabel.textAlignment = NSTextAlignment.center
        //cashLabel.backgroundColor = UIColor.greenColor()        // testing only
        baysLabel.textColor = textGray
        self.addSubview(baysLabel)
        
        let cashLabel = UILabel(frame: CGRect(origin: cashLabelLocation, size: CGSize(width: 100, height: 30)))
        cashLabel.text = cashLabelText
        cashLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        cashLabel.textAlignment = NSTextAlignment.center
        cashLabel.textColor = textGray
        self.addSubview(cashLabel)
    }
    
    func redrawSelf() {
        self.setNeedsDisplay()
    }

}
