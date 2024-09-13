//
// GroceryListV4
// PriceHistory.swift
//
// Created on 9/12/24
// Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file defines the PriceHistory class, which represents a single price entry
in the history of a grocery item's price changes. It uses SwiftData for data modeling
and persistence, allowing for efficient tracking and querying of price histories.

Key components:
- Properties for storing the price and the date of the price change
- Initialization with price and optional date
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
}
