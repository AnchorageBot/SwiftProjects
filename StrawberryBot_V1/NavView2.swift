//
//  Drafts Group
//  NavView2.swift
//  StrawberryBot_V1
//
//  Created by Claude and ATS on 3/7/24
//  Placeholder for tracking draft code

import SwiftUI

struct NavView2: View {
    @State private var isShowingContentView = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                

                            
                NavigationLink(destination: ContentView(), isActive: $isShowingContentView) {
                    Button {
                        isShowingContentView = true
                    } label: {
                        Image(systemName: "house.circle.fill")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    NavView2()
}
