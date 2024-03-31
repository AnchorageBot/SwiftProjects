//
//  VOS_SnowV2App.swift
//  VOS_SnowV2
//
//  Created by ATS on 3/31/24
//  Made with Xcode 15.3
//  Commented by Claude on 3/31/24
//

//  Abstract:
//  This file contains the main entry point of the VOS_SnowV2 app.
//  It defines the app's scenes, including the main window group and an immersive space.
//
//  References:
//  - SwiftUI: https://developer.apple.com/documentation/swiftui
//  - App Protocol: https://developer.apple.com/documentation/swiftui/app
//  - Scene: https://developer.apple.com/documentation/swiftui/scene
//  - WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
//  - ImmersiveSpace: https://developer.apple.com/documentation/swiftui/immersivespace
//

import SwiftUI

@main
struct VOS_SnowV2App: App {
    var body: some Scene {
        // The main window group that contains the ContentView
        WindowGroup {
            ContentView()
        }
        
        // An immersive space with the identifier "ImmersiveSpace"
        // It contains the ImmersiveView
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
