//
//  ContentView.swift
//  GroceryListV3
//
//  Created on 9/10/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
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
    // Access the SwiftData model context
    @Environment(\.modelContext) private var context
    
    // State variable to hold the text for a new item
    @State private var newItemString = ""
    
    // Query to fetch all GroceryListItems from SwiftData
    @Query private var items: [GroceryListItem]
    
    var body: some View {
        NavigationView {
            VStack {
                inputSection
                itemsList
            }
            .navigationTitle("Grocery List")
        }
    }
    
    // MARK: - Input Section
    private var inputSection: some View {
        HStack {
            // Text field for entering new items
            TextField("Add item", text: $newItemString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Button to save the new item
            Button(action: saveItem) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(newItemString.isEmpty)
        }
        .padding()
    }
    
    // MARK: - Items List
    private var itemsList: some View {
        List {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(item.formattedDate)
                        .font(.caption)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .overlay {
            // Show a message when the list is empty
            if items.isEmpty {
                Text("No items")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Helper Functions
    
    /// Saves a new item to the list
    private func saveItem() {
        guard !newItemString.isEmpty else { return }
        
        // Create and insert a new GroceryListItem
        let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP")
        context.insert(newItem)
        
        // Clear the input field
        newItemString = ""
    }
    
    /// Deletes items at the specified offsets from the list
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(items[index])
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
