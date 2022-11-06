// This script will generate examples of arrays and tuples 
/*
 Made with:
 iPad
 Swift 5.7
 Swift Playgrounds 4.1
 */

/*
 Reference:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 */

// An array is an ordered list using [ ] syntax
// explicitly typed array examples
let immutable_array : [Int] = [1,2,3]
print("this is an immutable array which uses keyword let and integer type ", immutable_array)

var mutable_array : [String] = ["a","b","c"]
print("this is a mutable array which uses keyword var and string type ",mutable_array)

var mixed_array : [Any] = [1,"a"]
print("this is a mixed type array ", mixed_array)

// A tuple is an ordered list, which can hold multiple types, using ( ) syntax
// Tuples are designed for related & interconnected data are often used to return multiple values from a function 
let serverError = (code:500, message:"Internal Server Error")

print("this is part of a tuple: ", serverError.code)
print("this is part of a tuple: ", serverError.message)
