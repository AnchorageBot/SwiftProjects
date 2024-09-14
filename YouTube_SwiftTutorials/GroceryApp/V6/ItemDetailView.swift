//
//  ItemDetailView.swift
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
This file contains the ItemDetailView for the Grocery List app version 6.
It provides a detailed view for a single grocery item, allowing users to view
and update item information, including price history and completion status.

Key components:
- Display of item details (title, subtitle, current price, added date)
- Form for updating the item's price and other details
- List view of price history with price change indicators
- Completion status toggle
- Error handling for price updates
- Chart view of price history
*/

import SwiftUI
import SwiftData
import Charts

struct ItemDetailView: View {
    // MARK: - Properties
    
    /// The grocery item to display and edit
    @Bindable var item: GroceryListItem
    
    /// Access to the app storage manager
    @EnvironmentObject private var appStorageManager: AppStorageManager
    
    /// State variable to hold the new price input
    @State private var newPrice = ""
    
    /// State variable to show error alert
    @State private var showAlert = false
    
    /// State variable to hold error message
    @State private var errorMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        Form {
            itemDetailsSection
            updatePriceSection
            completionToggleSection
            priceHistorySection
            priceHistoryChartSection
        }
        .navigationTitle(item.title)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - View Sections
    
    /// Section for displaying item details
    private var itemDetailsSection: some View {
        Section(header: Text("Item Details")) {
            Text("Title: \(item.title)")
            Text("Subtitle: \(item.subtitle)")
            Text("Current Price: \(appStorageManager.defaultCurrency) \(item.currentPrice, specifier: "%.2f")")
            Text("Added on: \(item.formattedDate)")
        }
    }
    
    /// Section for updating the item's price
    private var updatePriceSection: some View {
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
    }
    
    /// Section for toggling completion status
    private var completionToggleSection: some View {
        Section {
            Toggle("Completed", isOn: $item.isCompleted)
        }
    }
    
    /// Section for displaying price history
    private var priceHistorySection: some View {
        Section(header: Text("Price History")) {
            ForEach(Array(item.priceHistory.enumerated().reversed()), id: \.element.id) { index, history in
                HStack {
                    Text("\(appStorageManager.defaultCurrency) \(history.price, specifier: "%.2f")")
                    Spacer()
                    Text(history.formattedDate)
                    if index < item.priceHistory.count - 1 {
                        priceChangeIndicator(currentPrice: history.price, previousPrice: item.priceHistory[index + 1].price)
                    }
                }
            }
        }
    }
    
    /// Section for displaying price history chart
    private var priceHistoryChartSection: some View {
        Section(header: Text("Price History Chart")) {
            Chart {
                ForEach(item.priceHistory) { history in
                    LineMark(
                        x: .value("Date", history.date),
                        y: .value("Price", history.price)
                    )
                    .foregroundStyle(Color.blue)
                    
                    PointMark(
                        x: .value("Date", history.date),
                        y: .value("Price", history.price)
                    )
                    .foregroundStyle(Color.blue)
                }
            }
            .frame(height: 200)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 3)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month().day())
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
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
    
    /// Returns a view indicating the price change direction
    /// - Parameters:
    ///   - currentPrice: The current price
    ///   - previousPrice: The previous price
    /// - Returns: An image view showing an up or down arrow based on price change
    private func priceChangeIndicator(currentPrice: Double, previousPrice: Double) -> some View {
        if currentPrice > previousPrice {
            return Image(systemName: "arrow.up")
                .foregroundColor(.red)
        } else if currentPrice < previousPrice {
            return Image(systemName: "arrow.down")
                .foregroundColor(.green)
        } else {
            return Image(systemName: "arrow.forward")
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Preview
#Preview {
    let sampleItem = GroceryListItem(title: "Sample Item", subtitle: "Sample Subtitle", currentPrice: 9.99)
    return ItemDetailView(item: sampleItem)
        .environmentObject(AppStorageManager())
}
