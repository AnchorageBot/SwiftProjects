/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The SwiftUI app.
*/

import SwiftUI
import SwiftData

@main
struct TripsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Trip.self)
    }
}
