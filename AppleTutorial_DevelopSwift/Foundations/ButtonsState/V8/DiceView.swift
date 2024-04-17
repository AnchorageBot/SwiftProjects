//
//  DiceView.swift
//  DiceView
//
//  Created by Claude and ATS on 4/16/24
//  Xcode version 15.3
//

/*
Abstract:
This code represents the app's dice face view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
*/

import SwiftUI

struct DiceView: View {
    // Always mark state properties private so other views can't interfere with their value
    // Property representing the number of dice pips
    @State private var numberOfPips: Int = 5
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(numberOfPips)")
                // SwiftUI command to stretch image to fill available space
                .resizable()
                // SwiftUI command to allocate space for the image
                .frame(width: 55, height: 55)
                // A 1:1, or square, aspect ratio has equal width and height. The .fit content mode means that if the image doesn't have the same aspect ratio as the available space, it will shrink to the smaller axis and leave empty space on the other.
                .aspectRatio(1, contentMode: .fit)
            
            Button("Roll") {
                // Makes the transition fade from the old dice image to the new one
                withAnimation {
                    // Int.random selects a random integer from the range inside its parentheses
                    // Updates the value of numberOfPips every time the code runs
                    numberOfPips = Int.random(in: 1...6)
                }
            }
            // Adds a border to the button to set it apart from the image
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    DiceView()
}
