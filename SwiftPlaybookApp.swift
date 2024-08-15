//
// SwiftPlaybook
// SwiftPlaybookApp.swift
//
// Created on 8/14/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude

// Replace the contents of your SwiftPlaybookApp.swift file with this file 

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
