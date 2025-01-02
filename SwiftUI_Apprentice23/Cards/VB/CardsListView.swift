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
    
    var body: some View {
        
            //A ScrollView can be vertical or horizontal. The default, which you use here, is vertical,
            //ScrollView {
        
            // This turns the scroll bar off
            ScrollView(showsIndicators: false) {
            VStack {
                // This places ten shapes in a scrollable VStack
                ForEach(0..<10) { _ in
                    CardThumbnail()
                }
            }
        }
    }
}

#Preview {
    CardsListView()
}


