//
// FinancialEntry.swift
// PDSUI_ModuleOne_Ex2
//
// Abstract:
// Defines the core data model for financial transactions in the budget tracking app.
// This model represents individual financial entries with properties for amount,
// category, and transaction type (income vs expense). The model conforms to
// Identifiable to support SwiftUI list functionality.
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 2

import SwiftUI

/// Represents a single financial transaction in the budget tracker
struct FinancialEntry: Identifiable {
    // MARK: - Properties
    
    /// Unique identifier for the entry, automatically generated
    let id = UUID()
    
    /// The monetary amount of the transaction
    /// This value is stored as a Double to support decimal amounts
    var amount: Double
    
    /// The category of the transaction (e.g., "Groceries", "Income")
    /// Used to organize and group related transactions
    var category: String
    
    /// Indicates whether this entry represents an expense (true) or income (false)
    /// This boolean flag determines how the entry is displayed and processed
    let isExpense: Bool
}
