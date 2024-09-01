//
// NotesAppV1
// AddNoteView.swift
//
// Created on 9/1/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file defines the AddNoteView structure, a view dedicated to creating new
 notes in the NotesAppV1 application. It provides a user interface for inputting
 a note's title and content, and handles the logic for saving new notes to the
 Core Data store. The view is presented modally from the main ContentView when
 the user initiates the process of adding a new note.
 */

import SwiftUI
import CoreData

/// AddNoteView: A view for adding a new note
struct AddNoteView: View {
    // MARK: - Properties
    
    /// The managed object context from the environment, used for Core Data operations
    @Environment(\.managedObjectContext) private var viewContext
    
    /// Environment value to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    /// State variables to hold the new note's title and content
    @State private var title = ""
    @State private var content = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    
    /// Saves a new note to Core Data
    private func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.createdAt = Date()
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

/// Preview provider for AddNoteView
struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
