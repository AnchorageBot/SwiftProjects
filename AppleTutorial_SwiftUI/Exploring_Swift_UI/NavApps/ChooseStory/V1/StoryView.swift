/*

 StoryView.swift
 Explore_SwiftUI_V3

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uiimage/configuring_and_displaying_symbol_images_in_your_ui

 Created on 10/3/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct StoryView: View {

    var body: some View {

        NavigationStack {

            StoryPageView(story: story, pageIndex: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        StoryView()
    }
}
