//
//  PromptService.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 8/1/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireNetworkActivityIndicator
import FirebaseDatabase

// FUNCTIONALITIES
//1  static var that stores current prompt 'o the day
//2  func that renew prompt
//3  func that returns array of valid prompts from the internet
struct PromptService {
    
    
    // 1
    static var todaysPrompt: Prompt?
    
    //2
    static func getDailyPrompt(isValid: Bool) -> Prompt? {

        // return todays prompt
        
        return todaysPrompt
    }
    
    //3
    static func getAllPrompts(completion: @escaping (([Prompt])->Void)) {
        
        var promptArray: [Prompt] = []
        let apiToContact = "https://www.reddit.com/r/WritingPrompts/.json"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Loop through array of json prompts
                    for jsonObj in json["data"]["children"].arrayValue {
                        
                        // Set up reference node
                        let currentPromptData = jsonObj["data"]
                    
                        // Create Prompt object off of reference node
                        let currentPrompt: Prompt = Prompt(json: currentPromptData)
                    
                        // Remove the initial [WP] [CW] [OT], etc text from all incoming prompts
                        currentPrompt.title = currentPrompt.title.replacingOccurrences(of: "\\[[^\\]]+\\]", with: "", options: .regularExpression)
                        
                        // Only append to our array if it's a prompt
                        if currentPrompt.flairText == "Writing Prompt" {
                            promptArray.append(currentPrompt)
                        }
                        completion(promptArray)
             
                    } // FOR LOOP ENDS
                }
            case .failure(let error):
                print(error)
            }
            
        } // CLOSURE ENDS
        
    } // END OF getAllPrompts
    
    
    static func create(prompt: Prompt) {
        
        // root node of JSON dictionary
        let promptsRef = Database.database().reference().child("prompts")
        
        // generate unique prompt ID
        let promptID = promptsRef.childByAutoId()
        
        // relative path (using unique prompt ID) to where we want to write our prompt to
        let promptRef = promptsRef.child(promptID)
        
        //need to create a dictionary of the data we want to store in the database
        let dict = prompt.getDict() // NS Dict is an NSString: NSstring or NSString: NSInt
        
        // write the dictionary at the specified location
        promptRef.setValue(dict) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            completion() //escaping
        }
        
        
    }
    
} // END OF STRUCT
