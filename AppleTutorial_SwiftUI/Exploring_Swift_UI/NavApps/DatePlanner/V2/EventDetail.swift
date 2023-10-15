/*

 EventDetail.swift
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

 Event detail view for the app

*/

import SwiftUI

struct EventDetail: View {

    @Binding var event: Event

    let isEditing: Bool

    @State private var isPickingSymbol = false

    var body: some View {

            List {

                HStack {

                    Button {
                        isPickingSymbol.toggle()

                    } label: {
                        Image(systemName: event.symbol)
                            .sfSymbolStyling()
                            .foregroundColor(event.color)
                            .opacity(isEditing ? 0.3 : 1)
                    }

                    .buttonStyle(.plain)
                    .padding(.horizontal, 5)

                    if isEditing {
                        TextField("New Event", text: $event.title)
                            .font(.title2)

                    } else {
                        Text(event.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                }

                if isEditing {
                    DatePicker("Date", selection: $event.date)
                        .labelsHidden()
                        .listRowSeparator(.hidden)

                } else {
                    HStack {
                        Text(event.date, style: .date)
                        Text(event.date, style: .time)
                    }
                    .listRowSeparator(.hidden)

                }

                Text("Tasks")
                    .fontWeight(.bold)

                ForEach($event.tasks) { $item in
                    TaskRow(task: $item, isEditing: isEditing)
                }

                .onDelete(perform: { indexSet in
                    event.tasks.remove(atOffsets: indexSet)
                })

                Button {
                    event.tasks.append(EventTask(text: "", isNew: true))

                } label: {
                    HStack {

                        Image(systemName: "plus")

                        Text("Add Task")

                    }
                }
                .buttonStyle(.borderless)
            }

            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)

            #endif
            .sheet(isPresented: $isPickingSymbol) {
                SymbolPicker(event: $event)
            }

        }
    }

struct EventDetail_Previews: PreviewProvider {

    static var previews: some View {

        EventDetail(event: .constant(Event.example), isEditing: true)
    }
}
