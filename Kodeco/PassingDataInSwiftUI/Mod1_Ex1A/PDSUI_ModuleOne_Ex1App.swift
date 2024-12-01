//
// PDSUI_ModuleOne_Ex1
// PDSUI_ModuleOne_Ex1App.swift
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
 This file serves as the application entry point and configures the main app
 structure. It demonstrates how to set up the app's primary view and initialize
 it with data, showcasing SwiftUI's app lifecycle management.
 */

import SwiftUI

/// The main app structure that serves as the application's entry point
@main
struct MyApp: App {
    /// Defines the content and structure of the app's user interface
    var body: some Scene {
        // WindowGroup is the primary container for the app's content
        WindowGroup {
            // Initialize the main content view with default data
            ContentView(person: Person(name: "Alice", age: 30))
        }
    }
}
