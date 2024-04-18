//
//  ContentView.swift
//  Pick_A_Pal
//
//  Created by ATS on 4/17/24
//  Xcode version 15.3
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
 - Swift Lists and text fields https://developer.apple.com/tutorials/develop-in-swift/create-dynamic-content
*/

import SwiftUI

struct ContentView: View {
    
    /// Always mark state properties private so other views can't interfere with their value
    /// state property called names stores an array of String values
    @State private var names: [String] = ["Andre", "Elisha", "Jasmine", "Po-Chun"]
    
    var body: some View {
        
        VStack {
            
            /// List view adds other views to the content in its body, like separators between rows and visual elements such as rounded corners and backgrounds.
            List {
                
                /// ForEach creates a dynamic list
                /// uses a closure with a parameter to represent each value from the data set you give
                /// read the syntax name in as “a name value coming into the closure.”
                ForEach(names, id: \.self) {name in
                    Text(name)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
