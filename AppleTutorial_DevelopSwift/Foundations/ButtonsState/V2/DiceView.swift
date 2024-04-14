//
//  DiceView.swift
//  DiceView
//
//  Created by ATS on 4/14/24
//  Xcode version 15.3
//
//  Sections 2 and 3 of the tutorial
//

/*
 
 Abstract:

 This code represents the app's dice face view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.
 References:
 - Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
 
 */

import SwiftUI

struct DiceView: View {
    
    /// always mark state properties private so other views can’t interfere with their value
    /// property representing the number of dice pips
    @State private var numberOfPips: Int = 5
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "die.face.\(numberOfPips)")
            /// SwiftUI command to strech image to fill available space
                .resizable()
            /// SwiftUI command to allocate space for the image
            .frame(width: 80, height: 80)
            
            Button("Roll") {
                /// Int.random selects a random integer from the range inside its parentheses
                /// updates the value of numberOfPips every time the code runs
                numberOfPips = Int.random(in: 1...6)
            }
        }
    }
}

#Preview {
    DiceView()
}
