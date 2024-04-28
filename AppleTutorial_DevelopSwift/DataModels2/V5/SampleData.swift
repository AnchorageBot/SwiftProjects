//
//  SampleData.swift
//  FavoriteMovies
//
//  Created by ATS on 4/28/24
//  Created with Xcode 15.3
//

/*
 
Abstract:
 Creates a permanent sample data that doesn’t interfere with the persisted data store. All the previews will use this data so you can see the changes.

References:
 - "Create, update, and delete data" tutorial from Apple Developer:
  https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata

*/

import Foundation
import SwiftData

/// Declares that all code in this class must run on the main actor, including access to the mainContext property. Since all the SwiftUI code in an app runs on the main actor by default, you’ve satisfied the condition.
@MainActor

/// This class will create a model container that provides sample movies.
/// This builds the model container explicitly. That way, instead of needing to repeat sample data code in many places, you can create and manage your sample data in one place, then use it in all your previews.
class SampleData {
    
    ///  A shared instance of the SampleData class
    ///  The static keyword defines the shared property as belonging to the class itself, not each individual instance.
    ///  In this case, the single shared instance is the only one you create, which ensures that shared is the only instance of SampleData. This is a common way to create globally shared objects.
    static let shared = SampleData()
    
    /// This model container will store its data in memory without persisting it.
    let modelContainer: ModelContainer
    
    /// A computed property to access the main context of the model container.
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    /// Necessary for setting up SwiftData
    /// Instances of SampleData can only be created from within the SampleData class itself
    private init() {
        
        let schema = Schema([
            
            Movie.self,
        ])
        /// Stores its data in memory only, without persisting it to disk.
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            /// Stores data in memory only, without persisting it to disk
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            /// Calls the insertSampleData method from the initializer
            insertSampleData()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    /// A function to make the sample data.
    /// Uses a for loop to add each movie to the model context
    func insertSampleData() {
        for movie in Movie.sampleData {
            /// Iinserts the movie into the model context.
            /// SwiftData inserts each movie into its model container, where it tracks them for changes.
            context.insert(movie)
        }
        
        /// Handles errors
        /// Saves the model context.
        do {
            try context.save()
        } catch {
            /// Common methds to handle errors include printing messages, showing alerts, and canceling an action
            print("Sample data context failed to save")
        }
    }
}
