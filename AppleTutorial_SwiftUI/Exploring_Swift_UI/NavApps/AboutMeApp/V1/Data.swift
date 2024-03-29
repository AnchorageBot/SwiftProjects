/*

 Data.swift
 Explore_SwiftUI_V1

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0
 Updated on 9/28/2023

*/


import Foundation
import SwiftUI

struct Info {
    let image: String
    let name: String
    let story: String
    let hobbies: [String]
    let foods: [String]
    let colors: [Color]
    let funFacts: [String]
}

let information = Info(
    image: "icybay",
    name: "Me",
    story: "It has the best words",
    hobbies: ["🏄‍♀️", "🎧", "📚"],
    foods: ["🥐", "🌮", "🍣"],
    colors: [Color.red, Color.green, Color.blue],
    funFacts: ["Einstein is often right",
              "Antimatter is subject to gravity",
              "The photoelectric effect is monetizable",
              "The normal distribution exists for a reason",
              "60% of the time it works every time",
              "Brian Fantana is a tremendous anchorman",
              "The truth is out there",
    ]
)
