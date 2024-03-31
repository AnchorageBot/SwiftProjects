//
//  ContentView.swift
//  VOS_SnowV2
//
//  Created by ATS on 3/31/24
//  Made with Xcode 15.3
//  Commented by Claude on 3/31/24
//

//  Abstract:
//  This file contains the main content view of the VOS_SnowV2 app.
//  It displays a 3D model, a text message, and a toggle to control the visibility of an immersive space.
//
//  References:
//  - SwiftUI: https://developer.apple.com/documentation/swiftui
//  - RealityKit: https://developer.apple.com/documentation/realitykit
//  - RealityKitContent: https://developer.apple.com/documentation/realitykit/realitykitcontent
//  - Model3D: https://developer.apple.com/documentation/realitykit/model3d
//  - Toggle: https://developer.apple.com/documentation/swiftui/toggle
//  - Task: https://developer.apple.com/documentation/swift/task
//  - #Preview: https://developer.apple.com/documentation/swiftui/view/preview(windowstyle:)
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            // Display a 3D model named "Scene" from the RealityKitContent bundle
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            
            Text("Hello, world!")
            
            // A toggle to control the visibility of the ImmersiveSpace
            Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                .font(.title)
                .frame(width: 360)
                .padding(24)
                .glassBackgroundEffect()
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    // Open the ImmersiveSpace when the toggle is turned on
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    // Dismiss the ImmersiveSpace when the toggle is turned off
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
