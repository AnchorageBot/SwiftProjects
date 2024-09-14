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
- Sorting options for the grocery list
- Filter to show/hide completed items
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var appStorageManager: AppStorageManager
    @Query private var items: [GroceryListItem]
    
    @State private var newItemString = ""
    @State private var newItemPrice = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                inputSection
                sortingAndFilterSection
                itemsList
            }
            .navigationTitle("Grocery List")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private var inputSection: some View {
        HStack {
            TextField("Add item", text: $newItemString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Price", text: $newItemPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .frame(width: 80)
            
            Button(action: saveItem) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(newItemString.isEmpty || newItemPrice.isEmpty)
        }
        .padding()
    }
    
    private var sortingAndFilterSection: some View {
        HStack {
            Picker("Sort", selection: $appStorageManager.sortOrder) {
                ForEach(AppStorageManager.SortOrder.allCases, id: \.self) { order in
                    Text(order.rawValue).tag(order)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Toggle("Show Completed", isOn: $appStorageManager.showCompleted)
        }
        .padding(.horizontal)
    }
    
    private var itemsList: some View {
        List {
            ForEach(filteredAndSortedItems) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    ItemRowView(item: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .overlay {
            if filteredAndSortedItems.isEmpty {
                Text("No items")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func saveItem() {
        guard !newItemString.isEmpty else {
            showError("Item name cannot be empty")
            return
        }
        
        guard let price = Double(newItemPrice), price >= 0 else {
            showError("Invalid price. Please enter a non-negative number")
            return
        }
        
        let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP", currentPrice: price)
        context.insert(newItem)
        
        newItemString = ""
        newItemPrice = ""
    }
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(filteredAndSortedItems[index])
            }
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
    
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

#Preview {
    ContentView()
        .modelContainer(for: GroceryListItem.self)
        .environmentObject(AppStorageManager())
}
