//
// Cards
// CardsApp.swift
//
// Created on 1/1/25
// Swift Version 6.0
//
// ATS Project
// Kodeco Swift UI Apprentice 23 Tutorial
//
// Abstract:
// This application implements ...


import SwiftUI

/// Main application entry point for the Cards app
/// Conforms to the App protocol to establish the SwiftUI app lifecycle

@main
struct CardsApp: App {
    /// The root view of the application
    /// Creates a single window group containing the ContentView
    /// ContentView serves as the main interface for the
    var body: some Scene {
        WindowGroup {
            ContentView() 
        }
    }
}
