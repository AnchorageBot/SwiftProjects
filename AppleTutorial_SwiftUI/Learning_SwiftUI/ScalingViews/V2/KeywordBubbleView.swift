/*

 KeywordBubbleView.swift
 LearnSwiftUI

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/design/human-interface-guidelines/sf-symbols

 Created on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1


 With the ScaledMetric variable padding, all the Dynamic Type variants now have padding between the leaf symbol and the edge of the Capsule shape in the background.

*/

import SwiftUI

struct KeywordBubbleView: View {
    let keyword: String
    let symbol: String

    // additional topics to read: property wrapper, binding, ScaledMetric
    @ScaledMetric(relativeTo: .title) var paddingWidth = 14.5

    var body: some View {

        // Label is a built-in view that arranges the text and the symbol, the main content of this view
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding(paddingWidth)
            .background {
                Capsule()
                    .fill(.purple.opacity(0.75))
            }
    }
}

struct KeywordBubbleView_Previews: PreviewProvider {
    static let keywords = ["chives", "fern-leaf lavendar"]
    static var previews: some View {
        VStack {
            ForEach(keywords, id: \.self) { word in
                KeywordBubbleView(keyword: word, symbol: "leaf")
            }
        }
    }
}
