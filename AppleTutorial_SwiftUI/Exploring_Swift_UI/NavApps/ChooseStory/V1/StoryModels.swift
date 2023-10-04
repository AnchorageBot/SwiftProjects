/*

 StoryModels.swift
 Explore_SwiftUI_V3

 How to create a swift file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift File

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 Created on 10/3/2023 with Swift 5.9, Xcode 15.0

*/

//import Foundation

struct Story {

    let pages: [StoryPage]

    subscript(_ pageIndex: Int) -> StoryPage {
        return pages[pageIndex]
    }
}

struct StoryPage {

    let text: String

    let choices: [Choice]

    init(_ text: String, choices: [Choice]) {
        self.text = text
        self.choices = choices
    }
}

struct Choice {
    let text: String
    let destination: Int
}
