import SwiftUI

struct ConditionalViews: View {
    @State var isOn = true
    
    var body: some View {
        VStack {
            if isOn {
                Circle()
                    .frame(maxHeight: 200)
                    .foregroundColor(.green)
                Text("On")
            }
            
            else {
                Circle()
                    .frame(maxHeight: 200)
                    .foregroundColor(.red)
                Text("Off")
            }
        
            Button("Press Me") {
                isOn.toggle()
            }
        }
    }
}

struct ConditionalViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ConditionalViews()
        }
    }
}
