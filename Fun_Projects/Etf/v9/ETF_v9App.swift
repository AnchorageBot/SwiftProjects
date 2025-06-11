//
// ETF_v9
// ETF_v9App.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
// Simplified to v5 by Claude (Anthropic) on 5/26/25
// Updated to v6 with List-based UI by Claude (Anthropic) on 5/26/25
// Updated to v7 with separate screens per ETF by Claude (Anthropic) on 5/26/25
// Updated to v8 with fixed results display by Claude (Anthropic) on 5/31/25
// Updated to v9 with improved results display by Gemini (Google) on 6/8/25
//

import SwiftUI

/// The main entry point for the ETF Portfolio Analyzer application.
@main
struct ETF_v9App: App {
    /// The body of the app scene.
    /// This defines the app's user interface.
    var body: some Scene {
        /// A scene that presents a group of windows.
        /// The main window of the app is defined here.
        WindowGroup {
            // Set ContentView as the root view of the application.
            ContentView()
        }
    }
}
