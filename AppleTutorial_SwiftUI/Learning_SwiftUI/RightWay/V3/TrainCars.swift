/*
 Copyright © 2022 Apple Inc.

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import SwiftUI
struct TrainCars: View {
    @State private var longerTrain = true
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Toggle("Long Train", isOn: $longerTrain)
                Text("Conditional:")
                HStack {
                    Image(systemName: "train.side.rear.car")
                    if longerTrain {
                        Image(systemName: "train.side.middle.car")
                    }
                    Image(systemName: "train.side.front.car")
                }
                Divider()
                Text("Opacity:")
                HStack {
                    Image(systemName: "train.side.rear.car")
                    Image(systemName: "train.side.middle.car")
                        .opacity(longerTrain ? 1 : 0)
                    Image(systemName: "train.side.front.car")
                }
                Divider()
            }
            .padding()
            Spacer()
        }
    }
}

struct TrainCars_Previews: PreviewProvider {
    static var previews: some View {
        TrainCars()
            .frame(width: 350)
    }
}
