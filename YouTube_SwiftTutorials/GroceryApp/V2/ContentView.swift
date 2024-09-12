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
                    
                    newItemString = ""
                    
                }
                
                    
                List {
                    ForEach(items) { item in
                        Text(item.title)
                    }
//                        VStack {
//                            Text(item.title)
//                            Text(item.subtitle)
//                            Text(item.date.formatted())
//                        }
                        .onDelete {
                            indexSet in indexSet.forEach({ index in context.delete(items[index])
                            })
                    }
                }
                    
                .overlay {
                    if items.isEmpty {
                        Text("No items")
                        }
                    }
                }
            
            .navigationTitle("Grocery List")
            }
            
            //.padding()
        }
    }


#Preview {
    ContentView()
}
