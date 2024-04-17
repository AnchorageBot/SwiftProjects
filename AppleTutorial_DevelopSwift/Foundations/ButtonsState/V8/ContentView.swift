//
//  ContentView.swift
//  DiceView
//
//  Created by Claude and ATS on 4/16/24
//  Xcode version 15.3
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
*/

import SwiftUI

struct ContentView: View {
    // Always mark state properties private so other views can't interfere with their value
    // Property representing the number of dice pips
    @State private var numberOfDice: Int = 2
    
    var body: some View {
        TabView {
            DiceRollView(numberOfDice: $numberOfDice)
                .tabItem {
                    Label("Dice Roll", systemImage: "die.face.6")
                }
            
            NormalDistributionView()
                .tabItem {
                    Label("Normal Distribution", systemImage: "chart.bar")
                }
        }
    }
}

#Preview {
    ContentView()
}
