//
//  AppViews Group
//  PhotoView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 

/*
 Abstract:
 
 The view that allows the user to photograph a plant, date and store the photo, and send it to Anthropic Claude AI for analysis

 References:
 
 https://developer.apple.com/tutorials/Sample-Apps
 
 */

import SwiftUI

struct PhotoView: View {
    var body: some View {
        
        Image(systemName: "camera")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Text("Take a Plant Checkup Photo!")
    }
}

#Preview {
    PhotoView()
}
