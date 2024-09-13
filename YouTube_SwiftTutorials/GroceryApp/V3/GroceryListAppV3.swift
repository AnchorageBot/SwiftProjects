//
//  GroceryListAppV3.swift
//  GroceryListV3
//
//  Created on 9/10/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
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
- Extension for custom SwiftData configuration
*/

import SwiftUI
import SwiftData

@main
struct GroceryListApp: App {
    var body: some Scene {
        WindowGroup {
            // Set up the main ContentView as the root view of the app
            ContentView()
        }
        // Configure the SwiftData model container for GroceryListItem
        .modelContainer(for: GroceryListItem.self)
    }
}

// MARK: - SwiftData Configuration Extension
extension GroceryListApp {
    /// Configures the SwiftData model container with specific options
    private func configureModelContainer() -> ModelContainer {
        // Define the schema for the data model
        let schema = Schema([GroceryListItem.self])
        
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
