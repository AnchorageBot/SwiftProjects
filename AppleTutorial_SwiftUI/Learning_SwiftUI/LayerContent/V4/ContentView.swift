/*

 ContentView.swift
 LearnSwiftUI_V2

 How to create this file with Xcode commands:
 Xcode->File->New Project -> iOS - App

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/layering-content

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/7/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct ContentView: View {
    var body: some View {
            CaptionedPhoto(assetName: "Image", captionText: "A cluster of Daisys")
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
