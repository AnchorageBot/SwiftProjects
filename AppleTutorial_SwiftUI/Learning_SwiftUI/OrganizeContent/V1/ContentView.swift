/*

 ContentView.swift
 LearnSwiftUI_V4

 How to create this file with Xcode commands:
 Xcode -> File -> New Project -> iOS - App

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/organizing-and-aligning-content-with-stacks

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/foundation/dates_and_times

 https://developer.apple.com/sf-symbols/

 Created on 9/10/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct ContentView: View {

    let event = Event(
        title: "Trip to Farmers Market",
        date: ISO8601DateFormatter().date(from: "2023-06-07T12:00:00Z") ?? Date.now,
        location: "Farmers market",
        symbol: "bicycle")

    var body: some View {
        
       EventTile(event: event)
        //.preferredColorScheme(.dark)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
