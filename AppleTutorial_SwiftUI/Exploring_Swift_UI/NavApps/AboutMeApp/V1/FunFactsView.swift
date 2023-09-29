/*

 FunFactsView.swift
 Explore_SwiftUI_V1

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0
 Updated on 9/28/2023

*/

import SwiftUI

struct FunFactsView: View {

    @State private var funFact = ""

    var body: some View {

        VStack {

            Text("Fun Facts")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(funFact)
                .padding()
                .font(.title)
                .frame(minHeight: 400)

            Button("Show Random Fact") {
                funFact = information.funFacts.randomElement()!
            }
        }

        .padding()
        .preferredColorScheme(.dark)
    }
}

struct FunFactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunFactsView()
    }
}
