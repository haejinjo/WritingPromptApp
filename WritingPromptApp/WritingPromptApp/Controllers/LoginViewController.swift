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
        
        // 1) read the data
        // Snapshots (retrieved data from Firebase) can be accessed through their "value" property
        // Can be returned as either NSDictionary, NSArray, NSNumber, or NSString

        // 1)
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
       
            //2)  But we expect users to be returned as dictionaries
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
        
                print("Welcome back \(user.username).")
                }
            } else {
                    self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            } // end of user if let check 
            
        }) // end of observe-retrieved-data closure
        
    } //end of authUI method
    
} // end of FUIAuthDelegate extension
