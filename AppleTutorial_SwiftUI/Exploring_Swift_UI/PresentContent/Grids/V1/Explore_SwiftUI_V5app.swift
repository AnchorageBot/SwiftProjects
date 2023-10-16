/*

 Explore_SwiftUI_V5app.swift
 Explore_SwiftUI_V5

 How to create this project with Xcode commands:

   * Xcode-> File-> New Project -> iOS - App

 This creates two files

   * ContentView.swift
   * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/organizingwithgrids

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 Created on 10/16/2023 and updated on 10/11/2023 with Swift 5.9, Xcode 15.0

 Follows a set of guidelines created by the App protocol. This allows your project to run and behave just like any other app.

*/

import SwiftUI


// the entry point of the program — the code the app starts running first
@main

struct Explore_SwiftUI_V5App: App {


    // When your app runs, it displays whatever content you place in the body property
    var body: some Scene {

        WindowGroup {

            /*
             When you create a new app, ContentView is configured as your top-level view by
             default. This is useful because you can go to ContentView to see how an app’s
             views are put together
             */
            ContentView()

        }
    }
}
