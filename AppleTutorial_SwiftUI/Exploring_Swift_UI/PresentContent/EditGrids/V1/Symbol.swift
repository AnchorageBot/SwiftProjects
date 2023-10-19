/*

 Symbol.swift
 Explore_SwiftUI_V5

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 Created on 10/18/2023 with Swift 5.9, Xcode 15.0

 The symbol struct helps to organize the symbols used in your app

*/

import SwiftUI

struct Symbol : Identifiable, Equatable {
    var id = UUID()
    var name : String
}
