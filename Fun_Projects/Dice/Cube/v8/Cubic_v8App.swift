//
// Cubic_v8
// Cubic_v8App.swift
//
// Created on 5/4/25 (as per original)
// Refactored on 5/12/25
// Swift Version 6.0 (or latest applicable)
//
// ATS Project
// Assisted by Anthropic's AI Claude & Google's AI Gemini
//

import SwiftUI
// Removed AVFoundation/AudioToolbox imports if no longer needed here

// The main app entry point marked with @main attribute
@main
struct Cubic_v8App: App {
    // Create a shared audio player manager that can be accessed by all views
    // The AudioManager class is now defined in its own file.
    @StateObject private var audioManager = AudioManager()

    // The body property defines the app structure
    var body: some Scene {
        // WindowGroup is a container for our app's UI
        WindowGroup {
            // Set ContentView as the root view and inject the audio manager
            ContentView()
                .environmentObject(audioManager)
                .preferredColorScheme(.dark) // Force dark mode for better visual appearance
        }
    }
}

// << The AudioManager class definition is NO LONGER HERE >>
