import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .background(Color.red)
                .cornerRadius(10, antialiased: true)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Image(systemName: "cloud")
                .imageScale(.large)
                .background(Color.green)
                .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Image(systemName: "snowflake")
                .imageScale(.large)
                .background(Color.blue)
                .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}
