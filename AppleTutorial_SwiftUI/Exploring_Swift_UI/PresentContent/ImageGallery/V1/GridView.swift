/*

 GridView.swift
 Explore_SwiftUI_V7

 How to create this file with Xcode commands:

   * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app

 https://developer.apple.com/documentation/swiftui/vstack/

 https://developer.apple.com/documentation/SwiftUI/LazyVGrid

 https://developer.apple.com/documentation/SwiftUI/ScrollView

 https://developer.apple.com/documentation/SwiftUI/ForEach

 https://developer.apple.com/documentation/Swift/Identifiable

 https://developer.apple.com/documentation/SwiftUI/GeometryReader

 https://developer.apple.com/documentation/swiftui/navigationlink

 https://developer.apple.com/documentation/swiftui/previews-in-xcode

 Created on 11/2/2023 and updated on 11/5/2023 with Swift 5.9, Xcode 15.0

 A grid view using a series of SwiftUI built-in and composed views

*/

import SwiftUI

/*

 GridView is where you’ll create your image gallery

 */

struct GridView: View {

    /*

     To access the app’s dataModel, you define an @EnvironmentObject of type DataModel, which gives you access to the environment object passed into the top-level view of the view hierarchy in ImageGalleryApp.swift.

     The data for populating the grid comes from an array of Item instances (found in dataModel.items), each of which references a single image URL.

     */

    @EnvironmentObject var dataModel: DataModel


    private static let initialColumns = 3
    @State private var isAddingPhoto = false
    @State private var isEditing = false


    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns

    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Columns" : "1 Column"
    }

    var body: some View {
        VStack {
            if isEditing {
                ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns)
                .padding()
            }

            /*

             To create the grid, you’ll nest a LazyVGrid inside of a ScrollView, which allows the content of the grid to scroll vertically, if necessary.

             */

            ScrollView {
                LazyVGrid(columns: gridColumns) {

                    /*

                     Your ForEach loop iterates through dataModel.items, and creates a GridItemView based upon each item value in the array. Because each item instance is Identifiable, you don’t need an id parameter when creating your grid views. Instead, SwiftUI uses the id property of each item to uniquely identify it.

                     */

                    ForEach(dataModel.items) { item in

                        /*

                         To provide relative size information of a parent view to its child views, you can use a GeometryReader. This gives you information on the width and height of the parent view depending on how much screen size is available. You can access this information using the closure value and use it to set the size of a size of a child view.

                         */

                        GeometryReader { geo in
                            NavigationLink(destination: DetailView(item: item)) {

                                /*

                                 To simplify the code in GridView, generate each view of the grid using a GridItemView, which handles all of the asynchronous image loading as well as transitions between editing states.

                                 To initialize GridItemView, you pass in the current item from the ForEach loop as well as the width of the parent view provided from GeometryReader. GridItem uses geo.size.width as the value for its height and width, which creates a square-shaped grid item.

                                 */

                                GridItemView(size: geo.size.width, item: item)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button {
                                    withAnimation {
                                        dataModel.removeItem(item)
                                    }
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                                .font(Font.title)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .red)
                                }
                                .offset(x: 7, y: -7)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Image Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPhoto) {
            PhotoPicker()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingPhoto = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }
    }
}

/*
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView().environmentObject(DataModel())
            .previewDevice("iPad (8th generation)")
    }
}
*/


/*
#Preview {
    GridView()
}
*/
