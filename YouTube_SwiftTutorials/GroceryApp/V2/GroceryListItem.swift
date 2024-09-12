//
// GroceryListV2
// GroceryListItem.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Afraz Siddiqui - iOS Academy YouTube
// Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file defines the GroceryListItem model class.
It represents a single item in the grocery list and is managed by SwiftData.
*/

import Foundation
import SwiftData

@Model
class GroceryListItem {
    let title: String
    let subtitle: String
    let date: Date
    
    init(title: String, subtitle: String, date: Date) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
}
