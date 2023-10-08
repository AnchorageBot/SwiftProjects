/*

 Event.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swift/identifiable

 https://developer.apple.com/documentation/swift/hashable

 https://developer.apple.com/documentation/cryptokit/hashfunction

 https://developer.apple.com/documentation/swiftui/binding

 https://developer.apple.com/documentation/swift/__(_:_:)-8buau

 Created on 10/8/2023 with Swift 5.9, Xcode 15.0

 The event model holds all of the data needed to visualize and organize events
 in your list

*/

import SwiftUI

/* 
 Event contains all of the information needed to populate an event

 Information = items and computed properties = var 

 Use the Identifiable protocol to provide a stable notion of identity to a class or value type
*/

struct Event: Identifiable, Hashable {

    var id = UUID()
    var symbol: String = EventSymbols.randomName()
    var color: Color = ColorOptions.random()
    var title = " "
    var tasks = [EventTask(text: " ")]
    var date = Date()

    var remainingTaskCount: Int {

        /*  
            $ = binding
            binding = A property wrapper type that can read and write a value
                owned by a source of truth 
        */
        tasks.filter { !$0.isCompleted }.count
    }

    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }

    var isPast: Bool {
        date < Date.now
    }

    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysout
    }

    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }

    var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }

    static var example = Event(
        symbol: "case.fill",
        title: "Sayulita Trip",
        tasks: [
            EventTask(text: "Buy plane tickets")
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5))
}

// Convience methods for dates
extension Date {

    /* 
     ?? = nil-coalescing operation

     returning the wrapped value of an Optional instance or a default value

     A nil-coalescing operation unwraps the left-hand side if it has a value,
        or it returns the right-hand side as a default
    */
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }

    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day,  value: 30, to: self) ?? self
    }
}
