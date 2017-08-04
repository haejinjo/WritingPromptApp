//
//  ListResponsesTableViewCell.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import UIKit

// USE THIS CLASS TO ALTER WHAT THE TAABLE VIEW CELL DISPLAYS
class ListResponsesTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var respondedPromptLabel: UILabel!
    
    @IBOutlet weak var responseModificationTimeLabel: UILabel!
    
    @IBOutlet weak var responsePreviewLabel: UILabel!
    

}
