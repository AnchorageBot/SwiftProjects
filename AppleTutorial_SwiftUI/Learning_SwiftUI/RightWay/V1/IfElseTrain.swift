/*

 IfElseTrain.swift
 LearnSwiftUI_V3

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/choosing-the-right-way-to-hide-a-view

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/10/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct IfElseTrain: View {

    var longerTrain: Bool

    var body: some View {
        
        VStack {
            HStack {

                Image(systemName: "train.side.rear.car")
                
                if longerTrain {
                    Image(systemName: "train.side.middle.car")
                }
                Image(systemName: "train.side.front.car")
            }
            Divider()
        }

    }
}

struct IfElseTrain_Previews: PreviewProvider {

    static var previews: some View {

        IfElseTrain(longerTrain: true)
        IfElseTrain(longerTrain: false)

    }
}
