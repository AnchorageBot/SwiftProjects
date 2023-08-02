//
//  CircleImage.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 7/30/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->File->SwiftUI View
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
