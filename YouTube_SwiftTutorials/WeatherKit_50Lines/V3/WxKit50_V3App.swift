//
//  Main Group
//  WxKit50_V3App.swift
//  WxKit50_V3
//
//  Created by ATS on 3/28/24
//  Made with Xcode 15.2
//  Commented by Claude on 3/29/24
//

/*
Abstract:
This code serves as the entry point of the WxKit50_V3 app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Xcode 14: Weather App in 50 lines of code with the new WeatherKit - Tech & Code
    www.youtube.com/@TechCode50
- Anthropic AI Claude
    https://www.anthropic.com
*/

// Import the SwiftUI framework, which provides the necessary components and functionality for building the app's user interface.
import SwiftUI

// Use the @main attribute to indicate that this is the entry point of the application.
@main
struct WxKit50_V1App: App {
    // Conform to the App protocol, which requires implementing the 'body' computed property.
    var body: some Scene {
        // Use a WindowGroup to create a scene that contains one or more windows.
        WindowGroup {
            // Set ContentView() as the root view of the app.
            // This view will be the initial view displayed when the app launches.
            ContentView()
        }
    }
}
