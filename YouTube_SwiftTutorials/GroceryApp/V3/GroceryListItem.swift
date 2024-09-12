//
// GroceryListV3
// GroceryListItem.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
// Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file defines the GroceryListItem class, which represents a single item in the grocery list.
It uses SwiftData for data modeling and persistence.

Key components:
- Title of the grocery item
- Subtitle for additional information
- Date of creation or last modification
- Completion status of the item
*/

import Foundation
import SwiftData

@Model
class GroceryListItem {
    // MARK: - Properties
    
    /// The name or title of the grocery item
    let title: String
    
    /// Additional information about the item (e.g., brand, size)
    let subtitle: String
    
    /// The date when the item was added or last modified
    let date: Date
    
    /// Indicates whether the item has been purchased or completed
    var isCompleted: Bool
    
    // MARK: - Initializer
    
    /// Creates a new GroceryListItem
    /// - Parameters:
    ///   - title: The name of the item
    ///   - subtitle: Additional details about the item
    ///   - date: The date of creation (defaults to current date)
    ///   - isCompleted: The completion status (defaults to false)
    init(title: String, subtitle: String, date: Date = Date(), isCompleted: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.isCompleted = isCompleted
    }
    
    // MARK: - Helper Methods
    
    /// Returns a formatted string representation of the item's date
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
