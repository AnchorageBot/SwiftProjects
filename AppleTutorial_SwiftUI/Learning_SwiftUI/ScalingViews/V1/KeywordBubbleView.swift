/*

 KeywordBubbleView.swift
 LearnSwiftUI

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct KeywordBubbleView: View {
    let keyword: String
    let symbol: String
    var body: some View {

        // Label is a built-in view that arranges the text and the symbol, the main content of this view
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(.purple.opacity(0.75), in: Capsule())
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
