//
//  ContentView.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//  Commented and refactored by Claude on 4/21/24
//

/*
 Abstract:
 The primary role of a content view is to display the app's data.
 This code represents the app's main content view. The view is built using SwiftUI,
 which allows for a declarative and concise way of constructing the user interface.

 References:
 - Welcome to data modeling
   https://developer.apple.com/tutorials/develop-in-swift/welcome-to-data-modeling
 - SwiftUI Documentation
   https://developer.apple.com/documentation/swiftui
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    // @Query fetches an array of Friend instances from SwiftData
    @Query private var friends: [Friend]
    
    // Access the modelContext environment value for saving new items
    @Environment(\.modelContext) private var context
    
    // State properties for handling user input
    @State private var newName = ""
    @State private var newBirthday = Date()
    
    var body: some View {
        NavigationStack {
            List(friends) { friend in
                HStack {
                    // Display a birthday cake icon if it's the friend's birthday today
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake")
                    }
                    // Display the friend's name in bold if it's their birthday today
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
                    Spacer()
                    // Display the friend's birthday in a formatted date string
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    // DatePicker for selecting the new friend's birthday
                    DatePicker(
                        selection: $newBirthday,
                        in: Date.distantPast...Date(),
                        displayedComponents: .date
                    ) {
                        // TextField for entering the new friend's name
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    // Button for saving the new friend
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        // Reset the input fields after saving
                        newName = ""
                        newBirthday = Date()
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
