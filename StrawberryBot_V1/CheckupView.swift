//
//  AppViews Group
//  CheckupView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 

/*
 Abstract:
 
 The checkup view shows the most recent analysis of the plant photograph received from AI 
   and allows the user to purchase another analysis
 
 References:
 
 https://developer.apple.com/tutorials/Sample-Apps
 
 */

import SwiftUI

struct CheckupView: View {
    var body: some View {
        
        Image(systemName: "stethoscope")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Text("Plant Checkup Results!")
        
        Image(systemName: "person")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Text("Buy Another Plant Checkup!")
    }
}

#Preview {
    CheckupView()
}
