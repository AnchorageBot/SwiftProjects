//
// Cards
// ContentView.swift
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

/// Main view of the application
/// Provides the primary user interface for the Cards app
struct ContentView: View {
    
    /// The main view body
    /// Organizes content into collapsible sections with iOS native styling
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
