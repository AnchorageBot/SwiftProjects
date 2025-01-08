//
// Cards
// SingleCardView.swift
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

/// A view representing the detailed, full-screen view of a single card.
struct SingleCardView: View {
    
    /// Environment object dismisses a modal to SingleCardView
    @Environment(\.dismiss) var dismiss
    
    /// The main content of the SingleCardView.
    var body: some View {
        NavigationStack {
            Color.yellow // Sets the background color of the view to yellow. This is a placeholder; you'll likely replace this with more complex content.
            
            /// toolbar modifier
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }

    }
}

/// A preview provider for the SingleCardView, used in Xcode's canvas.
#Preview {
    SingleCardView()
}
