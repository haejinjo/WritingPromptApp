//
//  Response.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation

class Response {
    
    init(title: String, previewText: String, modificationTime: Date) {
        self.title = title
        self.previewText = previewText
        self.modificationTime = modificationTime
    }
    
    let title: String
    let previewText: String
    let modificationTime: Date
    
}
