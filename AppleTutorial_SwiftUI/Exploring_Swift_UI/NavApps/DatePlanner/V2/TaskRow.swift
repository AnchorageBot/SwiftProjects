/*

 TaskRow.swift
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

 https://developer.apple.com/documentation/swiftui/focusstate

 https://developer.apple.com/documentation/SwiftUI/View/onChange(of:perform:)

 https://developer.apple.com/documentation/swiftui/view/onchange(of:initial:_:)-8wgw9

 https://www.optimistic-closures.com/how-to-fix-onchange-of-perform-deprecated-in-ios-17-0-warnings/

 This script/view has issues that need to be resolved

 Created on 10/14/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct TaskRow: View {

    @Binding var task: EventTask

    var isEditing: Bool

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)

            if isEditing || task.isNew {

                TextField("Task description", text: $task.text)
                    .focused($isFocused)

                    /* 'onChange(of:perform:)' was deprecated in iOS 17.0: Use `onChange` with a two or zero parameter action closure instead.

                     .onChange(of: isFocused) { newValue in
                     if newValue == false {
                     task.isNew = false
                     }
                     */

                    /* First try at a fix
                     .onChange(of: isFocused) {
                     if isFocused == false {
                     task.isNew = false
                     }
                     */

                    // Second try at a fix
                    .onChange(of: isFocused) { isFocused, newValue in
                        //task.isNew(from: isFocused, to: newValue)
                        if newValue == false {
                            task.isNew = false
                        }
                    }

            } else {
                Text(task.text)
            }

            Spacer()
        }
        .padding(.vertical, 10)
        .task {
            if task.isNew {
                isFocused = true
            }
        }
    }

}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .constant(EventTask(text: "Do something!")), isEditing: false)
    }
}
