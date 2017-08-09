//
//  ListResponsesViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//
import MEVFloatingButton

import UIKit

class ListResponsesViewController: UIViewController, MEVFloatingButtonDelegate {

    var floatingButton = MEVFloatingButton()
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToListResponsesViewController(_ segue: UIStoryboardSegue) {
        
    }
    
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
            } else if identifier == "displayResponse" {
                print("table cell tapped")
                
                let indexPath = tableView.indexPathForSelectedRow!
                
                let response = responses[indexPath.row]
                
                let composeResponseViewController = segue.destination as! ComposeResponseViewController
                
                // pass to next VC
                composeResponseViewController.response = response
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
            }

    // for any additional setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PromptService.getTodaysPrompt(with: {
            
            ResponseService.retrieve{ (responsesArray) in
                
                for completedResponse in self.responses {
                    if completedResponse.pid == Prompt.todaysPrompt.pid {
                        self.floatingButton = self.setUpFloatingButton(hasResponded: true)
                        self.tableView.setFloatingButton(self.floatingButton)
                    }
                }

                self.tableView.floatingButtonDelegate = self
                self.responses = responsesArray
                self.tableView.reloadData()
            }
            
        }) // end of gettodaysprompt completion block

         floatingButton = setUpFloatingButton(hasResponded: false)
        self.tableView.setFloatingButton(floatingButton)
 
       // DUMMY PROMPTS FOR TESTING
//        let olderPrompt = Prompt(title: "I'm the older prompt", originalPoster: "blah", expyDate: 1)
//        let newerPrompt = Prompt(title: "nü'er prompt", originalPoster: "blah", expyDate: 4)
//        let initialPrompt = Prompt(title: "genesis", originalPoster: "blah", expyDate: 0)
//        Prompt.setTodaysPrompt(initialPrompt)
//        PromptService.create(prompt: olderPrompt) // store dummy prompts in firebase database
//        PromptService.create(prompt: newerPrompt)
        

    } // END OF VIEWDIDLOAD
    
    
    func setUpFloatingButton(hasResponded: Bool) -> MEVFloatingButton {
        // USING THE CUSTOM FLOATING BUTTON LIBRARY
        
        let floatingButton = MEVFloatingButton()
        floatingButton.animationType = .MEVFloatingButtonAnimationFromBottom
        floatingButton.displayMode = .always
        floatingButton.position = .bottomCenter
        floatingButton.isRounded = true
        
        if hasResponded {
            floatingButton.image = #imageLiteral(resourceName: "icons8-Pencil-48")
        } else {
            floatingButton.image = #imageLiteral(resourceName: "icons8-Checked-528")
            floatingButton.backgroundColor = UIColor(red:0.33, green:0.66, blue:0.29, alpha:1.0)
            floatingButton.isUserInteractionEnabled = false
        }
        
        return floatingButton
    }
    func floatingButton(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: Constants.Segue.toComposeResponse, sender: self)
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            responses.remove(at: indexPath.row)
//        }
//    }

} // end of class


extension ListResponsesViewController: UITableViewDataSource {
    
    // how many cells?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
} // end of data source extension

