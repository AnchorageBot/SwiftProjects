//
// Cards
// ContentView.swift
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

/// Main view of the application
/// Provides the primary user interface for the Cards app
struct ContentView: View {
    
    /// The main view body
    /// Organizes content into collapsible sections with iOS native styling
    var body: some View {
        NavigationView { // Embed in NavigationView for proper fullScreenCover presentation
                    CardsListView()
                        // Optional: Adds a navigation title
                        .navigationTitle("Cards")
                        // This centers the title
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }

#Preview {
    ContentView()
}
