//
// NotesAppV1
// Persistence.swift
//
// Created on 8/31/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file defines the PersistenceController structure, which manages the Core Data stack
 for the NotesAppV1 application. It provides a shared instance for use throughout the app,
 a preview instance for SwiftUI previews, and handles the setup of the persistent container.
 The controller supports both persistent storage and in-memory storage for testing and previews.
 */

import CoreData

/// PersistenceController: A structure that manages the Core Data stack for the Notes app.
public struct PersistenceController {
    /// The shared instance of the PersistenceController for use throughout the app
    static let shared = PersistenceController()

    /// A preview instance of the PersistenceController for use in SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Create 10 example Note items for preview purposes
        for i in 0..<10 {
            let newNote = Note(context: viewContext)
            newNote.id = UUID()
            newNote.title = "Sample Note \(i + 1)"
            newNote.content = "This is the content of sample note \(i + 1)."
            newNote.createdAt = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    /// The Core Data container for the app
    let container: NSPersistentContainer

    /// Initializes the PersistenceController
    /// - Parameter inMemory: If true, an in-memory store is used instead of a persistent store
    public init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NotesAppV1")
        if inMemory {
            // Use an in-memory store for previews and testing
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        // Enable automatic merging of changes from the parent context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}