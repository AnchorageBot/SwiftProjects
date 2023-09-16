/*

 PaddingContainer.swift
 LearnSwiftUI_V5

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/adjusting-the-space-between-views

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/Image

 Created on 9/16/2023
 Made with Swift 5.8, Xcode 14.3.1

 TrainCar() is a structure that is defined in the TrainCar.swift file
 TrainTrack() is a structure that is defined in the TrainCar.swift file

*/

import SwiftUI

struct PaddingContainer: View {

    var body: some View {
        
        Text("Padding the Container Example")

        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
            TrainCar(.front)
        }
        .padding()
        // given in the tutorial, but not working
        //.background(Color("customBlue"))
        // this works
        .background(Color(.green))

    TrainTrack()

    }

}

struct PaddingContainer_Previews: PreviewProvider {

    static var previews: some View {

        VStack {
            PaddingContainer()
        }
    }
}
