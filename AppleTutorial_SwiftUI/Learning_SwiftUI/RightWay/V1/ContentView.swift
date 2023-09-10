/*

 LearnSwiftUI_V3App.swift
 LearnSwiftUI_V3

 How to create this file with Xcode commands:
 Xcode -> File -> New Project -> iOS - App

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/choosing-the-right-way-to-hide-a-view

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/10/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct ContentView: View {
  
    var body: some View {
      
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
