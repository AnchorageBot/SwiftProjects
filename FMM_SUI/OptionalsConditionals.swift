// OptionalsConditionals.swift
//
// Made with Swift Playgrounds, Swift 5.8
// 
// 8/9/2023
//
// Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
//
/* Optionals must be first compared against the nil keyword and then unwrapped 
before working with their values */


// Check whether an optional contains a value or not


// optional contains a value
var count = 1
var aOptional: Int? = 5 
if aOptional != nil { 
    let xValue = aOptional! 
        count = count + xValue
}
print(count) // 6


// optional does not contain a value
var newCount = 1
var otherOptional: Int? = nil
if otherOptional != nil { 
    let yValue = otherOptional! 
        newCount = newCount + yValue
}
print(newCount) // 1
