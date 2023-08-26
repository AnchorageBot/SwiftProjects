/* 
 
 guard.swift

 Swift Playgrounds 4.3.1, Swift 5.8, iOS 16

 8/26/2023

 Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022

The guard instruction is intended to prevent the execution of the code that follows 
the statement

For example, we can break the execution of a loop when a condition is satisfied,
as we do with an if else statement
 
 */

var phrase = "Good Morning Louise" 
var counter = 0

for letter in phrase { 
    guard letter != "L" else {
    break
    }
    counter += 1
  } 

print(phrase)
print()

var guard_letter = "The phrase contains \(counter) characters before the letter L" 
print(guard_letter) // The phrase contains 13 characters before the letter L
