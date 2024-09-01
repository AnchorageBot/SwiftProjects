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

import SwiftUI
import CoreData

/// ContentView: The main view of the Notes app.
/// This view displays a list of notes, allows adding new notes, and deleting existing ones.
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

/// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
