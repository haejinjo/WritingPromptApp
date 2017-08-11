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

    // overkill since repeating prompts ok for this version, but keep it for now
    static func getAllPrompts(completion: @escaping ([Prompt])->Void) {
        
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
                    
                        // Remove the initial "[WP] [CW] [OT]" etc text from all incoming prompts
                        currentPrompt.title = currentPrompt.title.replacingOccurrences(of: "\\[[^\\]]+\\]", with: "", options: .regularExpression)
                        
                        // Only append to our array if it's a prompt
                        if currentPromptData["link_flair_text"] == "Writing Prompt" {
                            promptArray.append(currentPrompt)
                        }
                    } // FOR LOOP ENDS
                    
                    completion(promptArray)
                }
                
            case .failure(let error): break
//                print(error)
            }
            
        } // CLOSURE ENDS
        
    } // END OF getAllPrompts
    
    
    static func create(prompt: Prompt) -> Prompt {
        
        // root node of JSON dictionary
        let promptsRef = Database.database().reference().child("prompts")
        
        // relative path to a generated unique ID node where we want to write our prompt to
        let promptRef = promptsRef.childByAutoId()
   
        // need to create a dictionary of the data we want to store in the database
        let dict = prompt.getDict() // NS Dict is an NSString: NSstring or NSString: NSInt
        
        // write the dictionary at the specified location
        promptRef.setValue(dict) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        
        prompt.pid = promptRef.key
        
        return prompt
    }
    
    
    static func retrieve(completion: @escaping (Prompt?) -> Void) {
        
        let promptsRef = Database.database().reference().child("prompts")
        
        let newestPromptQuery = promptsRef.queryOrdered(byChild: "expyDate").queryLimited(toLast: 1)
        
        
        newestPromptQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            for promptSnapshot in snapshot.children {
                if let prompt = Prompt(snapshot: promptSnapshot as! DataSnapshot) {
                    completion(prompt)
                } else {
                    completion(nil)
                }
            } // end of trivial "loop" thru 1-element snapshot array
        }) //end of closure
        
    } //end of retrieve function
    
    static func getPrompt(withIdentifier: String, completion: @escaping (Prompt?) -> Void)
    {
        Database.database().reference().child("prompts").child(withIdentifier).observeSingleEvent(of: .value, with: { (returnedSnapshot) in
            completion(Prompt(snapshot: returnedSnapshot))
        })
    }
    
    static func getTodaysPrompt(with completion: @escaping (Void) -> Void) {
        // TIME SETUP HERE BECAUSE WILL CALL THIS FUNC IN LISTREPONSES VC WHICH USERS MUST GO THROUGH
        let nowInSeconds: Int = Int(Date().timeIntervalSince1970)
        let numDays:Int = nowInSeconds/Constants.Time.secondsPerDay
        
        let todayMidnight: Int = numDays * Constants.Time.secondsPerDay
        let tomorrowMidnight: Int = todayMidnight + Constants.Time.secondsPerDay
        
        
        // grab most the most recent prompt from firebase database
        retrieve() { (prompt) in
           
            if let promptFromFirebase = prompt {
                
                // is this one expired?
                if promptFromFirebase.isOlderThan(nowInSeconds){
                    
                    //  grab prompts from reddit
                    getAllPrompts { (prompts) in
//                     for p in prompts {
//                            create(prompt: p) // store all these prompts in FBDatabase
//                        }
                        
                        // just grab arbitrary prompt from the completion array and set its expydate to tomorrow midnight
                        var freshPrompt = prompts[0]
                        freshPrompt.expyDate = tomorrowMidnight
                            
                        // then store it into firebase
                        freshPrompt = create(prompt: freshPrompt)
                            
                        Prompt.setTodaysPrompt(freshPrompt)
                    }
                } else {   //  the current todaysPrompt shouhld stay the same
                        Prompt.setTodaysPrompt(promptFromFirebase)
            }
            completion()
        }
    }
} // end of retrive func
    
    
} // END OF STRUCT
