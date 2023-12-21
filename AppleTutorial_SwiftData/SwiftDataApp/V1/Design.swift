/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Variables that affect the design of the app.
*/

import SwiftUI

enum Design {
    static var galleryGridSize: GridItem.Size {
        #if os(tvOS)
        .adaptive(minimum: 400)
        #else
        .adaptive(minimum: 200)
        #endif
    }

    static var galleryGridSpacing: Double {
        #if os(tvOS)
        50
        #else
        10
        #endif
    }

    static var galleryItemPadding: Double {
        #if os(tvOS)
        25
        #elseif os(macOS)
        8
        #else
        0
        #endif
    }

    static var galleryButtonStyle: some PrimitiveButtonStyle {
        #if os(tvOS)
        .card
        #else
        .plain
        #endif
    }

    static var editFeatureEnabled: Bool {
        #if os(iOS) || os(macOS)
        true
        #else
        false
        #endif
    }

    static var carouselCardButtonStyle: some PrimitiveButtonStyle {
        #if os(tvOS)
        .card
        #else
        .plain
        #endif
    }

    static var carouselCardHorizontalPadding: Double {
        #if os(tvOS)
        50
        #else
        8
        #endif
    }

    static var carouselCardMaxWidth: Double {
        #if os(macOS) || os(iOS)
        800
        #else
        .infinity
        #endif
    }

    static var cardCornerRadius: Double {
        8
    }

    static var cardViewingFont: Font {
        #if os(watchOS)
        .body
        #else
        .largeTitle
        #endif
    }

}

extension Color {
    static let cardFront = Color("Card Front")
    static let cardBack = Color("Card Back")
    static let cardText = Color("Card Text")
}
