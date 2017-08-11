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
    
    @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {
//        print("unwinded to login vc")
    }
    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
//        print("tapped get started")

        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        
        authUI.delegate = self //<--can only do this when LoginViewController conforms to FUIAuthDelegate protocol
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 6
    }
    
}

extension LoginViewController: FUIAuthDelegate {
   
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
//            print("Error signing in: \(error.localizedDescription)")
            return
        }
        if let user = user {
            
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.present(initialViewController, animated: true, completion: nil)
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
                    
//                    print("Welcome back \(user.username).")
                } else {
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                } // end of user if let check 
                
            }
        }
         // end of observe-retrieved-data closure
        
    } //end of authUI method
    
} // end of FUIAuthDelegate extension
