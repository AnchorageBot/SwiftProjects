//
// ContentView.swift
// PDSUI_ModuleOne_Ex2
//
// Abstract:
// A SwiftUI view implementation for a budget tracking application that displays
// a list of financial entries. The view presents income and expenses in a
// navigable list format with color-coded amounts for easy visualization.
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 2

import SwiftUI

/// The main content view for the budget tracking application
struct ContentView: View {
    // MARK: - Properties
    
    /// Array of financial entries to be displayed in the list
    let entries: [FinancialEntry]
    
    // MARK: - Body
    
    /// The main view hierarchy
    var body: some View {
        // NavigationView provides the navigation stack and title functionality
        NavigationView {
            // Create a sectioned list to display financial entries
            List {
                Section(header: Text("Entries")) {
                    // Iterate through entries and create rows
                    ForEach(entries) { entry in
                        FinancialEntryRow(entry: entry)
                    }
                }
            }
            .navigationTitle("Budget Tracker")
        }
    }
}

// MARK: - Preview Provider

#Preview {
    // Create sample entries for the preview
    let sampleEntries = [
        FinancialEntry(amount: 3000, category: "Income", isExpense: false),
        FinancialEntry(amount: 120, category: "Groceries", isExpense: true)
    ]
    return ContentView(entries: sampleEntries)
}