/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct Event: Identifiable, Hashable {
    var id = UUID()
    var symbol: String = EventSymbols.randomName()
    var color: Color = ColorOptions.random()
    var title = ""
    var tasks = [EventTask(text: "")]
    var date = Date()

    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    
    var isPast: Bool {
        date < Date.now
    }
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
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
            EventTask(text: "Buy plane tickets"),
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5))
}

// Convenience methods for dates.
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
