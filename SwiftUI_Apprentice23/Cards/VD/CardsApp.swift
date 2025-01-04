//
// Cards
// CardsApp.swift
//
// Created on 1/1/25
// Swift Version 6.0
//
// ATS Project
// Kodeco Swift UI Apprentice 23 Tutorial
// Tutor: Google's Gemini 2.0 Experimental
//
// Abstract:  This SwiftUI application serves as a foundation for a card-based information display system. It currently implements a scrollable list of card thumbnails with full-screen detail views. Future development will include features such as [mention planned features, e.g., data loading from a remote source, user interaction with card details, etc.]


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
