//
//  AboutVC.swift
//  SpaceTrader
//
//  Created by Marc Auger on 3/1/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        loadWebView()
    }
    
    func loadWebView() {
        let myURL = Bundle.main.url(forResource: "AboutCreditstext", withExtension: "html")
        let requestObj = URLRequest(url: myURL!)
        webView.loadRequest(requestObj)
    }


}
