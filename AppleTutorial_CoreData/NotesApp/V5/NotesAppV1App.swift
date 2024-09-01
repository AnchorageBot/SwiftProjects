//
// NotesAppV1
// NotesAppV1App.swift
//
// Created on 8/31/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file contains the main app structure for the NotesAppV1 application.
 It sets up the Core Data stack using a shared PersistenceController and
 provides the managed object context to the ContentView. This structure
 conforms to the App protocol, making it the entry point of the application.
 */

import SwiftUI
import CoreData

/// The main app structure conforming to the App protocol.
@main
struct NotesAppV1App: App {
    /// A shared instance of PersistenceController to manage Core Data stack.
    let persistenceController = PersistenceController.shared

    /// The body property required by the App protocol.
    /// It defines the content and behavior of the app.
    var body: some Scene {
        WindowGroup {
            /// Set up the main content view of the app.
            ContentView()
                /// Inject the managed object context into the environment.
                /// This allows child views to access and modify Core Data entities.
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
