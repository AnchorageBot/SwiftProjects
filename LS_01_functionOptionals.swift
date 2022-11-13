// This script will generate examples of functions which use optionals

/*
 
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7
 
 References:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 
 Swift 5.7 Language Guide
 
 */

// Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

// If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple, you can use an optional tuple return type to reflect the fact that the entire tuple can be nil.

// To handle an empty array safely, write a minMax(array:) function with an optional tuple return type and return a value of nil when the array is empty

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return(currentMin, currentMax)
}

print(minMax(array: []))

print()

print(minMax(array: [5,]))

print()

print(minMax(array: [5,15]))

print()

print(minMax(array: [5,-15]))

print()

// You can use optional binding to check whether this version of the minMax(array:) function returns an actual tuple value or nil:

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

// Prints "min is -6 and max is 109"
