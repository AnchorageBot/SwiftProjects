/*

 TrainCar.swift
 LearnSwiftUI_V5

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/adjusting-the-space-between-views

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/15/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

enum TrainSymbol: String {
    case front = "train.side.front.car"
    case middle = "train.side.middle.car"
    case rear = "train.side.rear.car"
}

struct TrainCar: View {

    let position: TrainSymbol
    let showFrame: Bool

    init(_ position: TrainSymbol, showFrame: Bool = true) {
        self.position = position
        self.showFrame = showFrame
    }

    var body: some View {
        Image(systemName: position.rawValue)
            .background(Color("customPink"))
    }
}

struct TrainTrack: View {
    var body: some View {
        Divider()
            .frame(maxWidth: 200)
    }
}

struct TrainCar_Previews: PreviewProvider {
    static var previews: some View {
        TrainCar(.front)
    }
}
