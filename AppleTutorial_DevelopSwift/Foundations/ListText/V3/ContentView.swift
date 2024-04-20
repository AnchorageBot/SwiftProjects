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
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    
    var body: some View {
        
        VStack {
            
            /// Displays the picked name or, if there’s no picked name, a single space
            /// By using a single space instead of an empty string, you ensure the text view always occupies vertical space on the screen. A Text view takes up no space when it doesn’t have any content, which causes other views on the screen to shift.
            /// It has three parts: First, a Boolean condition, followed by a space and a question mark. Next, the value to use when the condition is true, followed by a colon. Last, the value to use when the condition is false.
            Text(pickedName.isEmpty ? " " : pickedName)
            
            /// List view adds other views to the content in its body, like separators between rows and visual elements such as rounded corners and backgrounds.
            List {
                
                /// ForEach creates a dynamic list
                /// uses a closure with a parameter to represent each value from the data set you give
                /// read the syntax name in as “a name value coming into the closure.”
                ForEach(names, id: \.self) {name in
                    Text(name)
                }
            }
            
            /// Creates a TextField beneath the list and passes it a binding to the nameToAdd property
            /// To create a binding to a state property, prefix the property name with $.
            TextField("Add Name", text: $nameToAdd)
            
            /// Autocorrection doesn’t always recognize names, so it makes sense to disable it for the app
                .autocorrectionDisabled()
            
            ///The .onSubmit modifier adds the entered name to the names array and resets the text field. Similar to a button, .onSubmit uses a closure to run imperative code when someone taps Return.
                .onSubmit {
                    
                    /// You can read this code as “if nameToAdd is not empty.”
                    if !nameToAdd.isEmpty {
                        
                        /// Use .append to add a new value to an array. It’s similar to the way you modify a view.
                        names.append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            
            /// Use .randomElement() with an array to get one of its elements at random. If the array is empty, you’ll get the special Swift value nil, which indicates a non-value.
            Button("Pick Random Name") {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                } else {
                    pickedName = ""
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
