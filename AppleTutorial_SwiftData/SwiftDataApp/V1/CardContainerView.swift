/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A reusable view for content presented as a card visually.
*/

import SwiftUI

/// A container for card content
struct CardContainerView<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
            content
                .foregroundStyle(Color.cardText)
        }
        .aspectRatio(2, contentMode: .fit)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
