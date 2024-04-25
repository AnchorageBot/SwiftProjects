//
//  MovieV2.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Commented and refactored by Claude on 4/24/24
//

/*
Abstract:
The `Movie` class represents a movie entity in the FavoriteMovies app. It encapsulates the movie's title and release date.

The class was renamed from `Item` to `Movie` using the refactoring functionality in Xcode. The `timestamp` property was also
    renamed to `releaseDate` to better reflect its purpose.

References:
- "Create, update, and delete data" tutorial from Apple Developer:
  https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
- SwiftData Documentation:
  https://developer.apple.com/documentation/swiftdata
*/

import Foundation
import SwiftData

/// The `Movie` class represents a movie entity.
/// It is annotated with `@Model` to indicate that it is a model entity managed by SwiftData.
@Model
final class Movie {
    /// The title of the movie.
    var title: String
    
    /// The release date of the movie.
    /// It represents the date when the movie was released or made available.
    var releaseDate: Date
    
    /// Initializes a new instance of the `Movie` class with the specified title and release date.
    ///
    /// - Parameters:
    ///   - title: The title of the movie.
    ///   - releaseDate: The release date of the movie.
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
}
