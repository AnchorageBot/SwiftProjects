
/*
 
 LS_02_closures.swift
 
 Swift Playgrounds 4.3.1, Swift 5.8
 
 Made on 8/23/2023
 
 Reference:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Closures are small, anonymous chunks of code that you can use like functions
 
 Closures are great for passing to other functions in order to tell them how they 
  should carry out a certain task
 
 Closures have a special keyword, in. The in keyword lets Swift know where to break up the 
  closure from its definition and its implementation
 
*/

let numbers = [2,1,56,32,120,13]

var numbersSorted = numbers.sorted(by: {
    (n1: Int, n2: Int) -> Bool in return n2 > n1
})

print(numbersSorted)
// [1, 2, 13, 32, 56, 120]

let numbersSortedReverse = numbers.sorted(by: {n1, n2 in return n1 > n2})

print(numbersSortedReverse)
//[120, 56, 32, 13, 2, 1]
