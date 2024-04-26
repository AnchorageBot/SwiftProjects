//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24
//  Made with Xcode 15.3
//  Refactored on 4/25/24
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
    @Query private var movies: [Movie]

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

    private func addMovie() {
        withAnimation {
            let newItem = Movie(title: "New Movie", releaseDate: .now)
            modelContext.insert(newItem)
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
        .modelContainer(for: Movie.self, inMemory: true)
}
