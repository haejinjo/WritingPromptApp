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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        typeResponseTextView.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    promptLabel.text = Prompt.todaysPrompt.title
         
    } // end of viewdidload
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("cancel tapped")
            }
        }
    } // end of prepare for func

}
