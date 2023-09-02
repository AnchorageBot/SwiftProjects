/*

 ContentView.swift
 LearnSwiftUI

 Created on 8/31/23, updated on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1

 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 Xcode->File->New Project -> iOS - App

 In SwiftUI, a scene contains the view hierarchy that an app displays as its user interface. A view hierarchy defines
   the layout of views relative to other views.

*/

import SwiftUI

// ContentView is a structure that conforms to the View protocol

// A view defines one or more visual elements that appear somewhere on a screen. A view is typically made up of other views, creating a view hierarchy.

struct ContentView: View {

    // returns the contents of your app described as a Scene
    var body: some View {
        
        // Root node of the view hierarchy
        TabView {
            
        }
    }
}
