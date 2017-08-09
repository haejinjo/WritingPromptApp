//
//  Response.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Response {
    
    var promptString: String
    var modificationTime: Date?
    var content: String
    var rid: String
    var pid: String
    let uid: String
    
    func getDict() -> [String:Any] {
        var responseDict = [String: Any]()
        responseDict["promptString"] = self.promptString
        responseDict["modificationTime"] = self.modificationTime?.timeIntervalSince1970
        responseDict["content"] = self.content
//        responseDict["rid"] = self.rid
        responseDict["pid"] = self.pid
        responseDict["uid"] = self.uid
        
        return responseDict
    }
    
    func getUpdatedDict() -> [String: Any] {
        var dict = [String:Any]()
        dict["modificationTime"] = self.modificationTime?.timeIntervalSince1970
        dict["content"] = self.content
        
        return dict
    }
    
    // Natural
    init(prompt: Prompt, modificationTime: Date, content: String) {
        self.promptString = prompt.title
        self.modificationTime = modificationTime
        self.content = content
        self.uid = User.current.uid
        self.rid = ""
        self.pid = prompt.pid

    }
    
    // Failable is useful here because if a user doesnt have a UID or username, it will simply return nil
    init?(snapshot: DataSnapshot) {
    
        // 1) require snapshot to be able to be casted to a dictionary
        guard let dict = snapshot.value as? [String : Any],
            
            // 2) dict must contain the following keys/values
            let promptString = dict["promptString"] as? String,
        
            let modificationTimeSeconds = dict["modificationTime"] as? Double,
        
            let content = dict["content"] as? String,
            
            let promptReference = dict["pid"] as? String,
            
            let userReference = dict["uid"] as? String
            else {return nil}
        
        self.rid = snapshot.key
        self.pid = promptReference
        self.uid = userReference
        self.promptString = promptString
        self.modificationTime = Date(timeIntervalSince1970: modificationTimeSeconds)
        self.content = content

    }
    

    
}
