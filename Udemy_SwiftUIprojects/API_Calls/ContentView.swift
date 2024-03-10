//
//  Group Main
//  ContentView.swift
//  CoffeeOrderAPI
//
//  Created by ATS on 3/8/24
//

/*
 Abstract:
 
 Reference:
 Livestream - Learn how to make an API call in SwiftUI - azamsharp - YouTube
 
 */

import SwiftUI

struct ContentView: View {
    
    let coffeeClient = CoffeeClient()
    
    @State private var orders: [Order] = []
    
    var body: some View {
        VStack {
            Image(systemName: "mug")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, coffee!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
