//
// BasicMath
// NumberListItem.swift
//
// Created on 9/15/24
// Swift Version 5.0
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file defines the NumberListItem class, which represents a single item in the number list.
It uses SwiftData for data modeling and persistence.

Key components:
- Title of the number item
- Subtitle for additional information
- Date of creation or last modification
- Classificaton of the number (odd, even, and/or prime)
 
*/

import Foundation
import SwiftData

@Model
class NumberListItem {
    
    // MARK: - Properties
    
    /// The main title of the number item
    let title: String
    
    /// Additional information about the number item (odd, even, prime)
    let subtitle: String
    
    /// The date when the item was created or last modified
    let date: Date
    
    init(title: String, subtitle: String, date: Date) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
}
