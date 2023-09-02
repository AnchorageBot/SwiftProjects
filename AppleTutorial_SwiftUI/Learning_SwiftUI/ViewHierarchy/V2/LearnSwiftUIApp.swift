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
 app has one and only one main app structure

 This one uses scenes to make it easier to maintain

*/

import SwiftUI


@main

struct LearnSwiftUIApp: App {

    var body: some Scene {

        // compiler control statement
        // view hierarchy that takes advantage of features specific to iOS
        #if os(iOS)
        iOS_Scenes()

        // view hierarchy that takes advantage of features specific to the Mac
        #elseif os(macOS)
        macOS_Scenes()

        #endif
    }
}
