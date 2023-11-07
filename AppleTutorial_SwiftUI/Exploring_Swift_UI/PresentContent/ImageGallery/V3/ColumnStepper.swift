/*

 ColumnStepper.swift
 Explore_SwiftUI_V7

 How to create this file with Xcode commands:

   * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/binding

 https://developer.apple.com/documentation/swiftui/state

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/

 https://developer.apple.com/documentation/swiftui/stepper

 Created on 11/5/2023 and updated on 11/6/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct ColumnStepper: View {

    let title: String
    let range: ClosedRange<Int>

    // A property wrapper type that can read and write a value owned by a source of truth
    @Binding var columns: [GridItem]
    // A property wrapper type that can read and write a value managed by SwiftUI
    // Use state as the single source of truth for a given value type that you store in a view hierarchy
    @State private var numColumns: Int

    // Initializers are called to create a new instance of a particular type
    init(title: String, range: ClosedRange<Int>, columns: Binding<[GridItem]>) {
        self.title = title
        self.range = range
        self._columns = columns
        self.numColumns = columns.count
    }

    var body: some View {

        // A control that performs increment and decrement actions
        Stepper(title, value: $numColumns, in: range, step: 1) { _ in
            withAnimation { columns = Array(repeating: GridItem(.flexible()), count: numColumns) }
        }
    }
}

struct ColumnStepper_Previews: PreviewProvider {
    static var previews: some View {
        ColumnStepper(title: "ColumnStepper", range: 1...8, columns: .constant(Array(repeating: GridItem(.flexible()), count: 5)))
    }
}

/*
#Preview {
    ColumnStepper()
}
*/
