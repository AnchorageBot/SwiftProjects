/*

 EventTask.swift
 Explore_SwiftUI_V4

 How to create a Swift file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift File

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swift/identifiable

 https://developer.apple.com/documentation/swift/hashable

 https://developer.apple.com/documentation/cryptokit/hashfunction

 Created on 10/8/2023 with Swift 5.9, Xcode 15.0

 The event task represents a to-do item for an event

*/

import Foundation

/*
 EventTask is Identifiable, which lets SwiftUI manage and update its appearance in a list

 When a person marks a task as completed, you set isCompleted to true, which allows your app
    to track the remaining tasks for each event

 */

struct EventTask: Identifiable, Hashable {

    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
    
}
