//
//  WeatherPrototypeApp.swift
//  WeatherPrototype
//
//  Created by ATS on 4/6/24
//  Made with Xcode 15.3
//  Revised on 4/7/24
//  Commented by Claude on 4/7/24
//

/*
Abstract:
This code serves as the entry point of the WeatherPrototype app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- WeatherKit: https://developer.apple.com/weatherkit/get-started/
- CoreLocate: https://developer.apple.com/documentation/corelocation
- Develop in Swift Tutorials - Views, structures, and properties 
    https://developer.apple.com/tutorials/develop-in-swift/customize-views-with-properties
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI // Imports the SwiftUI framework

@main // Indicates that this struct is the entry point of the application
struct WeatherPrototypeApp: App { // Defines the WeatherPrototypeApp struct, which conforms to the App protocol
    var body: some Scene { // Defines the app's scene
        WindowGroup { // Specifies the initial view to be displayed when the app launches
            ContentView() // Assigns ContentView as the root view of the WindowGroup
        }
    }
}
