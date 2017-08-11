
//
//  ListResponsesViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//
import MEVFloatingButton
import Firebase
import FirebaseAuth
import UIKit

class ListResponsesViewController: UIViewController, MEVFloatingButtonDelegate {

    var userIsComposing: Bool = false
    
  //  var floatingButton = MEVFloatingButton()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    @IBAction func unwindToListResponsesViewController(_ segue: UIStoryboardSegue) {
//        print("unwinded to list responses vc")
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
//        print("log out tapped")
        do {
            try Auth.auth().signOut()
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                if rootVC === self.navigationController! {
                    let loginVC = UIStoryboard.initialViewController(for: .login)
                    UIApplication.shared.keyWindow?.rootViewController = loginVC
                    
                }
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
            
            
            
        } catch let logoutError {
//            print(logoutError.localizedDescription)
        }
        
    } // END OF logoutaction
    
    @IBAction func composeButtonTouchUpInside(_ sender: UIButton) {
        userIsComposing = true
        performSegue(withIdentifier: Constants.Segue.toComposeResponse, sender: self)
    }
    
    @IBOutlet weak var composeButton: UIButton!
    
 //   var promptToPush: Prompt?
    var responses = [Response]() {
        
        // property observer
        didSet {
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == Constants.Segue.toReviews {
//                print("folder button tapped")
            } else if identifier == Constants.Segue.toComposeResponse {
                
                if !userIsComposing {
                    let indexPath = tableView.indexPathForSelectedRow!
                    tableView.deselectRow(at: indexPath, animated: true)
                    let response = responses[indexPath.row]
                    let composeResponseViewController = segue.destination as! ComposeResponseViewController
                
                    // pass response to the next VC
                    composeResponseViewController.response = response
                    composeResponseViewController.responseIndex = indexPath.row
                } else {
                    userIsComposing = false //reset
        
                }
            }
        }
    }
    

    func buttonSetUp(todaysPromptRespondedTo: Bool, _ responsesArray: [Response]) {
        var paramBool = todaysPromptRespondedTo
        
        for completedResponse in responses {
            if completedResponse.pid == Prompt.todaysPrompt.pid {
                self.composeButton.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                self.composeButton.isUserInteractionEnabled = false
                self.composeButton.backgroundColor = UIColor(red:0.33, green:0.66, blue:0.29, alpha:1.0)
                
                paramBool = true
            }
        }
        if !paramBool {
            self.composeButton.backgroundColor = UIColor(colorLiteralRed: 83/255.0, green: 168/255.0, blue: 210/255.0, alpha: 1.0)
            self.composeButton.isUserInteractionEnabled = true
        }

    }
    
    // make keyboard show up static in compose response VC
    
    func prepare() {
        
        PromptService.getTodaysPrompt(with: {
            
            ResponseService.retrieve{ (responsesArray) in
                self.responses = responsesArray
                self.buttonSetUp(todaysPromptRespondedTo: false, responsesArray)
                self.tableView.reloadData()
            }
            
        }) // end of gettodaysprompt completion block
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.composeButton.layer.cornerRadius = 40
        self.composeButton.backgroundColor = UIColor.lightGray
        
        prepare()

    } // END OF VIEWDIDLOAD
    
} // end of class


extension ListResponsesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // how many cells?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responses.count != 1 {
           self.title = "\(responses.count) Responses"
        } else {
            self.title = "\(responses.count) Response"
        }
        return responses.count
    } // end of cell # function
    
    
    // whatchu want displayed in the cells?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let response = responses[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.listResponsesTableViewCell, for: indexPath) as! ListResponsesTableViewCell
        
        cell.respondedPromptLabel.text = response.promptString
        cell.responseModificationTimeLabel.text = response.modificationTime?.convertToString()
        cell.responsePreviewLabel.text = response.content
        
        return cell
        
    } //end of cell display func
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "toComposeResponse", sender: self)
    
    }
    
} // end of data source extension

