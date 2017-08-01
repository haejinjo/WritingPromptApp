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

        // Figure out how to get total count of hot prompts
        let randomIndex: Int = Int(arc4random_uniform(20))
        
        let apiToContact = "https://www.reddit.com/r/WritingPrompts/.json"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let randomPromptData = json["data"]["children"][randomIndex]["data"]
                    
                    let randomPrompt: Prompt = Prompt(json: randomPromptData)
                    
                    self.promptLabel.text = randomPrompt.title
                    
                    print("\(randomPrompt.originalPoster)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
