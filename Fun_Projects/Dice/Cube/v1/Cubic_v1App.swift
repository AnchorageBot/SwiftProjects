//
// Cubic_v1
// Cubic_v1App.swift
//
// Created on 5/1/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

// This is the entry point for the app
// The SwiftUI framework provides the core components needed for UI development
import SwiftUI

// The @main attribute identifies this struct as the app's entry point
// The App protocol requires a body property that returns a Scene
@main
struct Cubic_v1App: App {
    // The body property returns a Scene that contains the app's UI
    var body: some Scene {
        // WindowGroup is a container for the app's main window
        // It automatically handles window management on different platforms
        WindowGroup {
            // ContentView is our custom view that contains the main UI of the app
            ContentView()
        }
    }
}
