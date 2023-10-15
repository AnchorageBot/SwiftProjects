/*

 SFSymbolStyling.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/viewmodifier

 Created on 10/14/2023 with Swift 5.9, Xcode 15.0

 A modifier that you apply to a view or another view modifier, producing a different version of the original value

*/

import SwiftUI

struct SFSymbolStyling: ViewModifier {

    func body(content: Content) -> some View {

        content
            .imageScale(.large)
            .symbolRenderingMode(.monochrome)
    }
}

extension View {

    func sfSymbolStyling() -> some View {
        modifier(SFSymbolStyling())
    }
}
