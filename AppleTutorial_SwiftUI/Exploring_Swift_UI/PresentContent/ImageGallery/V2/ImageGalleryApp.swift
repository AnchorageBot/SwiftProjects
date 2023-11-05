/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

@main
struct ImageGalleryApp: App {
    @StateObject var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GridView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
