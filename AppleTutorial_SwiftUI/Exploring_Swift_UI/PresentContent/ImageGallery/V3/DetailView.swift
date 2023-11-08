/*

 DetailView.swift
 Explore_SwiftUI_V7

 How to create this file with Xcode commands:

   * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/asyncimage

 https://developer.apple.com/documentation/foundation/bundle

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Property-Requirements

 https://developer.apple.com/documentation/foundation/bundle

 Created on 11/5/2023 and updated on 11/7/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {

        // A view that asynchronously loads and displays an image
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

/*
struct ImageView_Previews: PreviewProvider {

    // lets you create properties and methods that belong to a type, rather than to instances of a type
    static var previews: some View {

        // The bundle object provides a single interface for locating items, taking into account the bundle structure, user preferences, available localizations, and other relevant factors
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            DetailView(item: Item(url: url))
        }
    }
}
*/

/*
#Preview {
    DetailView()
}
*/
