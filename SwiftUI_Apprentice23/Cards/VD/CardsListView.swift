//
// Cards
// CardsListView.swift
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

/// A view displaying a scrollable list of card thumbnails.
struct CardsListView: View {
    /// A state variable controlling the presentation of the full-screen card view.
    @State private var isPresented = false

    /// The main content of the CardsListView.
    var body: some View {
        ScrollView(showsIndicators: false) { // Creates a scroll view, hiding the scroll indicators.
            VStack { // Arranges the card thumbnails vertically.
                ForEach(0..<10) { _ in // Iterates 10 times to create 10 card thumbnails.
                    CardThumbnail() // Creates a single card thumbnail view.
                        .onTapGesture { // Adds a tap gesture recognizer to each thumbnail.
                            isPresented = true // When tapped, sets isPresented to true, triggering the full-screen presentation.
                        }
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) { // Presents a full-screen modal view when isPresented is true.
            SingleCardView() // The view to present in full screen.
        }
    }
}

/// A preview provider for the CardsListView, used in Xcode's canvas.
#Preview {
    CardsListView()
}
