/*

 GridItemView.swift
 Explore_SwiftUI_V7

 How to create this file with Xcode commands:

   * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/zstack

 https://developer.apple.com/documentation/swiftui/asyncimage

 https://developer.apple.com/documentation/swiftui/progressview

 https://developer.apple.com/documentation/swiftui/previews-in-xcode

 Created on 11/2/2023 and updated on 11/5/2023 with Swift 5.9, Xcode 15.0

 Loads an image asynchronously from a URL using AsyncImage

*/

import SwiftUI

/*

 GridItemView represents a single item of your grid, an image view that displays the photo defined by an Item instance.

 */

struct GridItemView: View {

    /*

     A GridItemView contains properties for item and size. The item property provides the URL to asynchronously load the image, while the size property provides the value for the height and width of the image and its placeholder.

     */

    let size: Double
    let item: Item


    var body: some View {

        /*

         In the body of your GridItemView, you’ll create your image view. Since you’ll have a conditional editing UI overlaid on top of your image, wrap the image in a ZStack.

         */

        ZStack(alignment: .topTrailing) {

            /*

             You can initialize an AsyncImage with the item.url value to load the image asynchronously. Because you have many images to load when the app first launches, you can load them asynchronously to allow the app to keep running the rest of its code while it waits for the images to return. This prevents any noticable lag in your UI.

             */

            AsyncImage(url: item.url) { image in

                /*

                 AsyncImage contains a content closure that provides an instance of a SwiftUI Image. You’ll use this instance to create your image view. You’ll add the .resizable and .scaledToFill modifiers to scale the image to fill the available space of the view.

                 */

                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {

                /*

                 AsyncImage uses a placeholder to show some content while the image loads. This placeholder uses a SwiftUI ProgressView which displays as a spinning circle.

                 */

                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}


struct GridItemView_Previews: PreviewProvider {

    static var previews: some View {

        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            GridItemView(size: 50, item: Item(url: url))
        }
    }
}


/*
#Preview {

    GridItemView(size: 50, item: Item(url: url))

}
*/
