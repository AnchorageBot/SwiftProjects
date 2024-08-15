//
// SwiftPlaybook
// SwiftPlaybookApp.swift
//
// Created on 8/14/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude

/*
To use this app:

1. Create a new SwiftUI iOS App project in Xcode.
2. Replace the contents of your SwiftPlaybookApp.swift file with this file 
2. Replace the contents of your ContentView.swift file with the SwiftPlaybook.swift file in this repository
3. Run the app in the simulator or on a device.
*/

import SwiftUI

@main
struct SwiftPlaybookApp: App {
    @StateObject private var appSettings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
        }
    }
}
