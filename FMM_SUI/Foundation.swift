// Foundation.swift
//
// Made with Swift Playgrounds, Swift 5.8, iOS 16
// 
// 8/15/2023
//
// Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
// https://developer.apple.com/documentation/foundation
//

/*
 
Foundation is one of the oldest frameworks provided by Apple.

It was written in Objective-C and developed by Steve Jobs’s 
second company NeXT. It was created to manage basic tasks and
store data.
 
Most of these definitions are now obsolete, replaced by Swift’s 
data types, but others remain useful
 
 */

// compare a range of characters

import Foundation 

var phone = "905-525-6666" 
var search = "905" 

var start = phone.startIndex 
var end = phone.firstIndex(of: "-") 

if let endIndex = end { 
    let result = phone.compare(
        search, 
        options: .caseInsensitive, 
        range :start..<endIndex) 
    if result == .orderedSame { 
            print("The area code is the same") 
    } else {     
            print("The area code is different") 
    }
}
// the area code is the same


