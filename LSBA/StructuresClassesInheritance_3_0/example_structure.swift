//
//  Made with Swift 5.7, Xcode 14.3.1 on 7/29/2023
//
//  Used Blank Playground Format
//
//  Reference: Learn Swift by Building Applications - Emil Atanasov
//

import UIKit

var greeting = "Hello, playground which provides an example of a structure"
print(greeting)

// struct example
// keyword is struct; a structure is a value type
// structures are custom data types; basic data types are implemented as structures

struct Car {
    var name:String = "missing name"
    var speed = 0
    var maxSpeed = 200

     // method
     // code adds a method which can be called when there is an instance of the Car type.
    
     func getDescription() -> String {
         return "The \(self.name) is currently at \(self.speed) kmh and has a max speed of \(self.maxSpeed) kmh"
     }
     //  property - getter (method), but it's invoked slightly different
    
     var description:String {
         get {
             return self.getDescription()
         }
     }
}

// creates an instance of a car type
// an object (a structure instance) can have functions (methods)

var audi = Car(name:"Audi R8", speed: 280, maxSpeed:331)
//print(audi.getDescription())
print(audi.description)

