/*

 ContentView.swift
 LearnSwiftUI_V5

 How to create this file with Xcode commands:
 Xcode -> File -> New Project -> iOS - App

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/adjusting-the-space-between-views

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/15/2023, updated on 9/16/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct ContentView: View {

    var body: some View {

//        TrainCar(.front)
//            .frame(width: 350)
//            .preferredColorScheme(.dark)

//        Train_Cars()
//            .preferredColorScheme(.dark)

//        DefaultSpacing()
//            .preferredColorScheme(.dark)

//        SpecificSpacing()
//            .preferredColorScheme(.dark)

//        ScaledSpacing()
//            .preferredColorScheme(.dark)

//        ZeroSpacing()
//            .preferredColorScheme(.dark)

//        DefaultPadding()
//            .preferredColorScheme(.dark)

//        PaddingSomeEdges()
//            .preferredColorScheme(.dark)

//        SpecificPadding()
//            .preferredColorScheme(.dark)

//        PaddingContainer()
//            .preferredColorScheme(.dark)

//        AddingSpacer()
//            .preferredColorScheme(.dark)

//        AddPlaceholder()
//            .preferredColorScheme(.dark)

        StackPlaceholder()
            .preferredColorScheme(.dark)

    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {

        VStack {
            
            ContentView()
        }
    }
}
