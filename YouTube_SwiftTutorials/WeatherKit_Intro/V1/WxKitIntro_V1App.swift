//
//  Main folder
//  WxKitIntro_V1App.swift
//  WxKitIntro_V1
//
//  Created by ATS on 3/27/24
//  Made with Xcode 15.2
//

/*
Abstract:
This code serves as the entry point of the WeatherKit_V1 app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Introduction to WeatherKit (iOS 16) – WWDC 2022 - iOS Academy
    www.youtube.com/@iOSAcademy
- Anthropic AI Claude
    https://www.anthropic.com
*/

import SwiftUI

@main
struct WxKitIntro_V1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
