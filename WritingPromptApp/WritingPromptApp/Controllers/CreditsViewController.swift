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
        
        faqTextView.text = "Who are you? I'm a student developer based in California who also happens to love creative writing!\n\nWhat's happening?\nThe starving artist inside you is being served 100% organic guaranteed daily prompts sourced directly from a wonderful subreddit entirely devoted to the stuff. I encourage you to take each one with an open mind, even if it's not your usual style or subject matter. Writing is a lifelong craft, after all, but one that too often gets brushed to the side in our hectic daily routines. I created this app with the intention of challenging my users to be brave and just write, vomit up you heart and soul onto the paper (er, screen) and marvel at the work when it's all done...but not without having a little fun :)\n\nI'm still suspicious. Why do you need my email?\nI'm not interested in your email -- unless it's a funny one that you kept from middle school hehe... Jokes aside, I am using a backend service called Google Firebase for this app that happens to use email addresses as its default authentification method. Trust me, this makes it the most painless for both of us. Your info is made safe. And I am able to push this to the app store without spending a year learning backend! Everybody wins. (That being said, social media login is  doable, and could definitely be something I provide in the near future if I see a demand for it)\n\nIs this going to get any better?\nYes. Much! Your feedback, as always, will be much appreciated.\n\n"
        faqTextView.textColor = UIColor.black
        
     
    }
    @IBOutlet weak var faqTextView: UITextView!


    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    

}
