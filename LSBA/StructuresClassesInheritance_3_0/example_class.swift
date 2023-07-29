/
//  Made with Swift 5.7, Xcode 14.3.1, 7/29/2023
//
//  Used Blank Playground Format
//
//  Reference: Learn Swift by Building Applications - Emil Atanasov
//

import UIKit

var greeting = "Hello, playground which provides an example of a class"
print(greeting)

//  class example
//  keyword is class; a class is a reference type
//  classes are custom data types;

class Ship {
    var speed = 0
    var isFlying = false
    
    var description:String {
        get {
            return "The ship speed is \(self.speed) and it can\(self.isFlying  ? "" : "not") fly"
        }
    }
}

// fields contain stored properties
// create a instances of a class

let ship = Ship()
ship.speed = 10
ship.isFlying = false
//  The ship speed is 10 and it cannot fly
print("Sailboats are ships")
print(ship.description)

let airShip = Ship()
airShip.speed = 20
airShip.isFlying = true
//  The airship speed is 10 and can fly
print("Airships are ships")
print(airShip.description)
