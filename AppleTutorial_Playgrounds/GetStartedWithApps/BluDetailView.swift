import SwiftUI

struct BluDetailView: View {
    var body: some View {
        VStack {
            HStack { 
                Image("Blu") 
                    .resizable()
                    .scaledToFit()
                VStack{
                    Text("Blu")
                        .font(.largeTitle)
                    Text("Space Coder")
                        .font(.caption)
                }
            }
            //#-learning-task(addTextInVStack)
        }
    }
}

struct BluDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BluDetailView()
        }
    }
}
