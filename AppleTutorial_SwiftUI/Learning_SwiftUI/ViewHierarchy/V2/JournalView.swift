/*

 JournalView.swift
 LearnSwiftUI

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 Created on 9/2/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI

struct JournalView: View {
    var body: some View {
        VStack {
            Text("Journal")
                .font(.title)
                .padding()
            
            Text("Sun 22")

            Text("Had a wonderful time at the country fair")
                .padding()

            Text("Thu 19")
                .padding()

            Text("Spent the afternoon at the farmer's market. The food was delicious and I ...")
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
