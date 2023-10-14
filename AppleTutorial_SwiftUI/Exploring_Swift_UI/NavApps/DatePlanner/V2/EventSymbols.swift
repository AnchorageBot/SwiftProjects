/*

 EventSymbols.swift
 Explore_SwiftUI_V4

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift File

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/foundation

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swift/array/randomelement()

 https://developer.apple.com/sf-symbols/

 Created on 10/14/2023 with Swift 5.9, Xcode 15.0

 Digital symbol board/swatch board for the app

*/

import Foundation

struct EventSymbols {

    static func randomName() -> String {

        if let random = symbolNames.randomElement() {
            return random

        } else {
            return ""
        }
    }

    static func randomNames(_ number: Int) -> [String] {

            var names: [String] = []

            for _ in 0..<number {
                names.append(randomName())
            }
        
            return names
        }

    static var symbolNames: [String] = [
            "house.fill",
            "ticket.fill",
            "gamecontroller.fill",
            "theatermasks.fill",
            "ladybug.fill",
            "books.vertical.fill",
            "moon.zzz.fill",
            "umbrella.fill",
            "paintbrush.pointed.fill",
            "leaf.fill",
            "globe.americas.fill",
            "clock.fill",
            "building.2.fill",
            "gift.fill",
            "graduationcap.fill",
            "heart.rectangle.fill",
            "phone.bubble.left.fill",
            "cloud.rain.fill",
            "building.columns.fill",
            "mic.circle.fill",
            "comb.fill",
            "person.3.fill",
            "bell.fill",
            "hammer.fill",
            "star.fill",
            "crown.fill",
            "briefcase.fill",
            "speaker.wave.3.fill",
            "tshirt.fill",
            "tag.fill",
            "airplane",
            "pawprint.fill",
            "case.fill",
            "creditcard.fill",
            "infinity.circle.fill",
            "dice.fill",
            "heart.fill",
            "camera.fill",
            "bicycle",
            "radio.fill",
            "car.fill",
            "flag.fill",
            "map.fill",
            "figure.wave",
            "mappin.and.ellipse",
            "facemask.fill",
            "eyeglasses",
            "tram.fill",
        ]
    }
