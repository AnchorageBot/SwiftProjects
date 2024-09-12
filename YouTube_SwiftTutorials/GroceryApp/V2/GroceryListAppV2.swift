//
// GroceryListV2
// GroceryListAppV2.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Afraz Siddiqui - iOS Academy YouTube
// Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file contains the main app structure for the GroceryListV2 app.
It sets up the app's entry point and configures the SwiftData model container.
*/

import SwiftUI
import SwiftData

@main
struct GroceryListAppV2: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Inject a container to hold the SwiftData models
        .modelContainer(for: GroceryListItem.self)
    }
}
