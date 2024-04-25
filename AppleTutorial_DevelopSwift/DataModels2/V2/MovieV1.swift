//
//  MovieV1.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Commented by Claude on 4/24/24
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
}
