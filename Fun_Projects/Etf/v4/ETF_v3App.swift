//
// ETF_v3
// ETF_v3App.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import SwiftUI

// MARK: - Main App Entry Point
/// The @main attribute identifies this as the app's entry point
/// This struct conforms to the App protocol, which is required for SwiftUI apps
@main
struct ETF_v3App: App {
    // MARK: - Scene Configuration
    /// The body property defines the app's scene structure
    /// A Scene is a container for views that can be presented together
    var body: some Scene {
        // WindowGroup is the standard scene type for iOS apps
        // It manages a group of identically structured windows
        WindowGroup {
            // ContentView is the root view of our app
            // This is where the app's UI hierarchy begins
            ContentView()
        }
    }
}
