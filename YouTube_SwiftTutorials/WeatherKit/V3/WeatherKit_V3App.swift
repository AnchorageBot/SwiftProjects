//
// Main Group
// WeatherKit_V3App.swift
// WeatherKit_V3
//
// Created by ATS on 3/24/24
// Made with Xcode 15.2
// Commented by Claude on 3/24/24
// Refactored by Claude on 3/25/24
//

/*
Abstract:
This code serves as the entry point of the WeatherKit_V1 app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet
- Anthropic AI Claude
    https://www.anthropic.com
*/

import SwiftUI

// The @main attribute indicates that this is the entry point of the application
@main
struct WeatherKitV1App: App {
    // The body property defines the app's main scene
    var body: some Scene {
        // WindowGroup is a scene that represents a window in the app
        WindowGroup {
            // ContentView() is the root view of the app
            // It will be the initial view displayed when the app launches
            ContentView()
        }
    }
}
