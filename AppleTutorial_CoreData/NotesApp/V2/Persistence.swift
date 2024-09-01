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

import CoreData

/// PersistenceController: A structure that manages the Core Data stack for the Notes app.
struct PersistenceController {
    /// The shared instance of the PersistenceController
    static let shared = PersistenceController()

    /// A preview instance of the PersistenceController for use in SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Create 10 example Note items
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
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NotesAppV1")
        if inMemory {
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
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
