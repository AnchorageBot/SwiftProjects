/*

 ContentView.swift
 Explore_SwiftUI_V3

 How to create this project with Xcode commands:

    * Xcode-> File-> New Project -> iOS - App

 This creates two files

    * ContentView.swift
    * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 Created on 10/3/2023 with Swift 5.9, Xcode 15.0

*/


import SwiftUI

struct ContentView: View {

    var body: some View {

        VStack {
            
           StoryView()

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
