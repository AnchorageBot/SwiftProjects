/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view for editing the content of a card.
*/

import SwiftUI

struct CardEditorView: View {
    @Bindable var card: Card
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        CardContainerView {
            VStack(spacing: 0) {
                LabeledContent("Front") {
                    TextField("Front Text", text: $card.front)
                        .focused($focusedField, equals: .front)
                }
                .padding()

                Divider()

                LabeledContent("Back") {
                    TextField("Back Text", text: $card.back)
                        .focused($focusedField, equals: .back)
                }
                .padding()
                .background(Color.cardBack, in: .rect(
                    bottomLeadingRadius: Design.cardCornerRadius,
                    bottomTrailingRadius: Design.cardCornerRadius))

            }
            .labeledContentStyle(CardFieldLabeledContentStyle())
            .textFieldStyle(.plain)
            .overlay(alignment: .topTrailing) {
                Text("Created at \(card.creationDate, format: .dateTime)")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .padding()
            }
        }
        .backgroundStyle(Color.cardFront)
        .defaultFocus($focusedField, .front)
        .padding(.horizontal, Design.carouselCardHorizontalPadding)
    }
}

/// An enum describing the fields that can be focused in the editor view
private enum FocusedField {
    case front
    case back
}

/// The standard layout for the fields in the editor view.
private struct CardFieldLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .textCase(.uppercase)
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
            Spacer()
            configuration.content
                .font(Design.cardViewingFont)
                .multilineTextAlignment(.center)
                .padding(2)
                .background(.fill.quaternary, in: .rect(cornerRadius: 4))
            Spacer()
        }
    }
}
