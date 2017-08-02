//
//  Prompt.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/31/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Prompt {
    var title: String
    let expyDate: Int
    var flairText: String
    var originalPoster: String
    
    // json ref = ["data"]["children"][index]
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.flairText = json["link_flair_text"].stringValue
        self.originalPoster = json["author"].stringValue
    }
    
    func getDict() -> [String:String] {
        var promptDict = [String: String]()
        promptDict["title"] = self.title
        promptDict["originalPoster"] = self.originalPoster
        promptDict["expyDate"] = "\(self.expyDate)"
        
        return promptDict
    }
}
