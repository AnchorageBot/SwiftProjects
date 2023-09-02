/*

 ContentView.swift
 LearnSwiftUI

 How to create this file with Xcode commands:
 Xcode->File->New Project -> iOS - App

 Created on 8/31/23, updated on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1

 Reference:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 ContentView ~ root view

 ContentView is the one view (ring) that controls all the views (rings) - Gandalf, App Dev/Engineer

*/

import SwiftUI

// ContentView is a structure that conforms to the View protocol

struct ContentView: View {

    // returns the contents of your app described as a Scene
    var body: some View {
        
        // Root node of the view hierarchy
        TabView {
            
        }
    }
}
