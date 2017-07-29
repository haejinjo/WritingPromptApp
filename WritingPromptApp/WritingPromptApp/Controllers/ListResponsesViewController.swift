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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let floatingButton = MEVFloatingButton()
        floatingButton.animationType = .MEVFloatingButtonAnimationFromBottom
        floatingButton.displayMode = .always
        floatingButton.position = .bottomCenter
        floatingButton.image = #imageLiteral(resourceName: "icons8-Pencil-48")
        floatingButton.isRounded = true
        
        self.tableView.setFloatingButton(floatingButton)
        self.tableView.floatingButtonDelegate = self
        // Do any additional setup after loading the view.
        
        responses.append(dummyResponse)
    }
    
    
    func floatingButton(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        print("YAY")
    }
    
    let dummyResponse = Response(title: "Blah", previewText: "blah", modificationTime: "mod time")
    
    var responses = [Response]() {
        
        didSet {
            tableView.reloadData()
        }
    }
    
} // end of class


extension ListResponsesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    } // end of cell # func
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        

        let response = responses[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.listResponsesTableViewCell, for: indexPath) as! ListResponsesTableViewCell
        
        cell.respondedPromptLabel.text = "Insert completed prompt here"
        
        cell.responseModificationTimeLabel.text = "modification time"
        
        return cell
        
    } //end of cell display func
    
} // end of data source extension

