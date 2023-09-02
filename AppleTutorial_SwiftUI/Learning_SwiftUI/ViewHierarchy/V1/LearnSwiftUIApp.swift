/*

  LearnSwiftUIApp.swift
  LearnSwiftUI

  Created on 8/31/23, updated on 9/2/2023
  Made with Swift 5.8, Xcode 14.3.1

  Reference:
  https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

  How to create this file:
  Xcode->File->New Project -> iOS - App

  An app structure describes the content and behavior of your app, and each SwiftUI
  app has one and only one main app structure. 

*/

import SwiftUI

// entry point responsible for the start-up of the app and there can only be one
@main

// The structure implements the computed property body
struct LearnSwiftUIApp: App {

    // returns the contents of your app described as a Scene
    var body: some Scene {

        // WindowGroup scene to represent the main window that the app displays
        WindowGroup {

            // Root node of the view hierarchy
            TabView {

                // custom view that creates a view hierarchy that displays journal entries
                JournalView()

                // tells the TabView the image and text to display in each tab
                    .tabItem {
                        Label("Journal", systemImage: "book")
                    }

                // custom view that displays views app settings that the user can edit
                AppSettingsView()

                // tells the TabView the image and text to display in each tab
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
