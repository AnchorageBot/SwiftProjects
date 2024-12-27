//
// SockDrawer
// DiophantineExplanationView.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import SwiftUI

struct DiophantineExplanationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Diophantine Equations and the Sock Drawer Problem")
                    .font(.title2)
                    .padding(.bottom)

                Text("Diophantine equations are polynomial equations where we seek integer solutions. In our sock problem, we derived the equation:")
                Text("2R(R - 1) = T(T - 1)")
                    .italic()
                    .padding(.leading)

                Text("Where:")
                Text("R = Number of red socks").padding(.leading)
                Text("T = Total number of socks").padding(.leading)

                Text("This equation arises from the probability condition: (R/T) * ((R-1)/(T-1)) = 1/2. Because we're dealing with whole numbers of socks, this becomes a Diophantine equation.")

                Text("We solve it by testing integer values until we find a match. The smallest non-trivial solution is T=4 and R=3.")

                Spacer()
            }
            .padding()
        }
    }
}
