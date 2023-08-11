// Closures.swift
//
// Made with Swift Playgrounds, Swift 5.8
// 
// 8/11/2023
//
// Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
//

/*
 
Closures
 
Simple blocks of code with the syntax
 
 { (parameters) -> Type in statements }
 
They are like functions (functions are closures with a name), 
but they are wrapped with braces and the in keyword is
included to separate the data types from the statements
 
 */

let multiplier = { (number: Int, times: Int) -> Int in 
    let total = number * times 
    return total }
    print("The result is \(multiplier(5, 5))") 
  
// "The result is 25"


/* 
 
Swift can also infer the data types of the values received by the closure and therefore we don't have to declare that either. Instead, we can represent these values using shorthand argument names. 

These are special placeholders made up of the $ symbol and an index starting from 0. The first value received by the closure is represented by $0, the second value by $1, and so on.
 
 */

func processclosure(multiplication: (Int, Int) -> Int) {
    print("The result is: \(multiplication(5,5))")
} 
processclosure() { $0 * $1 }

// The result is: 25
