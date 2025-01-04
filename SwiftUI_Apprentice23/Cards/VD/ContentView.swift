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

/// The main content view of the application, responsible for displaying the card list.
struct ContentView: View {
    /// The main content of the ContentView.
    var body: some View {
        NavigationView { // Embeds the content in a NavigationView to enable navigation features (like fullScreenCover presentation).
            CardsListView() // Displays the list of card thumbnails.
                .navigationTitle("Cards") // Sets the title of the navigation bar.
                .navigationBarTitleDisplayMode(.inline) // Centers the navigation bar title.
        }
    }
}

/// A preview provider for the ContentView, used in Xcode's canvas.
#Preview {
    ContentView()
}
