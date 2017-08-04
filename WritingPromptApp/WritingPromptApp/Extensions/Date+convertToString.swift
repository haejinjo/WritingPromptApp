//
//  Date+convertToString.swift
//  WritingPromptApp
//
//  Created by Haejin Jo on 8/4/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation

extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}

extension NSDate {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: (self as Date), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}
