//
//  Prompt.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/31/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseDatabase

class Prompt {
    var title: String
    var expyDate: Int
    var originalPoster: String
    var id: String
    
    private static var _todaysPrompt: Prompt? = Prompt(title: "", originalPoster: "", expyDate: 0)
    
    static var todaysPrompt: Prompt {
        guard let todaysPrompt = _todaysPrompt else {
            fatalError("Error: todays prompt doesn't exist")
        }
        
        return todaysPrompt
    }
    
    static func setTodaysPrompt(_ prompt: Prompt) {
        _todaysPrompt = prompt
    }
    
    func isOlderThan(_ dateInSeconds: Int) -> Bool {
        if self.expyDate < dateInSeconds {
            return true
        }
        return false
    }
    
    func setExpyDate(_ newExpyDate: Int) {
        self.expyDate = newExpyDate
    }
    
    // json ref = ["data"]["children"][index]
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.originalPoster = json["author"].stringValue
        self.expyDate = 0
        self.id = ""
    }
    
    // testing init
    init(title: String, originalPoster: String, expyDate: Int) {
        self.title = title
        self.originalPoster = originalPoster
        self.expyDate = expyDate
        self.id = "test"
    }
    
    func getDict() -> [String:Any] {
        var promptDict = [String: Any]()
        promptDict["title"] = self.title
        promptDict["originalPoster"] = self.originalPoster
        promptDict["expyDate"] = self.expyDate
        
        return promptDict
    }
    
    
//    // Create a new prompt based off a data snapshot
    init?(snapshot: DataSnapshot) {
        
        // two requirements, else return nil!!!
        // 1) guard requires snapshot to be casted to a dictionary
        
        guard let dict = snapshot.value as? [String: Any],
            let title = dict["title"] as? String,
            let originalPoster = dict["originalPoster"] as? String,
            let expyDate = dict["expyDate"] as? Int
            else { return nil }
        
        self.title = title
        self.originalPoster = originalPoster
        self.expyDate = expyDate
        self.id = snapshot.key
       
    }

}
