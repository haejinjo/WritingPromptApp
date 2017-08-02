//
//  UserService.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/26/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRUser

// Service structs are middle men between our app and Firebase

// GOAL :Remove networking-related code from view controllers into "service layer" to encapsulate the functionality for creating a user on Firebase
struct UserService {
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
         // create a dict to properly store the name provided by user into our database
        let userAttrs = ["username": username]
        
        // write data we want to store in FBdatabase
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // read user data we just wrote to FBdatabase and create new User object from itbu
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
                
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
      
        // construct a relative path to reference of the user's JSON info
        let ref = Database.database().reference().child("users").child(uid)
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            // guard to prevent proceeding if user is nil
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }

} // END OF STRUCT
