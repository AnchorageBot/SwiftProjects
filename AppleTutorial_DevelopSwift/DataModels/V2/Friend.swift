//
//  Friend.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//

/*
 
Abstract:

This code stores data which will be displayed in the app's content view. The file is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
 - Welcome to data modeling  https://developer.apple.com/tutorials/develop-in-swift/welcome-to-data-modeling
 
*/


import Foundation

/// the Friend struct stores data, which you’ll display in ContentView.
struct Friend {
    
    let name: String
    
    /// The Swift Date type represents a specific point in time, down to fractions of a second.
    let birthday: Date
    
}
