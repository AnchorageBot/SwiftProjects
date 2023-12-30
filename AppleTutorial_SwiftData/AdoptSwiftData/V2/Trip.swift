/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model class of trips.
*/

import Foundation
import SwiftUI
import SwiftData

@Model final class Trip {
    var destination: String
    var endDate: Date
    var name: String
    var startDate: Date
    
    @Relationship(deleteRule: .cascade, inverse: \BucketListItem.trip)
    var bucketList: [BucketListItem] = [BucketListItem]()
    
    @Relationship(deleteRule: .cascade, inverse: \LivingAccommodation.trip)
    var livingAccommodation: LivingAccommodation?
    
    init(
        name: String, destination: String,
        startDate: Date = .now, endDate: Date = .distantFuture
    ) {
        self.name = name
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
    }
}
 
extension Trip {
    @Transient
    var color: Color {
        let seed = name.hashValue
        var generator: RandomNumberGenerator = SeededRandomGenerator(seed: seed)
        return .random(using: &generator)
    }
    
    @Transient
    var displayName: String {
        name.isEmpty ? "Untitled Trip" : name
    }
    
    @Transient
    var displayDestination: String {
        destination.isEmpty ? "Untitled Destination" : destination
    }
    
    static var preview: Trip {
        Trip(name: "Trip Name", destination: "Trip destination",
             startDate: .now, endDate: .now.addingTimeInterval(4 * 3600))
    }
}

private struct SeededRandomGenerator: RandomNumberGenerator {
    init(seed: Int) {
        srand48(seed)
    }
    
    func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}

private extension Color {
    static var random: Color {
        var generator: RandomNumberGenerator = SystemRandomNumberGenerator()
        return random(using: &generator)
    }
    
    static func random(using generator: inout RandomNumberGenerator) -> Color {
        let red = Double.random(in: 0..<1, using: &generator)
        let green = Double.random(in: 0..<1, using: &generator)
        let blue = Double.random(in: 0..<1, using: &generator)
        return Color(red: red, green: green, blue: blue)
    }
}
