//
//  AppStorageManager.swift
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
This file defines the AppStorageManager class for the Grocery List app version 6.
It manages user preferences using @AppStorage property wrappers, allowing for
persistent storage of app settings across launches.

Key components:
- Default currency preference
- Show completed items toggle
- Sort order preference
- SortOrder enum defining available sorting options
*/

import SwiftUI

class AppStorageManager: ObservableObject {
    @AppStorage("defaultCurrency") var defaultCurrency: String = "USD"
    @AppStorage("showCompleted") var showCompleted: Bool = true
    @AppStorage("sortOrder") var sortOrder: SortOrder = .dateAdded
    
    enum SortOrder: String, CaseIterable {
        case dateAdded = "Date Added"
        case alphabetical = "Alphabetical"
        case price = "Price"
    }
}
