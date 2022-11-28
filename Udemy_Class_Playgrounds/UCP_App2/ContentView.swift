import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
            Text("Button")
                .padding()
                .background(Color.green)
                .cornerRadius(15)
        }
    }
}
