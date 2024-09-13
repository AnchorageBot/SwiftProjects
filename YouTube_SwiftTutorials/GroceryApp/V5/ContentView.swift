//
//  ContentView.swift
//  GroceryListV5
//
//  Created on 9/13/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file contains the main view (ContentView) for the Grocery List app version 5.
It provides a user interface for adding and viewing grocery list items with price tracking.
The view uses SwiftUI for the interface and SwiftData for data management.

Key components:
- Text fields for entering new items with prices
- Save button to add new items to the list
- List view to display all grocery items with their current prices
- Navigation to a detail view for each item
- Swipe-to-delete functionality for removing items
- Empty state handling when the list is empty
- Improved error handling and input validation
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - Properties
    
    /// Access to the SwiftData model context
    @Environment(\.modelContext) private var context
    
    /// State variable to hold the text for a new item
    @State private var newItemString = ""
    
    /// State variable to hold the price for a new item
    @State private var newItemPrice = ""
    
    /// State variable to show error alert
    @State private var showAlert = false
    
    /// State variable to hold error message
    @State private var errorMessage = ""
    
    /// Query to fetch all GroceryListItems from SwiftData, sorted by date
    @Query(sort: \GroceryListItem.date, order: .reverse) private var items: [GroceryListItem]
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                inputSection
                itemsList
            }
            .navigationTitle("Grocery List")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Input Section
    
    /// View for inputting new items
    private var inputSection: some View {
        HStack {
            // Text field for entering new items
            TextField("Add item", text: $newItemString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Text field for entering the price
            TextField("Price", text: $newItemPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .frame(width: 80)
            
            // Button to save the new item
            Button(action: saveItem) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(newItemString.isEmpty || newItemPrice.isEmpty)
        }
        .padding()
    }
    
    // MARK: - Items List
    
    /// View for displaying the list of items
    private var itemsList: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("$\(item.currentPrice, specifier: "%.2f")")
                                .font(.headline)
                            Text(item.formattedDate)
                                .font(.caption)
                        }
                    }
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
        guard !newItemString.isEmpty else {
            showError("Item name cannot be empty")
            return
        }
        
        guard let price = Double(newItemPrice), price >= 0 else {
            showError("Invalid price. Please enter a non-negative number")
            return
        }
        
        // Create and insert a new GroceryListItem
        let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP", currentPrice: price)
        context.insert(newItem)
        
        // Clear the input fields
        newItemString = ""
        newItemPrice = ""
    }
    
    /// Deletes items at the specified offsets from the list
    /// - Parameter offsets: The offsets of items to delete
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(items[index])
            }
        }
    }
    
    /// Shows an error alert with the given message
    /// - Parameter message: The error message to display
    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
