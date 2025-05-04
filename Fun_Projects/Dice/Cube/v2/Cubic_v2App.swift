//
// Cubic_v2
// Cubic_v2App.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

// Import the SwiftUI framework which provides the UI components and structure
import SwiftUI

// The @main attribute marks this struct as the entry point of the application
// This is where execution begins when the app launches
@main
struct Cubic_v2App: App {
    // The body property is required by the App protocol
    // It defines the content and behavior of the application
    var body: some Scene {
        // WindowGroup is a Scene that represents the main window of the app
        // It manages window creation and lifecycle on all platforms
        WindowGroup {
            // ContentView is instantiated as the root view of our application
            // This is what users will see when they open the app
            ContentView()
        }
    }
}
