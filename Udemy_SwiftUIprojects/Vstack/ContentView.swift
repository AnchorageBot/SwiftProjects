//
//  ContentView.swift
//  App_Vstack
//
//  Created by ATS on 2/20/24
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing: 20){
            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
            Rectangle()
                .fill(.yellow)
                .frame(width: 100, height: 100)
            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
        }.frame(minWidth: 150, alignment: .center)
        .padding()
    }
}

#Preview {
    ContentView()
}
