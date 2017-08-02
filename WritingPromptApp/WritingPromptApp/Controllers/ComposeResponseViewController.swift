//
//  ComposeResponseViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/31/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireNetworkActivityIndicator

class ComposeResponseViewController: UIViewController {

    @IBOutlet weak var typeResponseTextView: UITextView!
    @IBOutlet weak var promptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    promptLabel.text = PromptService.todaysPrompt?.title
        
        
//        promptLabel.numberOfLines = 0
//        promptLabel.lineBreakMode = .byWordWrapping
//        promptLabel.frame.size.width = 300
//        promptLabel.sizeToFit()
        
    } // end of viewdidload
}
