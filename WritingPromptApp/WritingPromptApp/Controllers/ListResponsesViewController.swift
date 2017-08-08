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
    

    // for any additional setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PromptService.getTodaysPrompt()

        // USING THE CUSTOM FLOATING BUTTON LIBRARY
        let floatingButton = MEVFloatingButton()
        floatingButton.animationType = .MEVFloatingButtonAnimationFromBottom
        floatingButton.displayMode = .always
        floatingButton.position = .bottomCenter
        floatingButton.image = #imageLiteral(resourceName: "icons8-Pencil-48")
        floatingButton.isRounded = true
        
        self.tableView.setFloatingButton(floatingButton)
        self.tableView.floatingButtonDelegate = self

        
        ResponseService.retrieve{ (responsesArray) in
            self.responses = responsesArray
        }
        
       // DUMMY PROMPTS FOR TESTING
//        let olderPrompt = Prompt(title: "I'm the older prompt", originalPoster: "blah", expyDate: 1)
//        let newerPrompt = Prompt(title: "nü'er prompt", originalPoster: "blah", expyDate: 4)
//        let initialPrompt = Prompt(title: "genesis", originalPoster: "blah", expyDate: 0)
//        Prompt.setTodaysPrompt(initialPrompt)
//        PromptService.create(prompt: olderPrompt) // store dummy prompts in firebase database
//        PromptService.create(prompt: newerPrompt)
        

    } // END OF VIEWDIDLOAD
    
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

