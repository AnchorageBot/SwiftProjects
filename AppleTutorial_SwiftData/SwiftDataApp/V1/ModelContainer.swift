/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view modifier for showing sample data in previews.
*/

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Card.self, ModelConfiguration(inMemory: true)
        )
        for card in SampleDeck.contents {
            container.mainContext.insert(object: card)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
