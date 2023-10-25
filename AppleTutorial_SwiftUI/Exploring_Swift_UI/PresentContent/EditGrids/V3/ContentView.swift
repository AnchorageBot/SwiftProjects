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

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 Created on 10/18/2023 and updated on 10/24/2023 with Swift 5.9, Xcode 15.0

 Creates an image view using an SF Symbol

*/

import SwiftUI

struct ContentView: View {

    var body: some View {

        VStack {

            /* Option One */

            //SymbolDetail(symbol: Symbol(name: "star"))

            //SymbolDetail(symbol: Symbol(name: "brain"))

            //SymbolDetail(symbol: Symbol(name: "bicycle"))

            //SymbolDetail(symbol: Symbol(name: "map"))


            /* Option Two */

            SymbolGrid()


            /* Option Three */

            //SymbolPicker(symbol: .constant(nil))



            /* Option Four */

            //SymbolDetail(symbol: Symbol(name: "star"))
            //SymbolGrid()
            //SymbolPicker(symbol: .constant(nil))

        }
        .padding()
    }
}

#Preview {

    ContentView()
}
