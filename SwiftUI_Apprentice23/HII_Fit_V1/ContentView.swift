//
//  ContentView.swift
//  HII_Fit App
//
//  Created on 8/19/23
//
//  Command N -> Swift UI
//
//  Used to define the app's organization
//

import SwiftUI

// struct = named data type with properties and methods
// name of the first structure matches the name of the file

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Welcome")
                .tabItem { Text("Welcome") }
            Text("Exercise 1")
                .tabItem { Text("Exercise 1") }
            Text("Exercise 2")
                .tabItem { Text("Exercise 2") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
