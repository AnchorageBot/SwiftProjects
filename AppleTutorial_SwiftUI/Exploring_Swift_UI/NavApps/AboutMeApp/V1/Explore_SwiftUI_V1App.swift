/*

 Explore_SwiftUI_V1App.swift
 Explore_SwiftUI_V1

 How to create this project with Xcode commands:

    * Xcode-> File-> New Project -> iOS - App

 This creates two files

    * ContentView.swift
    * ProjectName_App.swift

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#main

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

// attribe used to indicate the top-level entry point for program flow
@main

struct Explore_SwiftUI_V1App: App {

    // The content and behavior of the app
    var body: some Scene {

        // A scene that presents a group of identically structured windows
        WindowGroup {

            ContentView()
        }
    }
}
