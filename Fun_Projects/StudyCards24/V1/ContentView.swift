//
// StudyCardsV1
// ContentView.swift
//
// Created on 9/8/24
// Swift Version 5.0
//
// ATS Project
// Tutor Anthropic's AI Claude
//

import SwiftUI

struct ContentView: View {
    @State private var isFlipped = false
    
    var body: some View {
        VStack {
            Text("Math Study Card")
                .font(.largeTitle)
                .padding()
            
            ZStack {
                CardFront(isFlipped: $isFlipped)
                    .opacity(isFlipped ? 0 : 1)
                    .rotation3DEffect(
                        .degrees(isFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                CardBack(isFlipped: $isFlipped)
                    .opacity(isFlipped ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(isFlipped ? 0 : -180),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            .animation(.default, value: isFlipped)
            .onTapGesture {
                isFlipped.toggle()
            }
        }
    }
}

struct CardFront: View {
    @Binding var isFlipped: Bool
    
    var body: some View {
        VStack {
            Text("Ordinary Differential Equation")
                .font(.title2)
                .padding()
            
            Text("dy/dx = f(x, y)")
                .font(.system(size: 24, weight: .bold, design: .serif))
                .padding()
            
            Text("Tap to flip")
                .font(.caption)
                .padding()
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CardBack: View {
    @Binding var isFlipped: Bool
    
    var body: some View {
        VStack {
            Text("Definition:")
                .font(.title2)
                .padding(.bottom, 5)
            
            Text("An equation involving an unknown function and its derivatives with respect to a single independent variable.")
                .font(.body)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Text("Tap to flip")
                .font(.caption)
                .padding()
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
