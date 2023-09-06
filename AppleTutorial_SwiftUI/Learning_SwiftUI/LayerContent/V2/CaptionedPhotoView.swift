/*

 CaptionedPhotoView.swift
 LearnSwiftUI

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/5/2023
 Made with Swift 5.8, Xcode 14.3.1


*/

import SwiftUI

struct CaptionedPhotoView: View {

    let assetName: String
    let captionText: String

    var body: some View {
        Image(assetName)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                Caption(text: captionText)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}

struct Caption: View {

    let text: String

    var body: some View {
        Text(text)
            .padding()
            .background(Color("TextContrast").opacity(0.75),
                        in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}

// hacked & fused from landmarks app
struct CircleImage: View {
    var body: some View {
        Image("Image")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CaptionedPhotoView_Previews: PreviewProvider {

    static let landscapeName = "Landscape.jpeg"
    static let landscapeCaption = "This photo is wider than it is tall"
    static let portraitName = "Portrait.jpeg"
    static let portraitCaption = "This photo is taller than it is wide"

    static var previews: some View {
        CaptionedPhotoView(assetName: portraitName,
                            captionText: portraitCaption)
        .preferredColorScheme(.dark)
        CaptionedPhotoView(assetName: landscapeName,
                           captionText: landscapeCaption)
        .preferredColorScheme(.dark)

//        CaptionedPhotoView(assetName: landscapeName,
//                            captionText: landscapeCaption)
//        .preferredColorScheme(.light)


      // hacked & fused from landmarks app
      CircleImage()
    }
}
