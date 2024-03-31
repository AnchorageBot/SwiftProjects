//
//  ImmersiveView.swift
//  VOS_SnowV2
//
//  Created by ATS on 3/31/24
//  Mode with Xcode 15.3
//  Commented by Claude on 3/31/24
//

//  Abstract:
//  This file contains the immersive view of the VOS_SnowV2 app.
//  It displays RealityKit content, including an entity named "Immersive" loaded from a bundle.
//
//  References:
//  - SwiftUI: https://developer.apple.com/documentation/swiftui
//  - RealityKit: https://developer.apple.com/documentation/realitykit
//  - RealityKitContent: https://developer.apple.com/documentation/realitykit/realitykitcontent
//  - RealityView: https://developer.apple.com/documentation/realitykit/realityview
//  - Entity: https://developer.apple.com/documentation/realitykit/entity
//  - #Preview: https://developer.apple.com/documentation/swiftui/view/preview(immersionstyle:)
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
