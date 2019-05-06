//
//  DetaiViewController.swift
//  API_Demo
//
//  Created by Duc Anh on 12/6/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var myWebView: WKWebView!
    
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(myWebView)
        if let url = URL(string: urlString) {
            myWebView.load(URLRequest(url: url))
        }
    }
}
