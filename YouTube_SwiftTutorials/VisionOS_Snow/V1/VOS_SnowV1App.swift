//
//  VOS_SnowV1App.swift
//  VOS_SnowV1
//
//  Created by ATS on 3/31/24
//  Made with Xcode 15.3
//

import SwiftUI

@main
struct VOS_SnowV1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
