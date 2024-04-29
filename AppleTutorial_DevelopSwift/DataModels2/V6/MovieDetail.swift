//
//  MovieDetail.swift
//  FavoriteMovies
//
//  Created by ATS on 4/28/24
//  Made with Xcode 15.3
//  Reviewed and commented by Claude on 4/28/24
//

/*
Abstract:
A way to view and edit the details of a movie. You'll push this new view onto the navigation stack from each list row.

References:
  - "Create, update, and delete data" tutorial from Apple Developer:
   https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
  - SwiftData Documentation
    https://developer.apple.com/documentation/swiftdata
*/

import SwiftUI

struct MovieDetail: View {
    /// The @Bindable annotation silently creates a $movie property,
    @Bindable var movie: Movie

    var body: some View {
        /// The Form container view presents data for display and editing
        Form {
            /// A text field to lets people edit the movie title.
            /// Passes a binding to a property of an instance using dot notation along with the $ prefix.
            TextField("Movie title", text: $movie.title)

            /// Date picker allows the user to edit the movie's release date.
            DatePicker("Release date", selection: $movie.releaseData, displayedComponents: .date)
        }
        .navigationTitle("Movie")
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}
