//
//  GroceryListItem.swift
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
This file defines the GroceryListItem class for the Grocery List app version 6.
It represents a single item in the grocery list, using SwiftData for data modeling
and persistence. This version includes enhanced price tracking, a relationship to
PriceHistory for monitoring price changes over time, and additional utility methods.

Key components:
- Properties for item details including title, subtitle, date, completion status, and current price
- Relationship to PriceHistory for tracking price changes
- Initialization with price
- Computed property for formatted date string
- Methods for updating price, recording price history, and toggling completion status
- Utility methods for price analysis (price difference, percentage change)
*/

import Foundation
import SwiftData

@Model
final class GroceryListItem {
    // MARK: - Properties
    
    /// The main title of the grocery item
    var title: String
    
    /// Additional information about the grocery item
    var subtitle: String
    
    /// The date when the item was created or last modified
    var date: Date
    
    /// Indicates whether the item has been completed (e.g., purchased)
    var isCompleted: Bool
    
    /// The current price of the item
    var currentPrice: Double
    
    /// Array of PriceHistory objects to track price changes over time
    @Relationship(deleteRule: .cascade) var priceHistory: [PriceHistory]

    // MARK: - Initialization
    
    /// Initializes a new GroceryListItem
    /// - Parameters:
    ///   - title: The main title of the item
    ///   - subtitle: Additional information about the item
    ///   - date: The creation or modification date (defaults to current date)
    ///   - isCompleted: The completion status (defaults to false)
    ///   - currentPrice: The current price of the item
    init(title: String, subtitle: String, date: Date = Date(), isCompleted: Bool = false, currentPrice: Double) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.isCompleted = isCompleted
        self.currentPrice = currentPrice
        self.priceHistory = [PriceHistory(price: currentPrice, date: date)]
    }
    
    // MARK: - Computed Properties
    
    /// Returns a formatted string representation of the item's date
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    // MARK: - Methods
    
    /// Updates the current price and adds a new entry to the price history if the price has changed
    /// - Parameter newPrice: The new price to set for the item
    func updatePrice(_ newPrice: Double) {
        if newPrice != currentPrice {
            currentPrice = newPrice
            priceHistory.append(PriceHistory(price: newPrice, date: Date()))
            date = Date() // Update the modification date
        }
    }
    
    /// Toggles the completion status of the item
    func toggleCompletion() {
        isCompleted.toggle()
        date = Date() // Update the modification date
    }
    
    /// Calculates the price difference between the current price and the initial price
    /// - Returns: The price difference as a Double
    func priceDifference() -> Double {
        guard let initialPrice = priceHistory.first?.price else { return 0 }
        return currentPrice - initialPrice
    }
    
    /// Calculates the percentage change in price since the item was added
    /// - Returns: The percentage change as a Double
    func pricePercentageChange() -> Double {
        guard let initialPrice = priceHistory.first?.price, initialPrice != 0 else { return 0 }
        return ((currentPrice - initialPrice) / initialPrice) * 100
    }
    
    /// Calculates the average price of the item over its history
    /// - Returns: The average price as a Double
    func averagePrice() -> Double {
        let totalPrice = priceHistory.reduce(0) { $0 + $1.price }
        return totalPrice / Double(priceHistory.count)
    }
    
    /// Determines if the current price is the highest in the item's history
    /// - Returns: A Boolean indicating if the current price is the highest
    func isCurrentPriceHighest() -> Bool {
        return currentPrice == priceHistory.map { $0.price }.max() ?? currentPrice
    }
    
    /// Determines if the current price is the lowest in the item's history
    /// - Returns: A Boolean indicating if the current price is the lowest
    func isCurrentPriceLowest() -> Bool {
        return currentPrice == priceHistory.map { $0.price }.min() ?? currentPrice
    }
}
