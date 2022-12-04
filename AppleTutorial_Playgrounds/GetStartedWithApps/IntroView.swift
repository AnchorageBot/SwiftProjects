import SwiftUI

struct Introview: View {
    var body: some View {
        Image("FriendAndGem")
            .resizable()
            .scaledToFit()
        Text("Welcome")
        Text("We are learning how to add text, images, and views to an app")
        Text("Our team consists of:")
       // HStack { 
          //  Text("I’m a view inside a view.")
           // Image("Blu")
             //   .resizable()
             //   .scaledToFit()
            
      //  }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            IntroView()
        }
    }
}
