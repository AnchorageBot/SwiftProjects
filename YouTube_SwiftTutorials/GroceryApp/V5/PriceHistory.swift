//
//  PriceHistory.swift
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
This file defines the PriceHistory class for the Grocery List app version 5.
It represents a single price entry in the history of a grocery item's price changes,
using SwiftData for data modeling and persistence. This version includes additional
utility methods for price comparison and formatting.

Key components:
- Properties for storing the price and the date of the price change
- Initialization with price and optional date
- Utility methods for price comparison and formatting
*/

import Foundation
import SwiftData

@Model
final class PriceHistory {
    // MARK: - Properties
    
    /// The recorded price at a specific point in time
    let price: Double
    
    /// The date when this price was recorded
    let date: Date

    // MARK: - Initialization
    
    /// Initializes a new PriceHistory entry
    /// - Parameters:
    ///   - price: The price to record
    ///   - date: The date of the price (defaults to current date)
    init(price: Double, date: Date = Date()) {
        self.price = price
        self.date = date
    }
    
    // MARK: - Computed Properties
    
    /// Returns a formatted string representation of the price
    var formattedPrice: String {
        String(format: "%.2f", price)
    }
    
    /// Returns a formatted string representation of the date
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    // MARK: - Methods
    
    /// Calculates the price difference between this entry and another PriceHistory entry
    /// - Parameter other: Another PriceHistory entry to compare with
    /// - Returns: The price difference as a Double
    func priceDifference(from other: PriceHistory) -> Double {
        return self.price - other.price
    }
    
    /// Calculates the percentage change in price between this entry and another PriceHistory entry
    /// - Parameter other: Another PriceHistory entry to compare with
    /// - Returns: The percentage change as a Double
    func percentageChange(from other: PriceHistory) -> Double {
        guard other.price != 0 else { return 0 }
        return ((self.price - other.price) / other.price) * 100
    }
}
