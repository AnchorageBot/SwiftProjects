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
 and layout of the app, which is defined in a separate file.

 References:
 - App Protocol Documentation
   https://developer.apple.com/documentation/swiftui/app
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata
*/

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
