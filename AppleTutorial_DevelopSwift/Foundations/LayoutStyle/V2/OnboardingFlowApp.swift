//
//  OnboardingFlowApp.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
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

@main
struct OnboardingFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
