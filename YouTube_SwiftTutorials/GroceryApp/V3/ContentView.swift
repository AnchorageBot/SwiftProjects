//
// GroceryList
// ContentView.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file contains the main view (ContentView) for the Grocery List app.
It provides a user interface for adding, viewing, and deleting grocery list items.
The view uses SwiftUI for the interface and SwiftData for data management.

Key components:
- Text field for entering new items
- Save button to add new items to the list
- List view to display all grocery items
- Swipe-to-delete functionality for removing items
- Empty state handling when the list is empty
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - Properties
    
    /// The SwiftData model context for managing data operations
    @Environment(\.modelContext) private var context
    
    /// State variable to hold the text for new items
    @State private var newItemString = ""
    
    /// Query to fetch all GroceryListItems from SwiftData
    @Query private var items: [GroceryListItem]
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                // Input field and save button
                inputSection
                
                // List of grocery items
                itemsList
            }
            .navigationTitle("Grocery List")
        }
    }
    
    // MARK: - View Components
    
    /// Input section for adding new items
    private var inputSection: some View {
        VStack {
            TextField("Add item", text: $newItemString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save", action: saveItem)
                .disabled(newItemString.isEmpty)
        }
        .padding()
    }
    
    /// List view for displaying grocery items
    private var itemsList: some View {
        List {
            ForEach(items) { item in
                Text(item.title)
            }
            .onDelete(perform: deleteItems)
        }
        .overlay {
            if items.isEmpty {
                Text("No items")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Saves a new item to the list
    private func saveItem() {
        guard !newItemString.isEmpty else { return }
        
        let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP", date: Date())
        context.insert(newItem)
        newItemString = ""
    }
    
    /// Deletes items at the specified offsets from the list
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            context.delete(items[index])
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
