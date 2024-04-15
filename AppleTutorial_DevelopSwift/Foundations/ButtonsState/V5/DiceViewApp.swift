//
//  DiceViewApp.swift
//  DiceView
//
//  Created by ATS on 4/14/24
//  Xcode version 15.3
//

/*
 
 Abstract:
 This code serves as the entry point of the DiceView app. It sets up the app's main structure using the App protocol and specifies the initial view to be displayed when the app launches. The ContentView will contain the main content and layout of the app, which is defined in a separate file.
 
 References:
 - Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
 - Anthropic AI: Claude
    https://www.anthropic.com
 - Swift structures and classes https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes
 
 */

import SwiftUI

// The @main attribute indicates that this is the entry point of the application.
@main

// Structures (struct) are used to represent common kinds of data
// They can include stored properties, computed properties, and methods. Moreover, Swift structures can adopt protocols to gain behavior through default implementations.
struct DiceViewApp: App {
    
    // The body property is a computed property that returns the app's main scene.
    
    var body: some Scene {
        
        // WindowGroup is a scene that represents the main window of the app.
        
        // It contains the initial view hierarchy of the app.
        
        WindowGroup {
            
            // ContentView() is the initial view that will be displayed when the app launches.
            
            // The actual content and layout of the ContentView will be defined in a separate file.
            
            ContentView()
            
        }
    }
}
