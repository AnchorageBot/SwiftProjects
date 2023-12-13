/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A model that represents a card.
*/

import Foundation

final class Card: ObservableObject {
    @Published var front: String
    @Published var back: String
    var creationDate: Date

    init(front: String, back: String, creationDate: Date = .now) {
        self.front = front
        self.back = back
        self.creationDate = creationDate
    }
}

extension Card: Identifiable { }

extension Card: Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.front == rhs.front &&
        lhs.back == rhs.back &&
        lhs.creationDate == rhs.creationDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(front)
        hasher.combine(back)
        hasher.combine(creationDate)
    }
}
