//
//  Response.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation

class Response {
    
    
    init(prompt: Prompt, modificationTime: Date) {
        self.promptString = prompt.title
        self.modificationTime = modificationTime
        self.content = ""
    }
    
  
    var promptString: String
    let modificationTime: Date?
    var content: String
    
}
