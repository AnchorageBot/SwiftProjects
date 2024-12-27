//
// SockDrawer
// SockDataInputView.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import SwiftUI

struct SockDataInputView: View {
    var body: some View {
        VStack {
            Text("The Sock Drawer Problem")
                .font(.title)
                .padding()
            Text("This app solves the following problem:")
                .padding(.bottom)
            Text("A sock drawer contains an unknown number of red and black socks. If the probability of drawing two red socks is 1/2, what is the smallest number of socks in the drawer?")
                .padding(.horizontal)
            Spacer()
        }
    }
}
