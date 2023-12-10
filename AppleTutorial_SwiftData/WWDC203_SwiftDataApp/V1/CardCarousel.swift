/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The container view for horizontal scrolling through the cards one by
        one.
*/

import SwiftUI

struct CardCarousel: View {
    @State private var selectedCardID: Card.ID?
    @FocusState private var focusCardID: Card.ID?
    private let initialCardID: Card.ID

    let editing: Bool
    var cards: [Card]

    init(editing: Bool, cards: [Card], selectedCard: Card) {
        self.editing = editing
        self.cards = cards
        initialCardID = selectedCard.id
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(cards) { card in
                        Group {
                            if editing {
                                CardEditorView(card: card)
                            } else {
                                FlashCardView(card: card)
                                    .id(card.id)
                            }
                        }
                        .containerRelativeFrame(.horizontal) { width, _ in
                            min(width, Design.carouselCardMaxWidth)
                        }
                        .containerRelativeFrame(.horizontal)
                        .focused($focusCardID, equals: card.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $selectedCardID)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            Text("Swipe left/right to review other cards")
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .background()
        .onAppear { selectedCardID = initialCardID }
        .onChange(of: selectedCardID) { focusCardID = $1 }
    }
}

