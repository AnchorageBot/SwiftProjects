// OptionalsConditionals.swift
//
// Made with Swift Playgrounds, Swift 5.8
// 
// 8/9/2023
//
// Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
//

// Check whether an optional contains a value or not


// contains a value
var count = 1
var aOptional: Int? = 5 
if aOptional != nil { 
    let uvalue = aOptional! 
        count = count + uvalue
}
print(count) // 6


// does not contain a value
var newCount = 1
var otherOptional: Int? = nil
if otherOptional != nil { 
    let uvalue = otherOptional! 
        newCount = newCount + uvalue
}
print(newCount) // 1
