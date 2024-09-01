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

import SwiftUI

/// NotesAppV1App: The main app structure for the Notes application.
/// This structure sets up the Core Data stack and provides it to the ContentView.
import SwiftUI
import CoreData

@main
struct NotesAppV1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
