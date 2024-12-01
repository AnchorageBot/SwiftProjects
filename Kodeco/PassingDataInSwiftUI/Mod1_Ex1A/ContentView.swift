//
// PDSUI_ModuleOne_Ex1
// ContentView.swift
//
// Created on 11/30/24
// Swift Version 6.0
//
// ATS Project - Assisted by Claude
// Kodeco Tutorial
// Understanding Data Flow in SwiftUI
// Module 1 - Exercise 1

/*
 Abstract:
 This file demonstrates basic data flow in SwiftUI by implementing a simple view
 that displays a person's information. It showcases how to pass and display data
 using SwiftUI's declarative syntax and struct-based data models.
 */

import SwiftUI

/// A data model representing a person with basic information
struct Person {
    /// The person's full name
    let name: String
    /// The person's age in years
    let age: Int
}

/// The main content view that displays a person's information
struct ContentView: View {
    /// The person whose information will be displayed
    let person: Person
    
    /// The view's body that defines its content and layout
    var body: some View {
        // VStack arranges the text views vertically
        VStack {
            // Display the person's name using string interpolation
            Text("Name: \(person.name)")
            // Display the person's age using string interpolation
            Text("Age: \(person.age)")
        }
    }
}

/// Preview provider for viewing the content in Xcode's canvas
#Preview {
    // Initialize the view with sample preview data
    ContentView(person: Person(name: "Preview Person", age: 25))
}
