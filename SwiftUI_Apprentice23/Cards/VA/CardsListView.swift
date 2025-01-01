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
        ScrollView {
            VStack {
                ForEach(0..<10) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.gray)
                        .frame(width: 150, height: 250)
                }
            }
        }
    }
}

