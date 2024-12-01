//
// PDSUI_ModuleOne_Ex2App.swift
// PDSUI_ModuleOne_Ex2
//
// Abstract:
// The main application entry point for the budget tracking app. This file
// initializes the app's data and configures the primary window scene.
// It serves as the root of the application, managing the initial state
// and view hierarchy.
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 2

import SwiftUI

/// The main app structure and entry point
@main
struct PDSUI_ModuleOne_Ex2App: App {
    // MARK: - Properties
    
    /// Sample financial entries for the application
    /// In a real app, this would likely be replaced with data from persistent storage
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
    
    // MARK: - Scene
    
    /// The main scene of the application
    /// Configures the primary window and its content
    var body: some Scene {
        WindowGroup {
            ContentView(entries: entries)
        }
    }
}
