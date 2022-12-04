import SwiftUI

struct HopperDetailView: View {
    var body: some View {
        VStack {
            HStack { 
                Image("Hopper") 
                    .resizable()
                    .scaledToFit()
                VStack{
                    Text("Hopper")
                        .font(.largeTitle)
                    Text("Interplanetary Coder")
                        .font(.caption)
                }
            }
        }
    }
}

struct HopperDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HopperDetailView() 
        }
    }
}
