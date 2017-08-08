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


// THIS VC WILL EITHER CONTAIN A TODAYS NEEW PROMPT CANVAS or A VIEW OF A PREVIOUSLY RESPONDED-TO PROMPT
class ComposeResponseViewController: UIViewController {

    // when user taps cell, must pass the corresponding response to this VC so it can be displayed (and maybe modified? up2u)
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
    } // END OF viewdidload
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("cancel tapped")
            } else if identifier == "save" {
                print("save tapped")
                
                
                // if user tapped a cell to modify existing response
                if let response = response {
                    response.content = typeResponseTextView.text ?? ""
                    
                    
                } else { // user tapped compose so prep accordingly
                    
                    // create new Response object using todays prompt + current time + whatever user typed in textview
                    var newResponse = Response(prompt: Prompt.todaysPrompt, modificationTime: Date(), content: typeResponseTextView.text)
                    
                    newResponse = ResponseService.create(response: newResponse)
                
                    let listResponsesViewController = segue.destination as! ListResponsesViewController

                    listResponsesViewController.responses.append(newResponse)
                }
            }
            
        }
        

        
        
    } // END OF prepare

}
