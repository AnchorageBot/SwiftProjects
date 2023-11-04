/*

 Item.swift
 Explore_SwiftUI_V7

 How to create a Swift file with keyboard and Xcode commands:

 Command Key (Splat) N -> Swift File

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/combine/published

 https://developer.apple.com/documentation/appkit/nsmenu/1518176-additem

 https://developer.apple.com/documentation/foundation/url

 Created on 11/2/2023 with Swift 5.9, Xcode 15.0

 How your app uses a data model to load and store all photo data

*/

import Foundation

/*  

    DataModel is an observable object that gathers file URLs from images in your document directory as well as from your bundle resources.

    It uses these URLs to populate an array of Item instances which display as the content of your grid.

    DataModel publishes an array of item values, each of which correlates to an image in the grid

 */

class DataModel: ObservableObject {

    @Published var items: [Item] = []

    init() {

        /*

         When you initialize DataModel, it searches the document directory for any images you’ve added, gathering their corresponding URLs
         and appending them to the items array.

         Your app stores data locally in this directory, so searching here allows you to display any images you added while using the app

         */


        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            for url in urls {
                let item = Item(url: url)
                items.append(item)

            }
        }

        /*

         Similarly, you’ll load all image URLs from the bundle resources directory and add them to items. Bundle resources is the directory
         of images that are included with the project, as opposed to images that you added yourself

         */

        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }

    /// Adds an item to the data collection.
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }

    /// Removes an item from the data collection.
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
        }
    }
}


extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}
