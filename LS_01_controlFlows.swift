// This script will generate examples of control flows such as if-else loops, for-in loops, while loops, and switches

/*
 
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7

 References:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 
 Swift 5.7 Language Guide
 https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
 
 */

// if-else loops are conditional statements that use true/false to check multiple statements
// if-else loops use a { } syntax
let ifVariable = 5

if ifVariable == 1 {
    print("variable equals one")
}
else if ifVariable <= 3 {
    print("variable is less than or equal to three")
}
else if ifVariable == 4 {
    print("variable equals four")
}
else {
    print("variable equals something else")
}
print()

// The for-in loop iterates over a sequence, such as items in an array, ranges of numbers, characters in a string, or over a dictionary
// for-in loops use { } syntax

let name_array = ["Anna", "Alex", "Brian", "Batman"]
for name in name_array {
    print("Hello, \(name)!")
}
print()

for num_range in 1...9 {
    print("\(num_range) times 9 is \(num_range * 9)")
}
print()

let string_of_characters = "Swift"
for characters in string_of_characters {
    print("character = \(characters)")
}
print()

let legDictionary = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in legDictionary {
    print("\(animalName)s have \(legCount) legs")
}
print()

// A while loop lets you repeatedly run code while a certain condition remains true
// while loops use a { } syntax

var countDown = 5
while countDown > 0 {
    countDown -= 1
    print(countDown)
}

print()

// A switch statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully
// Switches must cover all possible values
// Switches use { } syntax

let integerSwitch = 3
switch integerSwitch {
case 0:
    print("variable is 0")
case 1:
    print("variable is 1")
case 2:
    print("variable is 2")
default:
    print("variable equals something else")
}

print()

var someNumber = 15
switch someNumber {
case 0...10:
    print("Number is between 0 and 10")
case 11...20:
    print("Number is between 11 and 20")
case 21:
    print("Numer is 21!")
default:
    print("Number is something else")
}
