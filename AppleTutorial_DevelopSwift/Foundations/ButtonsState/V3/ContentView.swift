//
//  ContentView.swift
//  DiceView
//
//  Created by ATS on 4/14/24
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
    
    var body: some View {
        
        HStack {
            
            DiceView()
            DiceView()
            DiceView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
