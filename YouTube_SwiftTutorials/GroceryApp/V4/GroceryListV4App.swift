//
//  GroceryListV4App.swift
//  GroceryListV4
//
//  Created on 9/12/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file contains the main app structure for the Grocery List V4 application.
It sets up the app's entry point, configures the main view, and initializes
the SwiftData model container for data persistence.

Key components:
- App entry point using @main attribute
- WindowGroup scene configuration
- SwiftData model container setup for GroceryListItem and PriceHistory
- Extension for custom SwiftData configuration
*/

import SwiftUI
import SwiftData

@main
struct GroceryListV4App: App {
    var body: some Scene {
        WindowGroup {
            // Set up the main ContentView as the root view of the app
            ContentView()
        }
        // Configure the SwiftData model container for GroceryListItem and PriceHistory
        .modelContainer(for: [GroceryListItem.self, PriceHistory.self])
    }
}

// MARK: - SwiftData Configuration Extension

extension GroceryListV4App {
    /// Configures the SwiftData model container with specific options
    /// - Returns: A configured ModelContainer
    private func configureModelContainer() -> ModelContainer {
        // Define the schema for the data models
        let schema = Schema([GroceryListItem.self, PriceHistory.self])
        
        // Create a model configuration with persistence enabled
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            // Attempt to create and return the ModelContainer
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // If container creation fails, crash the app with an error message
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
