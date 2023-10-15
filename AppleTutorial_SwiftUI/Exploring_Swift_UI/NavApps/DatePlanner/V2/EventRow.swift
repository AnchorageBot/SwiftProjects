/*

 EventRow.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/binding

 https://developer.apple.com/documentation/swiftui/stateobject

 https://developer.apple.com/documentation/SwiftUI/State

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 Created on 10/14/2023 with Swift 5.9, Xcode 15.0

 Event rows view for the app

*/

import SwiftUI

struct EventRow: View {

    let event: Event

    var body: some View {

        HStack {

            Image(systemName: event.symbol)
                .sfSymbolStyling()
                .foregroundStyle(event.color)

            VStack(alignment: .leading, spacing: 5) {

                Text(event.title)
                    .fontWeight(.bold)

                Text(event.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            if event.isComplete {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundStyle(.secondary)
            }

        }
        .badge(event.remainingTaskCount)
    }
}

struct EventRow_Previews: PreviewProvider {

    static var previews: some View {
        
        EventRow(event: Event.example)
    }
}
