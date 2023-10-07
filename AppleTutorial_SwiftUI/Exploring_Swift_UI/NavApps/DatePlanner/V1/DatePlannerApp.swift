/*

DatePlannerApp.swift
Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/stateobject

 https://developer.apple.com/documentation/SwiftUI/State

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://developer.apple.com/documentation/swiftui/windowgroup/

 https://developer.apple.com/documentation/SwiftUI/NavigationView

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/swiftui/view/environmentobject(_:)

Created on 10/7/2023 with Swift 5.9, Xcode 15.0

 How the app shares data with its views by creating a single data object and
 making it available to the entire view hierachy

*/

import SwiftUI

struct DatePlannerApp: App {

    // A property wrapper type that instantiates an observable object
    // Use a state object as the single source of truth for a reference type that you store in a view hierarchy
    @StateObject private var eventData = EventData()

    var body: some Scene {

        // A scene that presents a group of identically structured windows
        WindowGroup {

            // A view for presenting a stack of views that represents a visible path in a navigation hierarchy
            // Depreciated
            NavigationView {

                EventList()

                Text("Select an Event")
                    .foregroundStyle(.secondary)
            }
            // Supplies an observable object to a view’s hierarchy
            .environmentObject(eventData)

        }
    }
}
