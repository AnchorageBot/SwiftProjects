/*

 macOS_Scenes.swift
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


struct macOS_Scene: Scene {

    var body: some Scene {

        WindowGroup {
            
            macOSView()
        }

        #if os(macOS)
        Settings {
            AppSettingsView()
        }
        #endif
    }
}
