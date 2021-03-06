//
//  CreditsViewController.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 8/10/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 6
        
        faqTextView.text = "Who are you?\nI'm a student developer based in California who also happens to love creative writing!\n\nWhat's happening?\nThe starving artist inside you is being served 100% organic guaranteed daily prompts sourced directly from a wonderful subreddit, /r/WritingPrompts. I encourage you to take each one with an open mind, even if it's not your preferred style or subject matter. Writing is a lifelong craft, after all, but one that too often gets brushed to the side in our hectic daily routines. I created this app with the intention of challenging my users to be brave and just write, vomit up your heart and soul onto the paper (er, screen) and marvel at the work when it's all done...but not without having a little fun :)\n\nStill suspicious. Why do you need my email?\nI'm not interested in your email -- unless it's a funny one that you kept from middle school hehe... Basically, I am using a backend service called Google Firebase for this app that happens to use email addresses as its default authentification method. Trust me, this is the most painless option for both of us. Your privacy is made safe. And I am able to push this to the app store without spending a year learning backend! Everybody wins. (That being said, social media login is  doable, and could definitely be something I provide in the near future if I see a demand for it)\n\nIs this going to get any better?\nYes. Much! And any of your feedback will be critical to this process, especially in the early stages.\n\n"
        faqTextView.textColor = UIColor.black
        
     
    }
    @IBOutlet weak var faqTextView: UITextView!


    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    

}
