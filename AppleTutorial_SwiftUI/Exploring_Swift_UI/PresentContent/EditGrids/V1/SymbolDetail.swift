/*

 SymbolDetail.swift
 Explore_SwiftUI_V6

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/editinggrids

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/image

 https://developer.apple.com/documentation/symbols

 https://developer.apple.com/sf-symbols/

 Created on 10/19/2023 and updated on 10/21/2023 with Swift 5.9, Xcode 15.0

 Creates an image view using a SF Symbol

*/

import SwiftUI


struct SymbolDetail: View {

    var symbol: Symbol


    var body: some View {

        VStack {

            Text(symbol.name)
                .font(.system(.largeTitle, design: .rounded))

            Image(systemName: symbol.name)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.accentColor)
                .symbolEffect(.pulse)
                //.symbolEffect(.pulse, options: .repeat(3))
                .symbolEffect(.variableColor.reversing)

        }
        .padding()
    }
}


/*

Xcode default code snippet, pre October 2023

This works; uncomment it and comment out the #Preview code below if you want to use this code snippet

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(symbol: Symbol(name: "star"))
    }
}

*/


/*

Xcode default code snippet, post October 2023

This works; uncomment it and comment out the struct code above if you want to use this code snippet

#Preview {
    SymbolDetail(symbol: Symbol(name: "star"))
}

*/


 /*

 Comment out both of these code snippets and the Xcode simulator boots up much faster

*/
