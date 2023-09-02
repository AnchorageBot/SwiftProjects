/*
 
 iOS_Scenes.swift
 LearnSwiftUI

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI


// iOS_Scenes is a structure conforms to the Scene protocol and is used for iOS devices
struct iOS_Scenes: Scene {

    var body: some Scene {

            WindowGroup {

                TabView {

                    JournalView()
                        .tabItem {
                            Label("Journal", systemImage: "book")
                        }

                    AppSettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
            }
    }
}
