//
// GroceryList
// GroceryListApp.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file contains the main app structure for the Grocery List application.
It sets up the app's entry point, configures the main view, and initializes
the SwiftData model container for data persistence.

Key components:
- App entry point using @main attribute
- WindowGroup scene configuration
- SwiftData model container setup for GroceryListItem
*/

import SwiftUI
import SwiftData

@main
struct GroceryListApp: App {
    // MARK: - App Body
    
    var body: some Scene {
        WindowGroup {
            // Set ContentView as the root view of the app
            ContentView()
        }
        // Configure SwiftData model container
        .modelContainer(for: GroceryListItem.self)
    }
}

// MARK: - SwiftData Configuration Extension

extension GroceryListApp {
    /// Configures the SwiftData model container with specific options
    private func configureModelContainer() -> ModelContainer {
        let schema = Schema([GroceryListItem.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
