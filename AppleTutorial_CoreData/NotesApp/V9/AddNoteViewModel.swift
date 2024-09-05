//
// NotesAppV1
// AddNoteViewModel.swift
//
// Created on 9/3/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

// Abstract:
// This file contains the AddNoteViewModel class, which serves as the view model for the AddNoteView in the NotesAppV1 application.
// It manages the business logic for creating and saving new notes, including data validation and Core Data integration.
// The file also defines a custom ValidationError enum for handling note validation errors.

import Foundation
import CoreData
import SwiftUI

/// ViewModel for managing the creation of new notes
public class AddNoteViewModel: ObservableObject {
    // MARK: - Published Properties
    
    /// The title of the note, bound to the UI
    @Published var title: String = ""
    
    /// The content of the note, bound to the UI
    @Published var content: String = ""
    
    // MARK: - Private Properties
    
    /// The Core Data managed object context for persisting notes
    private let context: NSManagedObjectContext
    
    // MARK: - Initialization
    
    /// Initializes the view model with a Core Data context
    /// - Parameter context: The NSManagedObjectContext to be used for Core Data operations
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Computed Properties
    
    /// Checks if the current note data is valid
    /// - Returns: `true` if the note title is not empty and the content is not longer than 10000 characters
    var isValidNote: Bool {
        !title.isEmpty && content.count <= 10000
    }
    
    // MARK: - Public Methods
    
    /// Attempts to save the current note to Core Data
    /// - Throws: `ValidationError.invalidNote` if the note is not valid, or any Core Data related error
    func saveNote() throws {
        // Check if the note is valid before saving
        guard isValidNote else { throw ValidationError.invalidNote }
        
        // Create a new Note entity
        let newNote = Note(context: context)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.createdAt = Date()
        
        do {
            // Attempt to save the context
            try context.save()
        } catch {
            print("Error saving note: \(error)")
            throw error
        }
    }
}

// MARK: - Error Handling

/// Enum representing possible validation errors
enum ValidationError: Error {
    /// Indicates that the note is invalid (empty title or content exceeds maximum length)
    case invalidNote
}
