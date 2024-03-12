//
//  ContentView.swift
//  WxCoreLocate_V1
//
//  Created by ATS on 3/11/24
//

/*
 
 Abstract:
 
 References:
 
 */


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, weather!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
