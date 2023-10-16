/*

 ContentView.swift
 Explore_SwiftUI_V5

 How to create this project with Xcode commands:

   * Xcode-> File-> New Project -> iOS - App

 This creates two files

   * ContentView.swift
   * ProjectName_App.swift

 References:

 https://developer.apple.com/tutorials/sample-apps/dateplanner

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview

 https://en.wikipedia.org/wiki/ROYGBIV

 Created on 10/16/2023 and updated on 10/11/2023 with Swift 5.9, Xcode 15.0

 The basics of building and configuring an app with SwiftUI

*/

import SwiftUI


struct ContentView: View {

    let columnLayout = Array(repeating: GridItem(), count: 3)


    @State private var selectedColor = Color.gray


    let allColors: [Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .brown,
        .gray
    ]


    var body: some View {

        VStack {

            Text("Selected Color")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(selectedColor)
                .padding(10)

            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(allColors, id: \.description) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            RoundedRectangle(cornerRadius: 4.0)
                                .aspectRatio(1.0, contentMode: ContentMode.fit)
                                .foregroundColor(color)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(10)
    }
}


/*

Xcode default code, September 2023

This works; uncomment it and comment out the below code if you want to use it

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }
}
*/

/* 

 Xcode default code, October 2023

 This also works; uncomment it and comment out the above code if you want to use it

*/


#Preview {
    ContentView()
}
