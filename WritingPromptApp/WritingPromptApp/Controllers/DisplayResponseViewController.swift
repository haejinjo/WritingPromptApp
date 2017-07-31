//
//  DisplayResponseViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/31/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import UIKit

class DisplayResponseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "backFromResponse" {
                print("X button tapped")
            }
        }
    } // end of prepare for func

}
