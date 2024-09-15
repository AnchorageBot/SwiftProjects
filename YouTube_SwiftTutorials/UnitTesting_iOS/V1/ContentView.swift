//
// BasicMath
// ContentView.swift
//
// Created on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
 
 Abstract:
 
 This app will work through how to run unit tests on basic math functions
 
 This file defines the main user interface for the BasicMath application.
 
 It requests that the user enter two integers and then adds, mulitiplies, subtracts, and divides the numbers. Next, it displays the results of these four operations. Finally it determines if the numbers are odd, even, and/or prime
 
 App strategy:
 * Model: Data (NumberListItem)
 * Container: Where things are saved (SwiftData modelContainer)
 * Context: How user interacts with the app (Environment modelContext)
 
 */

import SwiftUI
import SwiftData

// func isOdd
    //do
    //guard

// func isEven
    //do
    //guard

// func isPrime
    //do
    //guard


/// The main view of the BasicMath app.
struct ContentView: View {
    
    // Access the SwiftData model context
    @Environment(\.modelContext) var context
    
    // State variable to hold the text for a new item
    @State var newItemString = ""
    
    // Query to fetch all MathListItems
    @Query var items: [NumberListItem]
    
    // MARK: - Body
    var body: some View {
        
            NavigationView {
                VStack {
                    // Text field for adding new items
                    TextField("Add item", text: $newItemString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Button to save new items
                    Button("Save") {
                        guard !newItemString.isEmpty else {
                            return
                        }
                        
                        // Create and insert a new item
                        let newItem = NumberListItem(title: newItemString, subtitle: "Cool number", date: Date())
                        context.insert(newItem)
                        
                        // Clear the text field
                        newItemString = ""
                    }
                    
                    // List of math items
                    List {
                        ForEach(items) { item in
                            Text(item.title)
                        }
                        .onDelete { indexSet in
                            // Delete selected items
                            indexSet.forEach { index in
                                context.delete(items[index])
                            }
                        }
                    }
                    .overlay {
                        // Show a message when the list is empty
                        if items.isEmpty {
                            Text("No numbers")
                        }
                    }
                }
                .navigationTitle("Number List")
            }
        }
    }

#Preview {
    ContentView()
}
