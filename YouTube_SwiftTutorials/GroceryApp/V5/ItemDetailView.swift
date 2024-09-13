//
//  ItemDetailView.swift
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
This file contains the ItemDetailView for the Grocery List app version 5.
It provides a detailed view for a single grocery item, allowing users to view
and update item information, including price history.

Key components:
- Display of item details (title, subtitle, current price, added date)
- Form for updating the item's price
- List view of price history
- Error handling for price updates
*/

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    // MARK: - Properties
    
    /// The grocery item to display and edit
    @Bindable var item: GroceryListItem
    
    /// State variable to hold the new price input
    @State private var newPrice = ""
    
    /// State variable to show error alert
    @State private var showAlert = false
    
    /// State variable to hold error message
    @State private var errorMessage = ""
    
    // MARK: - Body
    
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
                        updatePrice()
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Helper Functions
    
    /// Updates the item's price if the input is valid
    private func updatePrice() {
        guard let newPriceValue = Double(newPrice), newPriceValue >= 0 else {
            showError("Invalid price. Please enter a non-negative number")
            return
        }
        
        item.updatePrice(newPriceValue)
        newPrice = ""
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
    // Create a sample item for preview
    let item = GroceryListItem(title: "Sample Item", subtitle: "Sample Subtitle", currentPrice: 9.99)
    return ItemDetailView(item: item)
}
