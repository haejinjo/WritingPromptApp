//
//  LoginViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/19/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
        print("tapped get started")
    }
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        print("tapped sign in here")
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        
        authUI.delegate = self //<--can only do this when LoginViewController conforms to FUIAuthDelegate protocol
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
   
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            print("Error signing in: \(error.localizedDescription)")
            return
        }
        
        // guard to prevent proceeding if user is nil
        guard let user = user
            else {return}
        
        // construct a relative path to reference of the user's JSON info
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        // read the data 
        // Snapshots (retrieved data from Firebase) can be accessed through their "value" property
        // Will be returned as NSDictionary, NSArray, NSNumber, or NSString

        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
        // We expect users to be returned as dictionaries
            if let user = User(snapshot: snapshot) {
                print("Welcome back \(user.username).")
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        }) // end of observe-retrieved-data closure
        
    } //end of authUI method
    
} // end of FUIAuthDelegate extension
