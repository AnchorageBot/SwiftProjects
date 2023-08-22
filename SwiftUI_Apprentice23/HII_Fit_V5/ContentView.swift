//
//  ContentView.swift
//  HII_Fit App
//
//  Created on 8/19/23, updated 8/20/2023
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift UI
//
//  Used to define the app's organization

import SwiftUI

/*
 struct = named data type with properties and methods

 name of the first structure matches the name of the file
*/

struct ContentView: View {
    var body: some View {
        TabView {

            WelcomeView()

            ForEach(Exercise.exercises.indices, id: \.self) { number in
                ExerciseView(index: number)
            }
        }
        
        // swiping with dots
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(
            PageIndexViewStyle(backgroundDisplayMode: .always))

        // swiping without dots
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
