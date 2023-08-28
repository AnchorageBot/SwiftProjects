/* 
 
 state.swift

 Swift Playgrounds 4.3.1, Swift 5.8, iOS 16

 8/27/2023

 Ref: Swift UI for Masterminds, 3rd Edition - iOS 16 - J.D. Gauchat - 2022

Property wrappers allow us to define properties that can perform tasks with the values
assigned to them. 
 
SwiftUI implements property wrappers extensively to store values and report the changes
to the views. The one designed to store the states of a single view is called @State. 

This property wrapper stores a value in a structure of type State and notifies the system when
that value changes, so the views are automatically updated to reflect the change on the screen.
 
 */

import SwiftUI


struct ContentView: View { 
    @State private var title: String = "Default Title"
    
     var body: some View {
      VStack { 
        Text(title)
        .padding(10)
        
        Button(action: { title = "My New Title"
            
        },label: { 
        
        Text("Change Title")
            
        })
      Spacer()
      
      }.padding() 
   }
}
