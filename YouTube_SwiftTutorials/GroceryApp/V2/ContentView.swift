//
// GroceryListV2
// ContentView.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Afraz Siddiqui - iOS Academy YouTube
// Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file contains the main view of the GroceryListV2 app.
It manages the user interface for adding, displaying, and deleting grocery list items.

App strategy:
* Model: Data (GroceryListItem)
* Container: Where things are saved (SwiftData modelContainer)
* Context: How user interacts with the app (Environment modelContext)
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // Access the SwiftData model context
    @Environment(\.modelContext) var context
    
    // State variable to hold the text for a new item
    @State var newItemString = ""
    
    // Query to fetch all GroceryListItems
    @Query var items: [GroceryListItem]
    
    var body: some View {
        NavigationView {
            VStack {
                // Text field for adding new items
                TextField("Add item", text: $newItemString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Button to save new items
                Button("Save") {
                    guard !newItemString.isEmpty else {
                        return
                    }
                    
                    // Create and insert a new item
                    let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP", date: Date())
                    context.insert(newItem)
                    
                    // Clear the text field
                    newItemString = ""
                }
                
                // List of grocery items
                List {
                    ForEach(items) { item in
                        Text(item.title)
                    }
                    .onDelete { indexSet in
                        // Delete selected items
                        indexSet.forEach { index in
                            context.delete(items[index])
                        }
                    }
                }
                .overlay {
                    // Show a message when the list is empty
                    if items.isEmpty {
                        Text("No items")
                    }
                }
            }
            .navigationTitle("Grocery List")
        }
    }
}

#Preview {
    ContentView()
}
