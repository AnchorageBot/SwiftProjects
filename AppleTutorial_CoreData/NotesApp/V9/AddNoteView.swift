//
// NotesAppV1
// AddNoteView.swift
//
// Created on 9/1/24
// Updated on 9/3/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

// Abstract:
// This file contains the AddNoteView struct, which is a SwiftUI view for adding new notes in the NotesAppV1 application.
// It provides a user interface for entering a note's title and content, and handles the saving of new notes using Core Data.
// The view includes error handling and user feedback through alerts.

import SwiftUI
import CoreData

/// A SwiftUI view for adding new notes
struct AddNoteView: View {
    // MARK: - Properties
    
    /// The managed object context for Core Data operations
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The presentation mode to manage view dismissal
    @Environment(\.presentationMode) var presentationMode
    
    /// The view model that handles the business logic for adding notes
    @StateObject private var viewModel: AddNoteViewModel
    
    /// State variable to control the display of alert
    @State private var showingAlert = false
    
    /// State variable to store the alert message
    @State private var alertMessage = ""
    
    // MARK: - Initialization
    
    /// Initializes the AddNoteView with a Core Data context
    /// - Parameter context: The NSManagedObjectContext to be used for Core Data operations
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: AddNoteViewModel(context: context))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                // Text field for note title
                TextField("Title", text: $viewModel.title)
                
                // Text editor for note content
                TextEditor(text: $viewModel.content)
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Save button in the navigation bar
                    Button("Save") {
                        saveNote()
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                // Alert to display error messages
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Methods
    
    /// Attempts to save the new note and handles potential errors
    private func saveNote() {
        do {
            try viewModel.saveNote()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // If an error occurs, update the alert message and show the alert
            alertMessage = error.localizedDescription
            showingAlert = true
        }
    }
}

// MARK: - Preview

/// Provides a preview for the AddNoteView
struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(context: PersistenceController.preview.container.viewContext)
    }
}
