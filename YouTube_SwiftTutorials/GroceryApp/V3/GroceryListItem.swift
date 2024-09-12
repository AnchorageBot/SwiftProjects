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
final class GroceryListItem {
    let title: String
    let subtitle: String
    let date: Date
    var isCompleted: Bool
    
    init(title: String, subtitle: String, date: Date = Date(), isCompleted: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.isCompleted = isCompleted
    }
    
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
