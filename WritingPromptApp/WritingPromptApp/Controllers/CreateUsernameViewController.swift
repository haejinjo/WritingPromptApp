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
        }
    
    }
}
