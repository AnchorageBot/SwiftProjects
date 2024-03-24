//
//  Main Group
//  WeatherKit_V1App.swift
//  WeatherKit_V1
//
//  Created by ATS on 3/24/24.
//  Made with Xcode 15.2
//

/*
 
 Abstract:
 
    Manages the app launch process
 
 References:
 
    https://developer.apple.com/documentation/uikit/uiapplicationdelegate/3656306-main
 
    https://developer.apple.com/documentation/swiftui/app/main()/
 
    https://developer.apple.com/documentation/swiftui/app
 
 */

import SwiftUI

@main
struct WeatherKit_V1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
