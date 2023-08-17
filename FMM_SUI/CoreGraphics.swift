//
// CoreGraphics.swift
//
// Made with Swift Playgrounds, Swift 5.8, iOS 16
// 
// 8/16/2023
//
// Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022
// https://developer.apple.com/documentation/coregraphics
//

/*
 
Core Graphics is an old framework programmed in the C language.

It was developed to provide a platform-independent two-dimensional drawing engine for Apple systems. 

Due to its characteristics, instead of being replaced, the framework was integrated with newer
frameworks and, therefore, it remains in use.
 
 */


// Access the structures inside a CGRect structure

import CoreGraphics

var myrect = CGRect(x: 30, y: 20, width: 100, height: 200) 
var mypoint = myrect.origin 
var mysize = myrect.size 

print("The origin is at \(mypoint.x) and \(mypoint.y)")

// The origin is at 30.0 and 20.0

print("The size is \(mysize.width) by \(mysize.height)")

// The size is 100.0 by 200.0
