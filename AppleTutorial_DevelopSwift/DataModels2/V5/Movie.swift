//
//  Movie.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Commented by Claude on 4/24/24
//  Refactored on 4/28/24
//

/*
 
Abstract:
 The `Movie` class represents an entity in the FavoriteMovies app that has an associated timestamp.
   It is used to encapsulate a 'releaseData' value and serves as a base class for other entities in the app.
 'Movie' was the result of right clicking the original word 'Item', selecting Refactor -> Rename from the drop down menu,
    entering 'Movie' and pressing return. This action updated the FavoriteMoviesApp.swift, the ContentView.swift, and the Movie.swift files.
 'releaseData' was the result of right clicking the original word 'timestamp', selecting Refactor -> Rename from the drop down menu,
    entering 'Movie' and pressing return. This action updated the FavoriteMoviesApp.swift, the ContentView.swift, and the Movie.swift files.

References:
 - "Create, update, and delete data" tutorial from Apple Developer:
  https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata

*/

import Foundation
import SwiftData

/// The `Movie` class represents an entity with a timestamp.
/// It is annotated with `@Model` to indicate that it is a model entity managed by SwiftData.
@Model
final class Movie {
    
    /// stores the movie title
    var title: String

    /// The timestamp associated with the item.
    /// It represents the date and time when the item was created, modified, or some other relevant event occurred.
    var releaseData: Date
    
    /// Initializes a new instance of the `Movie` class with the specified timestamp.
    ///
    /// - Parameter timestamp: The timestamp value to be associated with the item.
    init(title: String, releaseDate: Date) {
        // Assign the provided releaseData value to the `timestamp` property of the class.
        self.title = title
        self.releaseData = releaseDate
    }
    
    ///  Declares an array to hold favorite movies and store them in a static property named sampleData.
    ///
    static let sampleData = [
        
        /// Initializes releaseDate using an offset, measured in seconds, from the reference date.
        /// The reference date is a fixed point in time — January 1, 2001 — which allows apps to calculate and compare times in a consistent way. A negative time interval offset means you want a date before the reference date.
        Movie(title: "Blade Runner",
              releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        
        Movie(title: "Blade Runner 2049",
              releaseDate: Date(timeIntervalSinceReferenceDate: 402_000_000))
    ]
}
