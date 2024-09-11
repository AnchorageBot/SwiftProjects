//
// GroceryList
// GroceryListItem.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
//


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
