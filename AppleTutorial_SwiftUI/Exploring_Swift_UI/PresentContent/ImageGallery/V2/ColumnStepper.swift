/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ColumnStepper: View {
    let title: String
    let range: ClosedRange<Int>
    @Binding var columns: [GridItem]
    @State private var numColumns: Int

    init(title: String, range: ClosedRange<Int>, columns: Binding<[GridItem]>) {
        self.title = title
        self.range = range
        self._columns = columns
        self.numColumns = columns.count
    }

    var body: some View {
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
