//
//  GroceryListV6App.swift
//  GroceryListV6
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
This file contains the main app structure for the Grocery List V6 application.
It sets up the app's entry point, configures the SwiftData model container,
and initializes the app storage manager for user preferences. This version
includes improved error handling and logging for SwiftData configuration.

Key components:
- App entry point using @main attribute
- SwiftData model container setup for GroceryListItem and PriceHistory
- AppStorageManager initialization for managing user preferences
- WindowGroup scene configuration with ContentView as the root view
- Custom SwiftData configuration with error handling and logging
*/

import SwiftUI
import SwiftData
import os

@main
struct GroceryListV6App: App {
    // MARK: - Properties
    
    /// Logger for app-level logging
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "AppConfiguration")
    
    /// App storage manager for user preferences
    @StateObject private var appStorageManager = AppStorageManager()
    
    /// SwiftData model container
    private let modelContainer: ModelContainer
    
    // MARK: - Initialization
    
    init() {
        do {
            // Initialize the ModelContainer with GroceryListItem and PriceHistory models
            modelContainer = try ModelContainer(for: GroceryListItem.self, PriceHistory.self)
            logger.info("Successfully created SwiftData container")
        } catch {
            // Log the error and terminate the app if model container creation fails
            logger.error("Failed to create SwiftData container: \(error.localizedDescription)")
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appStorageManager) // Inject appStorageManager into the environment
                .modelContainer(modelContainer) // Provide the SwiftData model container
        }
    }
}
