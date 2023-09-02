/*

  LearnSwiftUIApp.swift
  LearnSwiftUI

  How to create this file with Xcode commands:
  Xcode->File->New Project -> iOS - App

  Created on 8/31/23, updated on 9/2/2023
  Made with Swift 5.8, Xcode 14.3.1

  References:
  https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 An app structure describes the content and behavior of your app, and each SwiftUI
 app has one and only one main app structure. 

*/

import SwiftUI


@main

struct LearnSwiftUIApp: App {

    var body: some Scene {

        // compiler control statement
        #if os(iOS)
        WindowGroup {

            // Root node of the view hierarchy
            TabView {

                // custom view that creates a view hierarchy that displays journal entries
                JournalView()


                    .tabItem {
                        Label("Journal", systemImage: "book")
                    }

                // custom view that displays views app settings that the user can edit
                AppSettingsView()


                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }

        // view hierarchy that takes advantage of features specific to the Mac
        #elseif os(macOS)
        WindowGroup {

            // custom view and root node of the view hierarchy
            macOSView()
        }

        // Provides a settings menu that is only available in macOS
        Setting {
            AppSettingsView()
        }

        #endif
    }
}
