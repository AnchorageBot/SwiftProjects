//
//  ContentView.swift
//  ChatPrototype
//
//  Created by ATS on 4/4/24
//  Made with 15.3
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {

            Text("Knock, knock")
                .padding()
                .background(Color.yellow, in: RoundedRectangle(cornerRadius: 8))
                    .padding()
            
            Text("Who's there?")
                .padding()
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                    .padding()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
