//
//  DetaiViewController.swift
//  API_Demo
//
//  Created by Duc Anh on 12/6/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit
import WebKit

class DetaiViewController: UIViewController {
    
    var urlString = ""
        @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(myWebView)
        if let url = URL(string: urlString) {
            myWebView.load(URLRequest(url: url))
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
