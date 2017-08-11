//
//  Constants.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
        static let toReviews = "toReviews"
        static let toComposeResponse = "toComposeResponse"
    }
    
    struct Cell {
        static let listResponsesTableViewCell = "listResponsesTableViewCell"
    }
    
    struct Time {
        static let secondsPerDay: Int = 86400
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
}
