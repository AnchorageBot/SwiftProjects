//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//  Commented and refactored by Claude on 4/21/24
//

/*
 Abstract:
 This code serves as the entry point of the Birthdays app. It sets up the app's
 main structure using the App protocol and specifies the initial view to be
 displayed when the app launches. The ContentView will contain the main content
 and layout of the app, which is defined in a separate file. The app utilizes
 SwiftData for data management and persistence.

 References:
 - App Protocol Documentation
   https://developer.apple.com/documentation/swiftui/app
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata
 - ModelContainer Documentation
   https://developer.apple.com/documentation/swiftdata/modelcontainer
*/

import SwiftUI
import SwiftData

// The @main attribute indicates that this is the entry point of the application.
@main
struct BirthdaysApp: App {
    // The body property is a computed property that returns the app's main scene.
    var body: some Scene {
        WindowGroup {
            // ContentView is the initial view that will be displayed when the app launches.
            // It contains the main content and layout of the app.
            ContentView()
                // The .modelContainer modifier is used to set up the SwiftData model container.
                // It specifies the Friend model as the data model to be managed by SwiftData.
                // SwiftData will automatically persist and manage instances of the Friend model.
                .modelContainer(for: Friend.self)
        }
    }
}
