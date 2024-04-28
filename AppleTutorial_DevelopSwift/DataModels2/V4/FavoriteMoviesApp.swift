//
//  FavoriteMoviesApp.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Refactored on 4/25/24
//

/*
 Abstract:
 This code serves as the entry point of the FavoriteMovies app. It sets up the app's
 main structure using the App protocol and specifies the initial view to be
 displayed when the app launches. The ContentView will contain the main content
 and layout of the app, which is defined in a separate file.

 References:
 - App Protocol Documentation
   https://developer.apple.com/documentation/swiftui/app
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata
*/

import SwiftUI
import SwiftData

@main
struct FavoriteMoviesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
