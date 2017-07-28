//
//  Storyboard+Utility.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 7/28/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit


extension UIStoryboard {
    
    // to access storyboards..conveniently!
    // e.g. let loginStoryboard = UIStoryboard(type: .login)
    convenience init(type: HJType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    // contains case for each storyboard

    enum HJType: String {
        case main
        case login
        
        // computed variable that returns corresponding filename for each storyboard
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    static func initialViewController(for type: HJType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate the initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
