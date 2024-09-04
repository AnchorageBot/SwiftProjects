//
// NotesAppV1
// NoteDetailView.swift
//
// Created on 9/1/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file contains the NoteDetailView structure, which is responsible for
 displaying and editing individual notes in the NotesAppV1 application. It
 provides an interface for viewing and modifying a note's title and content,
 and handles saving changes back to the Core Data store. This view is presented
 when a user selects a specific note from the main ContentView list.
 */

import SwiftUI
import CoreData

/// NoteDetailView: A view for displaying and editing an existing note
struct NoteDetailView: View {
    // MARK: - Properties
    
    /// The managed object context from the environment, used for Core Data operations
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The note being displayed and edited
    @ObservedObject var note: Note
    
    // MARK: - Body
    
    var body: some View {
        Form {
            TextField("Title", text: Binding(
                get: { self.note.title ?? "" },
                set: { self.note.title = $0 }
            ))
            TextEditor(text: Binding(
                get: { self.note.content ?? "" },
                set: { self.note.content = $0 }
            ))
        }
        .navigationTitle("Edit Note")
        .navigationBarItems(trailing: Button("Save") {
            saveNote()
        })
    }
    
    // MARK: - Methods
    
    /// Saves changes to an existing note
    private func saveNote() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

/// Preview provider for NoteDetailView
struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let newNote = Note(context: context)
        newNote.id = UUID()
        newNote.title = "Sample Note"
        newNote.content = "This is a sample note content."
        newNote.createdAt = Date()
        
        return NoteDetailView(note: newNote)
            .environment(\.managedObjectContext, context)
    }
}
