//
//  LoginViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/19/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
        print("tapped get started")
    }
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        print("tapped sign in here")
    }
    
}
