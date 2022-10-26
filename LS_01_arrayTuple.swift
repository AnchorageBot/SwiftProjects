// This script will generate examples of arrays and tuples 

/*
 Made with:
 Swift 5.7
 Swift Playgrounds 4.1
 */

/*
 Reference:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 */

// An array is an ordered list using [ ]
// explicitly typed array examples
let immutable_array : [Int] = [1,2,3]
print("this is an immutable array which uses let and integer type ", immutable_array)

var string_array : [String] = ["a","b","c"]
print("this is a mutable array which uses var and string type ",string_array)

// A tuple is an unordered list using ( )
// Tuples are designed for related & interconnected data are often used to return multiple values from a function 
let serverError = (code:500, message:"Internal Server Error")
    
print("this is part of a tuple: ", serverError.code)
print("this is part of a tuple: ", serverError.message)
