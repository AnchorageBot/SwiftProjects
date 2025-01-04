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
// Abstract:
// This application implements ...

import SwiftUI

struct CardsListView: View {
    
    // This line is added at the beginning of the CardsListView struct, declaring a state variable to control the presentation of the fullScreenCover
    @State private var isPresented = false
    
    var body: some View {
        
            // This turns the scroll bar off
            ScrollView(showsIndicators: false) {
                
            VStack {
                // This places ten shapes in a scrollable VStack
                ForEach(0..<10) { _ in
                    CardThumbnail()
                        // This modifier ensures that each individual card thumbnail can trigger the presentation of SingleCardView.
                        .onTapGesture {
                          isPresented = true
                        }

                }
            }
        }
            // This modifier ensures that the full-screen cover is presented over the entire list view.
            .fullScreenCover(isPresented: $isPresented) {
              SingleCardView()
            }
    }
}

#Preview {
    CardsListView()
}


