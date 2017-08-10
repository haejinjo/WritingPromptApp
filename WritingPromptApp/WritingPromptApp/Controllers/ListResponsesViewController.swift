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

    
  //  var floatingButton = MEVFloatingButton()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    @IBAction func unwindToListResponsesViewController(_ segue: UIStoryboardSegue) {
        print("unwinded to list responses vc")
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError.localizedDescription)
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
    } // END OF logoutaction
    
    @IBAction func composeButtonTouchUpInside(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.Segue.toComposeResponse, sender: self)
    }
    
    @IBOutlet weak var composeButton: UIButton!

    
    var promptToPush: Prompt?
    
    var prompts = [Prompt]()
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
            if identifier == Constants.Segue.toDisplayResponse {
                // 3
                print("table view cell tapped")
            } else if identifier == "toReviews" {
                print("folder button tapped")
            } else if identifier == "toComposeResponse" {
                print("table cell tapped")
                
                let indexPath = tableView.indexPathForSelectedRow!
                
                let response = responses[indexPath.row]
                
                let composeResponseViewController = segue.destination as! ComposeResponseViewController
                
                // pass response and prompt objects to the next VC
                composeResponseViewController.response = response
                
                if let temporaryPromptToPush = promptToPush
                {
                    composeResponseViewController.respondedPrompt = temporaryPromptToPush
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

        
        PromptService.getTodaysPrompt(with: {
            
            ResponseService.retrieve{ (responsesArray) in
                       var matched = false
                for completedResponse in responsesArray {
                    if completedResponse.pid == Prompt.todaysPrompt.pid {
                        
                        self.composeButton.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                        self.composeButton.isUserInteractionEnabled = false
                        self.composeButton.backgroundColor = UIColor(red:0.33, green:0.66, blue:0.29, alpha:1.0)
                        
                        //                        self.setUpFloatingButton(hasResponded: true)
                        
                        //                        self.tableView.setNeedsLayout()
                        //                        self.tableView.setFloatingButton(self.floatingButton)
                                                matched = true
                    }
                }
                if !matched {
                    
                    self.composeButton.backgroundColor = UIColor(colorLiteralRed: 83/255.0, green: 168/255.0, blue: 210/255.0, alpha: 1.0)
                    self.composeButton.isUserInteractionEnabled = true
                }
                //                self.tableView.setNeedsLayout()
                self.responses = responsesArray
                self.tableView.reloadData()
                //                self.setUpFloatingButton(hasResponded: false)
                //                self.tableView.setFloatingButton(self.floatingButton)
            }
            
        }) // end of gettodaysprompt completion block
        

    }

    // for any additional setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
  //      self.tableView.floatingButtonDelegate = self
  //      self.setUpFloatingButton(hasResponded: false)
//        self.tableView.setFloatingButton(self.floatingButton)

        self.composeButton.layer.cornerRadius = 40
        
        self.composeButton.backgroundColor = UIColor.lightGray
        
 
       // DUMMY PROMPTS FOR TESTING
//        let olderPrompt = Prompt(title: "I'm the older prompt", originalPoster: "blah", expyDate: 1)
//        let newerPrompt = Prompt(title: "nü'er prompt", originalPoster: "blah", expyDate: 4)
//        let initialPrompt = Prompt(title: "genesis", originalPoster: "blah", expyDate: 0)
//        Prompt.setTodaysPrompt(initialPrompt)
//        PromptService.create(prompt: olderPrompt) // store dummy prompts in firebase database
//        PromptService.create(prompt: newerPrompt)
        

    } // END OF VIEWDIDLOAD
    
    
//    func setUpFloatingButton(hasResponded: Bool) {
//        // USING THE CUSTOM FLOATING BUTTON LIBRARY
//        
//        floatingButton.animationType = .MEVFloatingButtonAnimationFromBottom
//        floatingButton.displayMode = .always
//        floatingButton.position = .bottomCenter
//        floatingButton.isRounded = true
//        
//        if !hasResponded {
//            floatingButton.image = #imageLiteral(resourceName: "pencil")
//        } else {
//            floatingButton.image = #imageLiteral(resourceName: "icons8-Checked-528")
//            floatingButton.backgroundColor = UIColor(red:0.33, green:0.66, blue:0.29, alpha:1.0)
//            floatingButton.isUserInteractionEnabled = false
//        }
//        
//    }
//    
    
//    func floatingButton(_ scrollView: UIScrollView!, didTap button: UIButton!) {
//        performSegue(withIdentifier: Constants.Segue.toComposeResponse, sender: self)
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            responses.remove(at: indexPath.row)
//        }
//    }

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
        PromptService.getPrompt(withIdentifier: responses[indexPath.row].pid, completion: { (returnedPrompt) in
            if let temporaryReturnedPrompt = returnedPrompt
            {
                self.promptToPush = temporaryReturnedPrompt

                self.performSegue(withIdentifier: "toComposeResponse", sender: self)
            }
            else
            {
                print("nothing")
            }
        })
    }
    
} // end of data source extension

