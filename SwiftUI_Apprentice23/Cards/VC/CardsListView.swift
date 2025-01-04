//
// Cards
// CardsListView.swift
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

struct CardsListView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        
            // This turns the scroll bar off
            ScrollView(showsIndicators: false) {
                
            VStack {
                // This places ten shapes in a scrollable VStack
                ForEach(0..<10) { _ in
                    CardThumbnail()
                        .onTapGesture {
                          isPresented = true
                        }

                }
            }
        }
            .fullScreenCover(isPresented: $isPresented) {
              SingleCardView()
            }
    }
}

#Preview {
    CardsListView()
}

