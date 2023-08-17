/
//  LandmarksApp.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/2/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->Project
//  Template->iOS->App
//  Product Name->Landmarks
//  Interface->SwiftUI
//  Language->Swift

import SwiftUI

// The @main attribute identifies the app’s entry point.
@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
