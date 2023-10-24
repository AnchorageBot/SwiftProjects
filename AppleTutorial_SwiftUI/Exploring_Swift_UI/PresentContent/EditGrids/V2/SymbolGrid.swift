/*

 SymbolGrid.swift
 Explore_SwiftUI_V6

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/editinggrids

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/state

 https://developer.apple.com/documentation/swiftui/image

 https://developer.apple.com/documentation/symbols

 https://developer.apple.com/sf-symbols/

 https://developer.apple.com/documentation/SwiftUI/LazyVGrid

 https://developer.apple.com/documentation/SwiftUI/ScrollView

 Created on 10/23/2023 with Swift 5.9, Xcode 15.0

 Create a grid of SF Symbols from an array of Symbol values

*/

import SwiftUI


struct SymbolGrid: View {


    @State private var isAddingSymbol = false
    @State private var isEditing = false


    private static let initialColumns = 3
    @State private var selectedSymbol: Symbol?
    @State private var numColumns = initialColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)

    @State private var symbols = [
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
    ]

    var columnsText: String {
        numColumns > 1 ? "\(numColumns) Columns" : "1 Column"
    }

var body: some View {

    VStack {

        if isEditing {
            Stepper(columnsText, value: $numColumns, in: 1...6, step: 1) { _ in
                withAnimation { gridColumns = Array(repeating: GridItem(.flexible()), count: numColumns) }
            }
            .padding()
        }


        ScrollView {

            LazyVGrid(columns: gridColumns) {
                
                ForEach(symbols) { symbol in
                    NavigationLink(destination: SymbolDetail(symbol: symbol)) {
                        ZStack(alignment: .topTrailing) {

                            Image(systemName: symbol.name)
                                .resizable()
                                .scaledToFit()
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.accentColor)
                                .ignoresSafeArea(.container, edges: .bottom)
                                .cornerRadius(8)

                            if isEditing {

                                Button {
                                    guard let index = symbols.firstIndex(of: symbol) else { return }
                                    withAnimation {
                                        _ = symbols.remove(at: index)
                                    }
                                    
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                                .font(.title)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, Color.red)
                                }
                                .offset(x: 7, y: -7)
                            }
                        }
                        .padding()
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    .navigationTitle("My Symbols")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $isAddingSymbol, onDismiss: addSymbol) {
        SymbolPicker(symbol: $selectedSymbol)
    }
    .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(isEditing ? "Done" : "Edit") {
                withAnimation { isEditing.toggle() }
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                isAddingSymbol = true
            } label: {
                Image(systemName: "plus")
            }
            .disabled(isEditing)
        }
    }


}

func addSymbol() {
    guard let name = selectedSymbol else { return }
    withAnimation {
        symbols.insert(name, at: 0)
    }
}
}

/*

 Xcode default code snippet, pre October 2023

 This works; uncomment it and comment out the #Preview code below if you want to use this code snippet
 
struct GridView_Previews: PreviewProvider {
static var previews: some View {
    SymbolGrid()
    }
}
*/



/*

Xcode default code snippet, post October 2023

This works; uncomment it and comment out the struct code above if you want to use this code snippet

#Preview {
    SymbolGrid()
}
*/

/*

Comment out both of these two code snippets and the Xcode simulator boots up much faster

*/
