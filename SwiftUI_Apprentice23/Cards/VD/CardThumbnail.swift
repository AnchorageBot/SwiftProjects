//
// Cards
// CardThumbnail.swift
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

/// A view representing a thumbnail of a card.
struct CardThumbnail: View {
    /// The main content of the CardThumbnail view.
    var body: some View {
        RoundedRectangle(cornerRadius: 15) // Creates a rounded rectangle shape.
            .foregroundColor(.gray)       // Sets the fill color of the rectangle to gray.
            .frame(width: 150, height: 250) // Sets the dimensions of the rectangle.
    }
}

/// A preview provider for the CardThumbnail view, used in Xcode's canvas.
#Preview {
    CardThumbnail()
}
