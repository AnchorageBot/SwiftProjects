/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that represent a card shown in the card gallery.
*/

import SwiftUI

struct CardGalleryItem<Content: View, S: ShapeStyle>: View {
    let backgroundStyle: S
    let action: () -> Void
    @ViewBuilder var label: Content

    var body: some View {
        Button(action: action) {
            CardContainerView {
                label
                    .font(Design.cardViewingFont)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                    .padding()
            }
        }
        .backgroundStyle(backgroundStyle)
        .buttonStyle(Design.galleryButtonStyle)
        .padding(Design.galleryItemPadding)
    }
}
