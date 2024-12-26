//
// SockDrawer
// AboutView.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About This App")
                .font(.title)
                .padding()
            Text("This app demonstrates solving a probability puzzle using Diophantine equations.")
                .padding(.bottom)
            Text("The problem involves finding the smallest number of socks in a drawer such that the probability of drawing two red socks is 1/2.")
                .padding(.horizontal)
            Spacer()
        }
    }
}
