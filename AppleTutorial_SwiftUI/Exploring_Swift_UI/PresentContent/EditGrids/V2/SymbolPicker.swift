/*

 SymbolPicker.swift
 Explore_SwiftUI_V6

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/editinggrids

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/state

 https://developer.apple.com/documentation/swiftui/environment

 https://developer.apple.com/documentation/swiftui/binding

 https://developer.apple.com/documentation/swiftui/image

 https://developer.apple.com/documentation/symbols

 https://developer.apple.com/sf-symbols/

 https://developer.apple.com/documentation/SwiftUI/LazyVGrid

 https://developer.apple.com/documentation/SwiftUI/ScrollView

 Created on 10/23/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct SymbolPicker: View {

    @Environment(\.presentationMode) var presentationMode
    @Binding var symbol: Symbol?

    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    let pickableSymbols = [
        Symbol(name: "tshirt"),
        Symbol(name: "eyes"),
        Symbol(name: "eyebrow"),
        Symbol(name: "nose"),
        Symbol(name: "mustache"),
        Symbol(name: "mouth"),
        Symbol(name: "eyeglasses"),
        Symbol(name: "facemask"),
        Symbol(name: "brain.head.profile"),
        Symbol(name: "brain"),
        Symbol(name: "icloud"),
        Symbol(name: "theatermasks.fill"),
        Symbol(name: "house.fill"),
        Symbol(name: "sun.max.fill"),
        Symbol(name: "cloud.rain.fill"),
        Symbol(name: "pawprint.fill"),
        Symbol(name: "lungs.fill"),
        Symbol(name: "face.smiling"),
        Symbol(name: "gear"),
        Symbol(name: "allergens"),
        Symbol(name: "bolt.heart"),
        Symbol(name: "ladybug.fill"),
        Symbol(name: "bus.fill"),
        Symbol(name: "bicycle.circle"),
        Symbol(name: "faceid"),
        Symbol(name: "gamecontroller.fill"),
        Symbol(name: "timer"),
        Symbol(name: "eye.fill"),
        Symbol(name: "person.icloud"),
        Symbol(name: "tortoise.fill"),
        Symbol(name: "hare.fill"),
        Symbol(name: "leaf.fill"),
        Symbol(name: "wand.and.stars"),
        Symbol(name:"globe.americas.fill"),
        Symbol(name: "globe.europe.africa.fill"),
        Symbol(name: "globe.asia.australia.fill"),
        Symbol(name: "hands.sparkles.fill"),
        Symbol(name: "hand.draw.fill"),
        Symbol(name: "waveform.path.ecg.rectangle.fill"),
        Symbol(name: "gyroscope"),

    ]

    var body: some View {

        ScrollView {

            LazyVGrid(columns: columns) {
                
                ForEach(pickableSymbols) { symbol in
                    Button {
                        self.symbol = symbol
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: symbol.name)
                            .resizable()
                            .scaledToFit()
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.accentColor)
                            .ignoresSafeArea(.container, edges: .bottom)
                    }
                    .padding()
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

/*

 Xcode default code snippet, pre October 2023

 This works; uncomment it and comment out the #Preview code below if you want to use this code snippet
 
struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(symbol: .constant(nil))
    }
}
*/


/*

Xcode default code snippet, post October 2023

This works; uncomment it and comment out the struct code above if you want to use this code snippet

#Preview {
    //SymbolPicker()
    SymbolPicker(symbol: .constant(nil))
}
*/

/*

Comment out both of these two code snippets and the Xcode simulator boots up much faster

*/
