// Optionals
//
// Made with Swift Playgrounds
// 8/8/2023
//
// Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
//

/*
 
A variable marked as optional may have a value or be empty
 
Sometimes we do not have an initial value to assign to the variable during development
or need to indicate the absence of a value because the current one becomes invalid
 
Although optionals seem to work like regular variables, they do not expose their values. 
To read the value of an optional, we must unwrap it by adding an exclamation mark at the end of the name
 
 */

var mynumber: Int? 
print(mynumber)
// nil

mynumber = 5 
print(mynumber)
// Optional(5)

mynumber = nil
print(mynumber)
// nil

mynumber = 10
print(mynumber)
// 10

var total = mynumber! * 10
print(total)
// 100

