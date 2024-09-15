//
// BasicMath
// BasicMathAppV2.swift
//
// Created on 9/15/24
// Updated on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:

This file contains the main app structure for the BasicMathV2 app.
It sets up the app's entry point and configures the SwiftData model container.

Key components:
- App entry point
- SwiftData model container configuration
- Main window group setup
*/

import SwiftUI
import SwiftData

/// The main structure of the BasicMathV2 app
@main
struct BasicMathAppV2: App {
    
    /// The body property defines the content and behavior of the app
    var body: some Scene {
        
        // WindowGroup is a container for the app's user interface
        WindowGroup {
            
            // Set ContentView as the root view of the application
            ContentView()
        }
        // Inject a container to hold the SwiftData models
        .modelContainer(for: NumberListItem.self)
    }
}
