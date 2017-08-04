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

    // when user taps cell, must pass the corresponding note to this VC so it can be displayed (and maybe modified? up2u)
    var response: Response?
    @IBOutlet weak var typeResponseTextView: UITextView!
    @IBOutlet weak var promptLabel: UILabel!
    var userIsComposing: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        typeResponseTextView.text = ""
        
        if let response = response {
            promptLabel.text = response.promptString
            typeResponseTextView.text = response.content
            userIsComposing = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if userIsComposing {
            promptLabel.text = Prompt.todaysPrompt.title
        }
    } // end of viewdidload
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("cancel tapped")
            } else if identifier == "save" {
                print("save tapped")
                
                
                if let response = response { // if user is modifying/viewing existing response
                    response.promptString = promptLabel.text ?? ""
                    response.content = typeResponseTextView.text ?? ""
                    
                } else { // user is composing
                    
                    // create new response instance using todays prompt and current time
                    let newResponse = Response(prompt: Prompt.todaysPrompt, modificationTime: Date())
                
                    // set new response content to whatever the user typed in
                    newResponse.content = typeResponseTextView.text ?? ""
                
                    let listResponsesViewController = segue.destination as! ListResponsesViewController

                    listResponsesViewController.responses.append(newResponse)
                }
            }
            
        }
        

        
        
    } // end of prepare for func

}
