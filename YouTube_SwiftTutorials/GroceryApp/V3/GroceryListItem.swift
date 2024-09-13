//
//  GroceryListItem.swift
//  GroceryListV3
//
//  Created on 9/10/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
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
- Computed property for formatted date string
*/

import Foundation
import SwiftData

@Model
final class GroceryListItem {
    // MARK: - Properties
    
    /// The main title of the grocery item
    let title: String
    
    /// Additional information about the grocery item
    let subtitle: String
    
    /// The date when the item was created or last modified
    let date: Date
    
    /// Indicates whether the item has been completed (e.g., purchased)
    var isCompleted: Bool
    
    // MARK: - Initialization
    
    /// Initializes a new GroceryListItem
    /// - Parameters:
    ///   - title: The main title of the item
    ///   - subtitle: Additional information about the item
    ///   - date: The creation or modification date (defaults to current date)
    ///   - isCompleted: The completion status (defaults to false)
    init(title: String, subtitle: String, date: Date = Date(), isCompleted: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.isCompleted = isCompleted
    }
    
    // MARK: - Computed Properties
    
    /// Returns a formatted string representation of the item's date
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
