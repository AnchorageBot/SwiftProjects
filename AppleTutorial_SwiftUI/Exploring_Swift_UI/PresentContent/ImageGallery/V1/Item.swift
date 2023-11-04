/*

 Item.swift
 Explore_SwiftUI_V7

 How to create this file with Xcode commands:

   * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/Swift/Identifiable

 https://developer.apple.com/documentation/foundation/url

 https://developer.apple.com/documentation/foundation/uuid

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/

 Created on 11/2/2023 and updated on 11/4/2023 with Swift 5.9, Xcode 15.0

 Models a grid item’s data and adds Identifiable conformance

*/

import SwiftUI


/*

 When you use ForEach to construct a collection view, such as a list or grid, SwiftUI wants to uniquely identify each view
 so it can find and update them. To make this easier, you can create a model that conforms to Identifiable, which creates an
 id property requirement.

 */

struct Item: Identifiable {

    // id property that SwiftUI uses to uniquely identify the view
    let id = UUID()

    // url property that the app uses to identify the location of the corresponding image using a path to the file
    let url: URL


}


extension Item: Equatable {

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
