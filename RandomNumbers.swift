// This script will generate (pseudo?)random numbers

/* Made with:

iPad
Swift Playgrounds 4.1
Swift 5.7

*/

/* References

Random Numbers via Stackoverflow
https://stackoverflow.com/questions/24007129/how-does-one-generate-a-random-number-in-swift
 
Swift Reference Book
https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html

Swift Playgrounds Release Notes
https://developer.apple.com/swift-playgrounds/release-notes/
 
 */

// 1  
// You use random(in:) to generate random digits from ranges
let digit = Int.random(in: 0..<10)

// 2
// randomElement() returns nil if the range is empty, so you unwrap the returned Int? with if let
if let anotherDigit = (0..<10).randomElement() {
    print(anotherDigit)
} else {
    print("Empty range.")
}

// 3
// You use random(in:) to generate a random Double, Float or CGFloat and random() to return a random Bool
let double = Double.random(in: 0..<1)
let float = Float.random(in: 0..<1)
//let cgFloat = CGFloat.random(in: 0..<1)
let bool = Bool.random()
