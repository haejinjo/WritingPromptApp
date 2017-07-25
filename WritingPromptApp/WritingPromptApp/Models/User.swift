//
//  User.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/25/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot


class User {
    
    let uid: String
    let username: String
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    // Failable init using data snapshot to create new user
    // Failable is useful here because if a user doesnt have a UID or username, it will sipmly return nil
    init?(snapshot: DataSnapshot) {
       
        // two requirements, else return nil!!!
        // 1) guard requires snapshot to be casted to a dictionary
        guard let dict = snapshot.value as? [String : Any],
        // 2) the dict must contain "username" key/value
        let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
}
