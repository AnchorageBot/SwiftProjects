//
// BasicMath
// BasicMathAppV1.swift
//
// Created on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
 
 Abstract: 
 
 This app wortks through how to run unit tests on basic math functions
 
 This file contains the main app structure for the BasicMathV1 app.
 It sets up the app's entry point and configures the SwiftData model container.
 
 
 */

import SwiftUI
import SwiftData

// @main attribute indicates this is the entry point of the application
@main


struct BasicMathAppV1: App {
    
    // The body property defines the content and behavior of the app
    var body: some Scene {
        
        // WindowGroup is a container for the app's user interface
        WindowGroup {
            
            // Set ContentView as the root view of the application
            ContentView()
        }
    }
    
        // Inject a container to hold the SwiftData models
        .modelContainer(for: NumberListItem.self)
    
}
