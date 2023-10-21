/*

 ContentView.swift
 Explore_SwiftUI_V6

 How to create this project with Xcode commands:

   * Xcode-> File-> New Project -> iOS - App

 This creates two files

   * ContentView.swift
   * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/editinggrids

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/sf-symbols/

 https://developer.apple.com/sf-symbols/

 Created on 10/18/2023 and updated on 10/20/2023 with Swift 5.9, Xcode 15.0

 Creates an image view using an SF Symbol

*/

import SwiftUI

struct ContentView: View {

    var body: some View {

        VStack {

            SymbolDetail(symbol: Symbol(name: "star"))
            
        }
        .padding()
    }
}

#Preview {

    ContentView()
}
