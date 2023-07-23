// This script will generate examples of enumerations 

/*
 
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7
 
 References:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 
 Swift 5.7 Language Guide
 
 */

// An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

// Video game example

enum BasicWeapon {
    case laser
    case missile
}

enum AdvancedWeapon {
    case laser(powerLevel: Int)
    case missile(range: Int)
}

let spaceLaser = AdvancedWeapon.laser(powerLevel: 5)

switch spaceLaser {
case .laser(powerLevel: 0...10 ):
    print("It's a space laser with power from 0 to 10!")
case .laser:
    print("It's a space laser!")
case .missile(let range):
    print("It's a space missile with range \(range)!")
}
