//
//  OnboardingFlowApp.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//
//  Commented by Claude on 4/13/24
//

/*
Abstract:
This code serves as the entry point of the OnboardingFlow app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Develop in Swift Tutorials - Layout and style
    https://developer.apple.com/tutorials/develop-in-swift/design-an-interface
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI

// The @main attribute indicates that this is the entry point of the application.
@main
struct OnboardingFlowApp: App {
    
    // The body property is a computed property that returns the app's main scene.
    
    var body: some Scene {
        
        // WindowGroup is a scene that represents the main window of the app.
        
        // It contains the initial view hierarchy of the app.
        
        WindowGroup {
            
            // ContentView() is the initial view that will be displayed when the app launches.
            
            // The actual content and layout of the ContentView will be defined in a separate file.
            
            ContentView()
            
        }
        
    }
}
