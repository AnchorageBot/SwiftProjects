//
//  ContentView.swift
//  Pick_A_Pal
//
//  Created by ATS on 4/17/24
//  Xcode version 15.3
//  Refactored and commented on 4/20/24 by Claude
//

/*
 
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
 - Swift Lists and text fields https://developer.apple.com/tutorials/develop-in-swift/create-dynamic-content
- Anthropic AI: Claude
    https://www.anthropic.com
 
*/

import SwiftUI

struct ContentView: View {
    
    /// Always mark state properties private so other views can't interfere with their value
    /// State property called names stores an array of String values
    @State private var names: [String] = ["Andre", "Elisha", "Jasmine", "Po-Chun"]
    
    /// State property to store the name to add
    @State private var nameToAdd = ""
    
    /// State property to store the picked name
    @State private var pickedName = ""
    
    /// State property to control whether to remove the picked name from the list
    @State private var shouldRemovePickedName = false
    
    var body: some View {

        VStack {

            /// Displays the picked name or, if there's no picked name, a single space
            /// By using a single space instead of an empty string, you ensure the text view always occupies vertical space on the screen. 
            /// A Text view takes up no space when it doesn't have any content, which causes other views on the screen to shift.
            Text(pickedName.isEmpty ? " " : pickedName)
            
            /// List view adds other views to the content in its body, like separators between rows and visual elements such as rounded corners and backgrounds.
            List {

                /// ForEach creates a dynamic list
                /// Uses a closure with a parameter to represent each value from the data set you give
                /// Read the syntax name in as "a name value coming into the closure."
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            
            /// Creates a TextField beneath the list and passes it a binding to the nameToAdd property
            /// To create a binding to a state property, prefix the property name with $.
            TextField("Add Name", text: $nameToAdd)

                /// Autocorrection doesn't always recognize names, so it makes sense to disable it for the app
                .autocorrectionDisabled()

                /// The .onSubmit modifier adds the entered name to the names array and resets the text field. 
                /// Similar to a button, .onSubmit uses a closure to run imperative code when someone taps Return.
                .onSubmit {
                    addName()
                }
            
            /// Creates a Toggle and passes it a binding to the shouldRemovePickedName property
            /// To create a binding to a state property, prefix the property name with $.
            /// Because a toggle controls an on/off state, its binding is a Bool.
            Toggle("Remove picked names", isOn: $shouldRemovePickedName)
            
            Button(action: pickRandomName) {
                Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            /// Adds a buttonStyle and font to make the button more prominent.
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
    
    /// Adds the name entered in the text field to the names array if it's not empty
    private func addName() {
        guard !nameToAdd.isEmpty else { return }
        names.append(nameToAdd)
        nameToAdd = ""
    }
    
    /// Picks a random name from the names array and updates the pickedName state property
    /// If shouldRemovePickedName is true, removes the picked name from the names array
    private func pickRandomName() {
        guard let randomName = names.randomElement() else {
            pickedName = ""
            return
        }
        
        pickedName = randomName
        
        if shouldRemovePickedName {
            names.removeAll { $0 == randomName }
        }
    }
}

#Preview {
    ContentView()
}
