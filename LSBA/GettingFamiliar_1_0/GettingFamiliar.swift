/*:
 
 This Playground was made with
    Swift 5.7, Xcode 14.3.1
 
 This exercise was adapated from
    Learn Swift by Building Applications: Explore Swift Programming through iOS App Development by Emil Atanasov
 
 */

import UIKit

var greeting = "Hello, playground"

switch greeting {
case "swift":
    print("Hello, Swift 5.7")
default:
    print("Counting to five")
}

for i in 1...5 {
    print("\(i)")
}

print("\nCounting to three")

var sum = 0
for j in 1...3{
    print("\(j)")
    
    sum += j
}

let img = UIImage(named: "typhoon_mangkhut.jpg")
