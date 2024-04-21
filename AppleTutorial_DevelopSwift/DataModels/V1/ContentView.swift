//
//  ContentView.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//

/*
 
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
 - Welcome to data modeling  https://developer.apple.com/tutorials/develop-in-swift/welcome-to-data-modeling
 
*/

import SwiftUI

struct ContentView: View {
    
    /// Always mark state properties private so other views can't interfere with their value
    /// State property called friends stores an array of String values
    /// Date.now captures the exact moment that the code runs
    @State private var friends: [Friend] = [
        Friend(name: "Harry Potter", birthday: .now),
        ///A Date is stored as seconds past a fixed reference. The start of the year 1970 is one of those reference dates, known as the Unix epoch.
        Friend(name: "Rubeus Hagrid", birthday: Date(timeIntervalSince1970: 0))
    ]
    
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
        }
    }
}

#Preview {
    ContentView()
}
