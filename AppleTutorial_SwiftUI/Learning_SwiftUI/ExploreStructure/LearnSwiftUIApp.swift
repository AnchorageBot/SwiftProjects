/*

  LearnSwiftUIApp.swift
  LearnSwiftUI

  Created on 8/31/23
  Made with Swift 5.8, Xcode 14.3.1

  https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

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

            // custom view that creates a view hierarchy that consists of an image and text
            ContentView()

        }
    }
}
