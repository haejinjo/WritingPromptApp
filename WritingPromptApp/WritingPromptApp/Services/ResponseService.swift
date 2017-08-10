//
//  ResponseService.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 8/4/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ResponseService {
    
    static let ref = Database.database().reference()
    static let responsesRef = ref.child("responses")
    // create an object for this response in databse
    
    static func create(response: Response) -> Response {
        
        
        
        
        let responseRef = responsesRef.childByAutoId()
        
        let dict = response.getDict()
        
        responseRef.setValue(dict) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        response.rid = responseRef.key
        
        return response
    }
    
    static func update(response: Response) {
    
        let dict = response.getUpdatedDict()
        let updatedResponseRef = responsesRef.child("\(response.rid)")
        updatedResponseRef.updateChildValues(dict) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    
    //FUNC: get all responses for current user from firebase, called in viewdidload of listresponses or didClickCell
    static func retrieve(completion: @escaping ([Response]) -> Void) {
        
        // ---------------the exposition! (declarations & setup)-----------------
        var responseArray = [Response]()
        let responsesRef = Database.database().reference().child("responses")
            //  prep a neat list of *just* the children responses
            // corresponding to current user's UID
        let userSpecificQuery = responsesRef.queryOrdered(byChild: "uid").queryEqual(toValue: User.current.uid)
        
        
        // ----------------the action! (interaction with the list)----------------
        userSpecificQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for responseSnapshot in snapshot.children {
                // ---------------the climax!------------------------------
                // create Response object using using the grape bunch of the userSpecificQuery
                if let response = Response(snapshot: responseSnapshot as! DataSnapshot) {
                    
              
                    responseArray.append(response)
                }
                
            // --------------------the resolution!------------------------
            
            }
            completion(responseArray)
        })
        
    } //END of retrieve function

}
