/*

 EventList.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/stateobject

 https://developer.apple.com/documentation/SwiftUI/State

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 Created on 10/11/2023 with Swift 5.9, Xcode 15.0

 Constructs the primary UI for the app, the event list, using a List view

*/

import SwiftUI

struct EventList: View {

    @EnvironmentObject var eventData: EventData
    @State private var isAddingNewEvent = false
    @State private var newEvent = Event()

    var body: some View {

        List {
            ForEach(Period.allCases) { period in
                if !eventData.sortedEvents(period: period).isEmpty {
                    Section(content: {

                        ForEach(eventData.sortedEvents(period: period)) { $event in

                            NavigationLink {

                                EventEditor(event: $event)

                            } label: {

                                EventRow(event: event)
                            }
                            .swipeActions {

                                Button(role: .destructive) {
                                    eventData.delete(event)

                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                }
            }
        }
        .navigationTitle("Date Planner")
        .toolbar {
            ToolbarItem {
                Button {
                    newEvent = Event()
                    isAddingNewEvent = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewEvent) {

            NavigationView {

                EventEditor(event: $newEvent, isNew: true)

            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {

        NavigationView {

            EventList().environmentObject(EventData())
            
        }
    }
}
