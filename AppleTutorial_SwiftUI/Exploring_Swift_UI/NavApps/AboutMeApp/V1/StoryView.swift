/*

 StoryView.swift
 Explore_SwiftUI_V1

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0
 Updated on 9/28/2023

*/


import SwiftUI

struct StoryView: View {

    var body: some View {

        VStack {

            Text("My Story")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                Text(information.story)
                    .font(.body)
                    .padding()
            }
        }

        .padding([.top, .bottom], 50)
        .preferredColorScheme(.dark)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
