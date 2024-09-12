//
// GroceryListV2
// GroceryListAppV2.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Afraz Siddiqui - iOS Academy YouTube
//


import SwiftUI
import SwiftData

@main

struct GroceryListAppV2: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        /// inject a container to hold things
        .modelContainer(for: GroceryListItem.self)
    }
}
