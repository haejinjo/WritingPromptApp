//
//  CreateUsernameViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/25/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase


class CreateUsernameViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        // guard to check a user has logged in AND provided a name in the textfield
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else {return}
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {return}
            
            print("Created new user: \(user.username)")
            
            User.setCurrent(user)
            
            // create instance of main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            // check that this storyboard has an initial view controller
            if let initialViewController = storyboard.instantiateInitialViewController() {
                
                // referring to current window, set rootViewController to the initial view controller
                self.view.window?.rootViewController = initialViewController
                
                self.view.window?.makeKeyAndVisible()
            
            }
        }
        
        
    
    }
}
