//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Refactored on 4/28/24
//  Reviewed and commented by Claude on 4/28/24
//  Refactored on 5/4/24
//

/*
 
Abstract:
 The primary role of a content view is to display the app's data.
 This code represents the app's main content view. The view is built using SwiftUI,
 which allows for a declarative and concise way of constructing the user interface.
 The content view now includes the capability to delete friend entries.

References:
 - "Create, update, and delete data" tutorial from Apple Developer:
  https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata

*/

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    /// Holds a new movie
    /// The question mark at the end of Movie? marks this as an optional type, meaning that newMovie might hold an instance of Movie or it might hold nothing, notated by nil.
    /// When a structure is created, Swift sets the value of all optional properties to nil unless otherwise specified.
    @State private var newMovie: Movie?

    var body: some View {
        NavigationSplitView {
            
            List {
                
                ForEach(movies) { movie in
                    NavigationLink {
                        MovieDetail(movie: movie)
                    } label: {
                        Text(movie.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addMovie) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            ///  Triggers a sheet to appear when an optional property has a value.
            ///  When the value is set to nil, the sheet is stowed away.
            ///  Passes a binding to allow the sheet to set the property to nil, which happens automatically when the sheet is dismissed.
            .sheet(item: $newMovie) { movie in
                NavigationStack {
                    ///
                    MovieDetail(movie: movie, isNew: true)
                }
                /// prevents the user from dragging the sheet down to dismiss it
                .interactiveDismissDisabled()
            }
            
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
        }
    }

    private func addMovie() {
        withAnimation {
            let newItem = Movie(title: "New Movie", releaseDate: .now)
            modelContext.insert(newItem)
            newMovie = newItem
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(movies[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
