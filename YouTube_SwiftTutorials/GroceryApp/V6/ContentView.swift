//
//  ContentView.swift
//  GroceryListV6
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
This file contains the main view (ContentView) for the Grocery List app version 6.
It provides a user interface for adding, viewing, and managing grocery list items with price tracking.
The view uses SwiftUI for the interface and SwiftData for data management.

Key components:
- Scrollable view with GeometryReader for adaptive layout
- Text fields for entering new items with prices
- Save button to add new items to the list
- Sorting options and filter toggle for completed items
- List view to display all grocery items with their current prices
- Navigation to a detail view for each item
- Swipe-to-delete functionality for removing items
- Empty state handling when the list is empty
- Error handling and input validation
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - Properties
    
    /// Access to the SwiftData model context
    @Environment(\.modelContext) private var context
    
    /// Access to the app storage manager for user preferences
    @EnvironmentObject private var appStorageManager: AppStorageManager
    
    /// Query to fetch all GroceryListItems from SwiftData
    @Query private var items: [GroceryListItem]
    
    /// State variable to hold the text for a new item
    @State private var newItemString = ""
    
    /// State variable to hold the price for a new item
    @State private var newItemPrice = ""
    
    /// State variable to control the display of error alerts
    @State private var showAlert = false
    
    /// State variable to hold error messages
    @State private var errorMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        inputSection
                        sortingAndFilterSection
                        itemsList
                    }
                    .padding()
                    // Ensure the content fills at least the full height of the screen
                    .frame(minHeight: geometry.size.height)
                }
            }
            .navigationTitle("Grocery List")
            // Display error alert when showAlert is true
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        // Prevent the keyboard from pushing up the content
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    // MARK: - Input Section
    
    /// View for inputting new items
    private var inputSection: some View {
        HStack {
            // Text field for entering new item name
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
    }
    
    // MARK: - Sorting and Filter Section
    
    /// View for sorting and filtering options
    private var sortingAndFilterSection: some View {
        HStack {
            // Picker for selecting sort order
            Picker("Sort", selection: $appStorageManager.sortOrder) {
                ForEach(AppStorageManager.SortOrder.allCases, id: \.self) { order in
                    Text(order.rawValue).tag(order)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Toggle for showing/hiding completed items
            Toggle("Show Completed", isOn: $appStorageManager.showCompleted)
        }
    }
    
    // MARK: - Items List
    
    /// View for displaying the list of items
    private var itemsList: some View {
        List {
            ForEach(filteredAndSortedItems) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    ItemRowView(item: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(PlainListStyle())
        .overlay {
            // Show a message when the list is empty
            if filteredAndSortedItems.isEmpty {
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
                context.delete(filteredAndSortedItems[index])
            }
        }
    }
    
    /// Shows an error alert with the given message
    /// - Parameter message: The error message to display
    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
    
    /// Computed property to filter and sort items based on user preferences
    private var filteredAndSortedItems: [GroceryListItem] {
        items
            .filter { appStorageManager.showCompleted || !$0.isCompleted }
            .sorted { item1, item2 in
                switch appStorageManager.sortOrder {
                case .dateAdded:
                    return item1.date > item2.date
                case .alphabetical:
                    return item1.title < item2.title
                case .price:
                    return item1.currentPrice < item2.currentPrice
                }
            }
    }
}

// MARK: - ItemRowView

/// View for displaying a single item in the list
struct ItemRowView: View {
    @Bindable var item: GroceryListItem
    @EnvironmentObject private var appStorageManager: AppStorageManager
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isCompleted)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(appStorageManager.defaultCurrency) \(item.currentPrice, specifier: "%.2f")")
                    .font(.headline)
                Text(item.formattedDate)
                    .font(.caption)
            }
        }
        .swipeActions {
            Button(action: { item.toggleCompletion() }) {
                Label(item.isCompleted ? "Mark Incomplete" : "Mark Complete", systemImage: item.isCompleted ? "circle" : "checkmark.circle")
            }
            .tint(.blue)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .modelContainer(for: GroceryListItem.self)
        .environmentObject(AppStorageManager())
}
