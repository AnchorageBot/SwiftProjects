/*

 ColorOption.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swift/array/randomelement()

 Created on 10/14/2023 with Swift 5.9, Xcode 15.0

 Color palette for the app

*/

import SwiftUI

struct ColorOptions {

    static var all: [Color] = [
        .primary,
        .gray,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .cyan,
        .indigo,
        .purple,
    ]

    static var `default` : Color =
        Color.primary

    static func random() -> Color {
        if let element =
            ColorOptions.all.randomElement() {
            return element

        } else {
            return.primary
        }

    }
}

