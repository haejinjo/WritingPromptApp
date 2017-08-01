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
    let title: String
    //let expyDate: Int
    let flairText: String
    let originalPoster: String
    
    
    // json param = ["data"]["children"][random_index]
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.flairText = json["link_flair_text"].stringValue
        self.originalPoster = json["author"].stringValue
    }
}
