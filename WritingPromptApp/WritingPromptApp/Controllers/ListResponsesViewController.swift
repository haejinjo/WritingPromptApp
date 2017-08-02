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
    
    // for any additional setup after loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // USING THE CUSTOM FLOATING BUTTON LIBRARY
        let floatingButton = MEVFloatingButton()
        floatingButton.animationType = .MEVFloatingButtonAnimationFromBottom
        floatingButton.displayMode = .always
        floatingButton.position = .bottomCenter
        floatingButton.image = #imageLiteral(resourceName: "icons8-Pencil-48")
        floatingButton.isRounded = true
        
        self.tableView.setFloatingButton(floatingButton)
        self.tableView.floatingButtonDelegate = self

        
        // remove this later
        responses.append(dummyResponse)
        
        // TIME SETUP
        let todayInSeconds: Int = Int(Date().timeIntervalSince1970)
        let numDays:Int = todayInSeconds/Constants.Time.secondsPerDay
        let todayMidnight = numDays * Constants.Time.secondsPerDay
        let tomorrowMidnight = todayMidnight + Constants.Time.secondsPerDay
        
//        checkValid { valid in
//            if let valid = valid {
//                PromptService.getDailyPrompt(valid)
//            }
//        }
        PromptService.getAllPrompts { (prompts) in
            self.prompts = prompts
        }
        
    } // END OF VIEWDIDLOAD
    
    
    func floatingButton(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: Constants.Segue.toComposeResponse, sender: self)
    }
    
    let dummyResponse = Response(title: "Blah", previewText: "blah", modificationTime: "mod time")
    
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
            }
        }
    }
    
} // end of class


extension ListResponsesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    } // end of cell # function
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let response = responses[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.listResponsesTableViewCell, for: indexPath) as! ListResponsesTableViewCell
        
        cell.respondedPromptLabel.text = "Insert completed prompt here"
        cell.responseModificationTimeLabel.text = "modification time"
        
        return cell
        
    } //end of cell display func
    
} // end of data source extension

