//
// GroceryList
// ContentView.swift
//
// Created on 9/10/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
 
 Abstract:
 
 Creates a grocery list
 
 App strategy
 * Model: Data
 * Container: Where things are saved
 * Context: How user interacts with the app
 
 */

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    
    @State var newItemString = ""
    
    @Query var items: [GroceryListItem]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                TextField("Add item", text: $newItemString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    guard !newItemString.isEmpty else {
                        return
                    }
                    
                    let newItem = GroceryListItem(title: newItemString, subtitle: "Buy this ASAP", date: Date())
                    
                    context.insert(newItem)
                    
                }
                
                    
                List {
                    
                }
                    
                .overlay {
                    if items.isEmpty {
                        Text("No items")
                        }
                    }
                }
            }
            
            .padding()
        }
    }


#Preview {
    ContentView()
}
