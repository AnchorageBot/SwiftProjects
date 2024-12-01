//
// FinancialEntryRow.swift
// PDSUI_ModuleOne_Ex2
//
// Abstract:
// Implements a custom SwiftUI view for displaying individual financial entries
// in a list format. The view provides a consistent layout for financial
// transactions, including visual indicators for distinguishing between income
// and expenses through color coding.
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 2

import SwiftUI

/// A custom view representing a single row in the financial entries list
struct FinancialEntryRow: View {
    // MARK: - Properties
    
    /// The financial entry to display in this row
    /// This property determines the content and appearance of the row
    let entry: FinancialEntry
    
    // MARK: - Body
    
    /// Defines the view's layout and appearance
    var body: some View {
        HStack {
            // Display transaction type (Income/Expense)
            // Uses conditional text based on the entry's isExpense property
            Text(entry.isExpense ? "Expense" : "Income")
                .foregroundColor(.primary)
            
            Spacer()
            
            // Display amount with color coding (red for expenses, green for income)
            // Formats the amount to always show two decimal places
            Text("$\(entry.amount, specifier: "%.2f")")
                .foregroundColor(
                    entry.isExpense ? .red : .green
                )
        }
        .padding(.vertical, 4)
    }
}
