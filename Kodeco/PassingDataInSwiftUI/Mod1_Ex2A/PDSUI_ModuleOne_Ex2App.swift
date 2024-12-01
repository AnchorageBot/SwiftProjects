//
// PDSUI_ModuleOne_Ex2App.swift
// PDSUI_ModuleOne_Ex2
//
// Abstract:
// The main application file for a budget tracking app built with SwiftUI.
// Defines the core data model, custom views, and application entry point.
// Implements a financial entry system that distinguishes between income
// and expenses with visual indicators.
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 2

import SwiftUI

// MARK: - Model

/// Represents a single financial transaction in the budget tracker
struct FinancialEntry: Identifiable {
    /// Unique identifier for the entry
    let id = UUID()
    
    /// The monetary amount of the transaction
    var amount: Double
    
    /// The category of the transaction (e.g., "Groceries", "Income")
    var category: String
    
    /// Indicates whether this entry represents an expense (true) or income (false)
    let isExpense: Bool
}

// MARK: - Views

/// A custom view representing a single row in the financial entries list
struct FinancialEntryRow: View {
    /// The financial entry to display in this row
    let entry: FinancialEntry
    
    var body: some View {
        HStack {
            // Display transaction type (Income/Expense)
            Text(entry.isExpense ? "Expense" : "Income")
            Spacer()
            // Display amount with color coding (red for expenses, green for income)
            Text("$\(entry.amount, specifier: "%.2f")")
                .foregroundColor(
                    entry.isExpense ? .red : .green
                )
        }
    }
}

// MARK: - App

/// The main app structure and entry point
@main
struct PDSUI_ModuleOne_Ex2App: App {
    /// Sample financial entries for the application
    let entries = [
        FinancialEntry(
            amount: 3000,
            category: "Income",
            isExpense: false
        ),
        FinancialEntry(
            amount: 120,
            category: "Groceries",
            isExpense: true
        ),
        FinancialEntry(
            amount: 500,
            category: "Technology",
            isExpense: true
        ),
        FinancialEntry(
            amount: 10,
            category: "Subscription",
            isExpense: true
        )
    ]
    
    /// The main scene of the application
    var body: some Scene {
        WindowGroup {
            ContentView(entries: entries)
        }
    }
}
