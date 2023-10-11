/*

 EventData.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/combine/published

 https://developer.apple.com/documentation/combine/observableobject

 https://developer.apple.com/documentation/foundation/date

 https://developer.apple.com/documentation/swift/using-imported-c-functions-in-swift

 https://developer.apple.com/documentation/swiftui/binding

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Switch

 Created on 10/9/2023 and updated on 10/11/2023 with Swift 5.9, Xcode 15.0

 The EventData observable object populates the data in your event list

*/

import SwiftUI

class EventData: ObservableObject {

    @Published var events: [Event] = [

        Event(symbol: "gift.fill",
              color: .red,
              title: "Maya's Birthday",
              tasks: [EventTask(text: "Guava kombucha"),
                      EventTask(text: "Paper cups and plates"),
                      EventTask(text: "Cheese plate"),
                      EventTask(text: "Party poppers"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)),

        Event(symbol: "theatermasks.fill",
              color: .yellow,
              title: "Pagliacci",
              tasks: [EventTask(text: "Buy new tux"),
                      EventTask(text: "Get tickets"),
                      EventTask(text: "Pick up Carmen at the airport and bring her to the show"),
                      ],
              date: Date.roundedHoursFromNow( 60 * 60 * 22)),

        Event(symbol: "facemask.fill",
              color: .indigo,
              title: "Doctor's, Appointment",
              tasks: [EventTask(text: "Bring medical ID"),
                      EventTask(text: "Record heart rate data"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)),

        Event(symbol: "leaf.fill",
              color: .green,
              title: "Camping Trip",
              tasks: [EventTask(text: "Find a sleeping bag"),
                      EventTask(text: "Bug spray"),
                      EventTask(text: "Paper towels"),
                      EventTask(text: "Food for 4 meals"),
                      EventTask(text: "Straw hat"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 36)),

        Event(symbol: "gamecontroller.fill",
              color: .cyan,
              title: "Game Night",
              tasks: [EventTask(text: "Find a board game to bring"),
                      EventTask(text: "Bring a desert to share"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 2)),

        Event(symbol: "graduationcap.fill",
              color: .primary,
              title: "First Day of School",
              tasks: [
                EventTask(text: "Notebooks"),
                EventTask(text: "Pencils"),
                EventTask(text: "Binder"),
                EventTask(text: "First day of school outfit"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)),

        Event(symbol: "graduationcap.fill",
              color: .primary,
              title: "First Day of School",
              tasks: [
                EventTask(text: "Notebooks"),
                EventTask(text: "Pencils"),
                EventTask(text: "Binder"),
                EventTask(text: "First day of school outfit"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365)),

        Event(symbol: "book.fill",
              color: .purple,
              title: "Book Launch",
              tasks: [
                EventTask(text: "Finish first draft"),
                EventTask(text: "Send draft to editor"),
                EventTask(text: "Final read-through"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)),

        Event(symbol: "case.fill",
              color: .orange,
              title: "Sayulita Trip",
              tasks: [
                EventTask(text: "Buy plane tickets"),
                EventTask(text: "Get a new bathing suit"),
                EventTask(text: "Find a hotel room"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 19)),
    ]

    func delete(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }

    func add(_ event: Event) {
        events.append(event)
    }

    func exists(_ event: Event) -> Bool {
        events.contains(event)
    }

    func sortedEvents(period: Period) -> Binding<[Event]> {
        Binding<[Event]>(
            get: {
                self.events
                    .filter {
                        switch period {

                        case .nextSevenDays:
                            return $0.isWithinSevenDays

                        case .nextThirtyDays:
                            return $0.isWithinSevenToThirtyDays

                        case .future:
                            return $0.isDistant

                        case .past:
                            return $0.isPast
                        }
                    }
                    .sorted { $0.date < $1.date }
            },
            set: { events in
                for event in events {
                    if let index = self.events.firstIndex(where: { $0.id == event.id }) {
                        self.events[index] = event
                    }
                }
            }
        )
    }

}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future"
    case past = "Past"

    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension Date {

    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date()
        }
    }

    static func roundedHoursFromNow(_ hours: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hours)
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
