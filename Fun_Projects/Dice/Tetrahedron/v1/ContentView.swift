//
// Tetrahedron_v1
// ContentView.swift
//
// Created on 5/1/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

struct ContentView: View {
    @State private var diceResult = 1
    @State private var isRolling = false
    @State private var rotationDegrees = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Tetrahedron Dice")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            ZStack {
                // Tetrahedron shape
                TetrahedronView(result: diceResult)
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(
                        .degrees(rotationDegrees),
                        axis: (x: Double.random(in: 0...1),
                               y: Double.random(in: 0...1),
                               z: Double.random(in: 0...1))
                    )
            }
            .padding(40)
            
            Text("Result: \(diceResult)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            Spacer()
            
            Button(action: rollDice) {
                Text("Roll Dice")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(isRolling ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .disabled(isRolling)
            .padding(.bottom, 50)
        }
        .padding()
    }
    
    func rollDice() {
        guard !isRolling else { return }
        
        isRolling = true
        
        // Animate the rotation
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            rotationDegrees += 720.0 // Two full rotations
        }
        
        // Simulate dice roll with multiple changes
        let rollDuration = 1.0
        let changeInterval = 0.1
        var timeElapsed = 0.0
        
        Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
            timeElapsed += changeInterval
            self.diceResult = Int.random(in: 1...4)
            
            if timeElapsed >= rollDuration {
                timer.invalidate()
                
                // Final random result
                self.diceResult = Int.random(in: 1...4)
                self.isRolling = false
            }
        }
    }
}

struct TetrahedronView: View {
    let result: Int
    
    var body: some View {
        ZStack {
            // Simple 3D-like tetrahedron representation
            Path { path in
                // Create a triangle shape
                path.move(to: CGPoint(x: 100, y: 20))
                path.addLine(to: CGPoint(x: 180, y: 150))
                path.addLine(to: CGPoint(x: 20, y: 150))
                path.closeSubpath()
            }
            .fill(LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.7), .purple.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            ))
            
            // Display the result on the front face
            Text("\(result)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .position(x: 100, y: 90)
                .shadow(color: .black, radius: 1)
        }
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
