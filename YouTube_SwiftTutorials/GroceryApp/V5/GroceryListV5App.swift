//
//  GroceryListV5App.swift
//  GroceryListV5
//
//  Created on 9/13/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file contains the main app structure for the Grocery List V5 application.
It sets up the app's entry point, configures the main view, and initializes
the SwiftData model container for data persistence. This version includes
improved error handling and logging for SwiftData configuration.

Key components:
- App entry point using @main attribute
- WindowGroup scene configuration
- SwiftData model container setup for GroceryListItem and PriceHistory
- Custom SwiftData configuration with error handling and logging
*/

import SwiftUI
import SwiftData
import os

@main
struct GroceryListV5App: App {
    // MARK: - Properties
    
    /// Logger for app-level logging
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "AppConfiguration")
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [GroceryListItem.self, PriceHistory.self]) { result in
            switch result {
            case .success(let container):
                logger.info("Successfully created SwiftData container: \(container)")
            case .failure(let error):
                logger.error("Failed to create SwiftData container: \(error.localizedDescription)")
                fatalError("Failed to create SwiftData container: \(error)")
            }
        }
    }
}

// MARK: - SwiftData Configuration Extension

extension GroceryListV5App {
    /// Configures the SwiftData model container with specific options
    /// - Returns: A configured ModelContainer
    private func configureModelContainer() -> ModelContainer {
        do {
            // Define the schema for the data models
            let schema = Schema([GroceryListItem.self, PriceHistory.self])
            
            // Create a model configuration with persistence enabled
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            // Create and return the ModelContainer
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            logger.info("Successfully created custom SwiftData container")
            return container
        } catch {
            logger.error("Failed to create custom SwiftData container: \(error.localizedDescription)")
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
