//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Commented and refactored by Claude on 4/25/24
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI,
which allows for a declarative and concise way of constructing the user interface.
The content view now includes the capability to delete movie entries.

References:
- "Create, update, and delete data" tutorial from Apple Developer:
  https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
- SwiftData Documentation
  https://developer.apple.com/documentation/swiftdata
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - Properties
    
    /// The model context used to interact with the app's data.
    @Environment(\.modelContext) private var modelContext
    
    /// The list of movies fetched from the model context.
    @Query private var movies: [Movie]
    
    // MARK: - View Body
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    NavigationLink {
                        Text(movie.title)
                            .navigationTitle("Movie")
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
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
        }
    }
    
    // MARK: - Private Methods
    
    /// Adds a new movie to the model context.
    private func addMovie() {
        withAnimation {
            let newItem = Movie(title: "New Movie", releaseDate: .now)
            modelContext.insert(newItem)
        }
    }
    
    /// Deletes the selected movie items from the model context.
    /// - Parameter offsets: The index set of the items to be deleted.
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
        .modelContainer(for: Movie.self, inMemory: true)
}
