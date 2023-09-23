/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct StarRating: View {

    @Binding var rating: Int

    private let maxRating = 5

    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { value in
                Image(systemName: "star")
                    .symbolVariant(value <= rating ? .fill : .none)
                    .foregroundColor(.accentColor)
                    .onTapGesture {

                        if value != rating {
                            rating = value

                        } else {
                            rating = 0
                            
                        }
                    }
            }
        }
    }
}
