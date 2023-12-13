/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view for a card under review by the user.
*/

import SwiftUI

struct CardReaderView: View {
    let color: Color
    let text: String
    var body: some View {
        CardContainerView {
            Text(text)
                .font(Design.cardViewingFont)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.33)
                .padding()
        }
        .backgroundStyle(color)
    }
}
