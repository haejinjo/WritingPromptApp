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
    @IBOutlet weak var typeResponseTextView: UITextView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var originalPosterButton: UIButton!
    var response: Response?
    var responseIndex: Int?
    var originalPoster: String = ""
    var userIsComposing: Bool = true
    
    func openUrl(_ urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeResponseTextView.becomeFirstResponder()
        let bottom = NSMakeRange(typeResponseTextView.text.characters.count - 1, 1)
        typeResponseTextView.scrollRangeToVisible(bottom)
        
        if let response = response {
            promptLabel.text = response.promptString
            typeResponseTextView.text = response.content
            print(typeResponseTextView.text)
            userIsComposing = false
            originalPoster = response.originalPoster
        }
        
        if userIsComposing {
            promptLabel.text = Prompt.todaysPrompt.title
            originalPoster = Prompt.todaysPrompt.originalPoster
            
        }
        
        // HOW TO GET ORIGINALPOSTER PROPERTY OF THIS PROMPT OBJECT?? MUST REF THROUGH RESPONSE.PID BUT THEN WHAT??
        originalPosterButton.setImage(#imageLiteral(resourceName: "redditwriter"), for: .normal)
        
    } // END OF viewdidload
    
    // HOW TO GET ORIGINALPOSTER PROPERTY OF THIS PROMPT OBJECT?? MUST REF THROUGH RESPONSE.PID BUT THEN WHAT??
    @IBAction func originalPosterButtonTapped(_ sender: Any) {
        print("hi")
        openUrl("https://reddit.com/u/\(originalPoster)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("cancel tapped")
            } else if identifier == "save" {
                print("save tapped")
                let listResponsesViewController = segue.destination as! ListResponsesViewController
                
                // if user tapped a cell to modify existing response
                if let response = response, let index = responseIndex {
                    response.content = typeResponseTextView.text ?? ""
                    response.modificationTime = Date()
                    listResponsesViewController.responses[index] = response
                    ResponseService.update(response: response)
                    
                } else { // user came here after tapping compose so prep accordingly
                    
                    // create new Response object using todays prompt + current time + whatever user typed in textview
                    var newResponse = Response(prompt: Prompt.todaysPrompt, modificationTime: Date(), content: typeResponseTextView.text)
                    
                    newResponse = ResponseService.create(response: newResponse)              
                    
                    // make button green checkmark
                    listResponsesViewController.composeButton.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                    listResponsesViewController.composeButton.isUserInteractionEnabled = false
                    listResponsesViewController.composeButton.backgroundColor = UIColor(red:0.33, green:0.66, blue:0.29, alpha:1.0)
                    
                    listResponsesViewController.responses.append(newResponse)
                }
            }
        }
    } // END OF prepare
}
