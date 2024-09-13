//
//  ContentView.swift
//  GroceryListV4
//
//  Created on 9/12/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file contains the main view (ContentView) and a detail view (ItemDetailView) for the Grocery List app.
It provides a user interface for adding, viewing, updating, and deleting grocery list items with price tracking.
The view uses SwiftUI for the interface and SwiftData for data management.

Key components:
- Text fields for entering new items with prices
- Save button to add new items to the list
- List view to display all grocery items with their current prices
- Navigation to a detail view for each item
- Swipe-to-delete functionality for removing items
- Empty state handling when the list is empty
- Detail view for updating prices and viewing price history
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
    
    /// Query to fetch all GroceryListItems from SwiftData
    @Query private var items: [GroceryListItem]
    
    // MARK: - Body
    
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
        guard !newItemString.isEmpty, let price = Double(newItemPrice) else { return }
        
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
}

// MARK: - Item Detail View

/// View for displaying and editing details of a single grocery item
struct ItemDetailView: View {
    /// The grocery item to display and edit
    @Bindable var item: GroceryListItem
    
    /// State variable to hold the new price input
    @State private var newPrice = ""
    
    var body: some View {
        Form {
            // Section for displaying item details
            Section(header: Text("Item Details")) {
                Text("Title: \(item.title)")
                Text("Subtitle: \(item.subtitle)")
                Text("Current Price: $\(item.currentPrice, specifier: "%.2f")")
                Text("Added on: \(item.formattedDate)")
            }
            
            // Section for updating the item's price
            Section(header: Text("Update Price")) {
                HStack {
                    TextField("New Price", text: $newPrice)
                        .keyboardType(.decimalPad)
                    Button("Update") {
                        if let newPriceValue = Double(newPrice) {
                            item.updatePrice(newPriceValue)
                            newPrice = ""
                        }
                    }
                    .disabled(newPrice.isEmpty)
                }
            }
            
            // Section for displaying price history
            Section(header: Text("Price History")) {
                ForEach(item.priceHistory, id: \.date) { history in
                    HStack {
                        Text("$\(history.price, specifier: "%.2f")")
                        Spacer()
                        Text(history.date.formatted(date: .abbreviated, time: .shortened))
                    }
                }
            }
        }
        .navigationTitle(item.title)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
