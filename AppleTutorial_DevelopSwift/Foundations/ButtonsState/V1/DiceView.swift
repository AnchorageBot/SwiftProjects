//
//  DiceView.swift
//  DiceView
//
//  Created by ATS on 4/14/24
//  Xcode version 15.3
//
//  Section 1 of the tutorial
//

/*
 
 Abstract:

 This code represents the app's dice face view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.
 References:
 - Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
 
 */

import SwiftUI

struct DiceView: View {
    
    /// property representing the number of dice pips
    var numberOfPips: Int = 5
    
    var body: some View {
        
        Image(systemName: "die.face.\(numberOfPips)")
            /// SwiftUI command to strech image to fill available space
            .resizable()
            /// SwiftUI command to allocate space for the image
            .frame(width: 80, height: 80)
    }
}

#Preview {
    DiceView()
}
