/*

 EventTile.swift
 LearnSwiftUI_V4

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/organizing-and-aligning-content-with-stacks

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/10/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

// Defines all the data associated with the event
struct Event {
    let title: String
    let date: Date
    let location: String
    let symbol: String
}

// Gets all the event data for a specific instance
struct EventTile: View {

    let event: Event
    let stripeHeight = 15.0

    var body: some View {

        HStack(alignment: .firstTextBaseline) {

            Image(systemName: event.symbol)
                .font(.title)

            VStack(alignment: .leading) {

                Text(event.title)
                    .font(.title)

                Text(
                    event.date,
                    format: Date.FormatStyle()
                        .day(.defaultDigits)
                        .month(.wide)
                )
            }
        }

        .padding()
        .padding(.top, stripeHeight)

        .background {
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: stripeHeight)
            }
            .foregroundColor(.teal)
        }
        .clipShape(RoundedRectangle(cornerRadius: stripeHeight, style: .continuous))
    }
}

    struct EventTile_Previews: PreviewProvider {

        static let event = Event(
            title: "Trip to Farmers Market",
            date: .now,
            location: "Farmers market",
            symbol: "bicycle")

        static var previews: some View {
            EventTile(event: event)
        }
    }
