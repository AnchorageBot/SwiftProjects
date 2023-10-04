/*

 Explore_SwiftUI_V2App.swift
 Explore_SwiftUI_V2

 How to create this project with Xcode commands:

    * Xcode-> File-> New Project -> iOS - App

 This creates two files

    * ContentView.swift
    * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#main

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 Created on 10/2/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

// attribute used to indicate the top-level entry point for program flow
@main

// Use structures to represent common kinds of data
struct Explore_SwiftUI_V2App: App {

    // The content and behavior of the app
    var body: some Scene {

        // A scene that presents a group of identically structured windows
        WindowGroup {
            
            ContentView()

        }
    }
}
