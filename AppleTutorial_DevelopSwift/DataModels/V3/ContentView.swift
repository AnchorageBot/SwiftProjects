//
//  ContentView.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//  Refactored on 4/21/24
//

/*
 
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
 - Welcome to data modeling  https://developer.apple.com/tutorials/develop-in-swift/welcome-to-data-modeling
 
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    
    /// Always mark state properties private so other views can't interfere with their value
    /// State property called friends stores an array of String values
    /// Date.now captures the exact moment that the code runs
    /// Change the annotation on your friends array from @State to @Query to fetch Friend instances stored in SwiftData.
    /*
     @State private var friends: [Friend] = [Friend(name: "Harry Potter", birthday: .now),
        ///A Date is stored as seconds past a fixed reference. The start of the year 1970 is one of those reference dates, known as the Unix epoch.
        Friend(name: "Rubeus Hagrid", birthday: Date(timeIntervalSince1970: 0))
    ] 
     */
    
    /// As the name suggests, @Query asks SwiftData for an array of data — in this case, [Friend]. When you update the instances of Friend stored in SwiftData, the query updates your views, just like a @State property does.
    @Query private var friends: [Friend]
    
    /// SwiftData requires a ModelContext to save new items. Access the \.modelContext environment value.
    /// A ModelContext provides a connection between the view and the model container so that you can fetch, insert, and delete items in the container. The .modelContainer modifier you added to ContentView inserts a modelContext into the SwiftUI environment, and that modelContext is accessible to all views under the container.
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    
    @State private var newDate = Date.now
    
    var body: some View {
        
        NavigationStack {
            
            List(friends, id: \.name) { friend in
                
                HStack {
                    
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            
            /// Use .safeAreaInset(edge: .bottom) to pin your new friend-entry UI to the bottom of the screen, below the list of friends.
            ///.safeAreaInset anchors content to the top or bottom of the screen.
            .safeAreaInset(edge: .bottom) {
                
                VStack(alignment:  /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                    Text("New Birthday")
                       .font(.headline)
                    
                    /// Configures the DatePicker so that you can’t select a date in the future.
                    /// The last argument, displayedComponents: .date, sets the picker to display only the controls for the date.
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        
                    /// Add a Save button that creates a new Friend model.
                    Button("Save") {
                        
                        /// newFriend is an instance of Friend that contains the entered name and birthday. Recall that Friend is not a view and has no body; it models those two pieces of data.
                        let newFriend = Friend(name: newName, birthday: newDate)
                        
                        /// Add the new friend to the array that powers the List.
                        /// .append places the new friend at the end of the array. The change to the array triggers a SwiftUI update, and the name is rendered at the bottom of the list.
                        //friends.append(newFriend)
                        
                        /// n your Save button code, replace the local append method with one that inserts the new Friend model into the ModelContext.
                        /// Inserting into the ModelContext saves the new Friend into the container. Since @Query is also connected to the container, it will pick up and display the new Friend without you explicitly adding newFriend to friends.
                        context.insert(newFriend)
                        
                        /// Reset the entry state values.
                        newName = ""
                        newDate = .now
                        }
                        
                    .bold()
                        
                    }
                    .padding()
                    
                    /// .bar styles the background in the same style as a system toolbar.
                    .background(.bar)
                }
                .task {
                    
                    /// SwiftUI begins executing the code in a .task before the view appears. Here, when you insert the model objects, @Query picks them up and updates the friends property.
                    context.insert(Friend(name: "Harry Potter", birthday: .now))
                    context.insert(Friend(name: "Rubeus Hagrid", birthday: Date(timeIntervalSince1970: 0)))
                }
            }
        }
    }
}

#Preview {
    ContentView()
    
        /// Think of the container as a translator between where the Friend data is stored and the ContentView onscreen. Friend.self references the type Friend rather than a specific friend. The container uses the type blueprint to understand how the model should be saved.
        /// Previews should start in the same initial state every time they refresh. By specifying inMemory as true, you tell the container to use an in-memory container. In-memory refers to the storage mechanism: Data is stored only as long as the app is in memory.
        .modelContainer(for: Friend.self, inMemory: true )
}
