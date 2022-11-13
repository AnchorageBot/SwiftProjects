// This script will generate examples of structures and classes

/*
 
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7
 
 References:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 3
 
 Swift 5.7 Language Guide

 Apple Developer: Choosing Between Structures and Classes (Decide how to store data and model behavior)
 
 */

/*
 
 Structures and classes are good choices for storing data and modeling behavior in your apps, but their similarities can make it difficult to choose one over the other.
 
 Consider the following recommendations to help choose which option makes sense when adding a new data type to your app:
 
 * Use structures by default.
 * Use Structures When You Don’t Control Identity
 * Use classes when you need Objective-C interoperability
 * Use classes when you need to control the identity of the data you’re modeling
 * Use structures along with protocols to adopt behavior by sharing implementations
 
 */
 
struct WorkRecord {
    let workID: Int
    var workNickname: String
}

// var myRecord = try JSONDecoder().decode(WorkRecord.self, from: jsonResponse)

print(WorkRecord.init(workID: 1, workNickname: "George Costanza"))

print()

class Vehicle {
    var currentSpeed = 55.0
    var vehicleColor = "Grey"
    var description: String {
        return "\(vehicleColor) vehicle traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // Honk the horn
    }
    func speedUp() {
        // Accelerate the vehicle
    }
    func slowDown() {
        // Slow the vehicle
    }
}

let someVehicle = Vehicle()

print("Vehicle: \(someVehicle.description)")
