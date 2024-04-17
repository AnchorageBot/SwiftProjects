//
//  DiceRollView.swift
//  DiceView
//
//  Created by Claude and ATS on 4/16/24
//  Xcode version 15.3
//

/*
Abstract:
This code represents the app's dice roll view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- Update the UI with state https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
*/

import SwiftUI

struct DiceRollView: View {
    // Binding to the numberOfDice property from the parent view
    @Binding var numberOfDice: Int
    
    var body: some View {
        VStack {
            Text("Probability is the very guide of life.")
                .font(.title2)
                .bold()
            
            Text("Marcus Tullius Cicero (106 B.C.E. - 43 B.C.E.)")
            
            HStack {
                // The ForEach view is dynamic; it computes its subviews based on its input, which may change with the state of the app
                ForEach(1...numberOfDice, id: \.self) { _ in
                    DiceView()
                }
                .padding()
            }
            
            VStack {
                Button("More dice", systemImage: "plus.circle.fill") {
                    numberOfDice += 1
                }
                // Limits the number of dice to no more than 3
                .disabled(numberOfDice == 3)
                // Adds a border to the button to set it apart from the image
                .buttonStyle(.bordered)
                .padding()
                
                Button("Less dice", systemImage: "minus.circle.fill") {
                    numberOfDice -= 1
                }
                // Limits the number of dice to no less than 1
                .disabled(numberOfDice == 1)
                // Adds a border to the button to set it apart from the image
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

#Preview {
    DiceRollView(numberOfDice: .constant(2))
}
