/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view modifier for a flip visual effect.
*/

import SwiftUI

struct HorizontalFlip: ViewModifier {
    var angle: Angle
    var visible: Bool
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(angle, axis: (x: 0.0, y: 1.0, z: 0.0))
            .opacity(visible ? 1.0 : 0.0)
    }
}

extension View {
    func horizontalFlip(_ angle: Angle, visible: Bool) -> some View {
        modifier(HorizontalFlip(angle: angle, visible: visible))
    }
}
