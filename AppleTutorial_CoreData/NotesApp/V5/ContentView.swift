//
// NotesAppV1
// ContentView.swift
//
// Created on 8/31/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file contains the ContentView structure, which serves as the main view
 for the NotesAppV1 application. It displays a list of all notes, handles navigation
 to individual note details, and provides functionality to add new notes and delete
 existing ones. The view uses Core Data to fetch and display notes, and integrates
 with AddNoteView for creating new notes and NoteDetailView for viewing/editing
 existing notes.
 */

import SwiftUI
import CoreData

/// ContentView: The main view of the Notes app.
/// This view displays a list of notes and allows for adding new notes and deleting existing ones.
struct ContentView: View {
    // MARK: - Properties
    
    /// The managed object context from the environment, used for Core Data operations
    @Environment(\.managedObjectContext) private var viewContext
    
    /// A fetch request to retrieve all Note entities, sorted by creation date
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)],
        animation: .default)
    private var notes: FetchedResults<Note>
    
    /// State variable to control the presentation of the add note view
    @State private var isAddingNote = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "Untitled")
                                .font(.headline)
                            Text(note.content ?? "No content")
                                .font(.subheadline)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingNote = true }) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNote) {
                AddNoteView().environment(\.managedObjectContext, viewContext)
            }
        }
    }
    
    // MARK: - Methods
    
    /// Deletes notes at the specified offsets from the notes array
    /// - Parameter offsets: IndexSet indicating which notes to delete
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

/// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
