// OptionalBinding.swift
//
// Made with Swift Playgrounds, Swift 5.8
// 
// 8/11/2023
//
// Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
//
/* 
 
Optional Binding
 
Checks the optional and unwraps its value at the same time

The optional is unwrapped as part of the condition. If it is 
different from nil, its value is assigned to the uvalue
constant and the statements in the block are executed,
otherwise, the statements inside the block are ignored.

 */

var count = 0 
var myoptional: Int? = 5 
    
if let uvalue = myoptional { 
    count = count + uvalue 
}

print(count) // 5
