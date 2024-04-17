//
//  NormalDistributionView.swift
//  DiceView
//
//  Created by Claude and ATS on 4/16/24
//

/*
Abstract:
This script demonstrates a graphical representation of a normal distribution using SwiftUI. It allows users to adjust the mean, standard deviation, and sample size using sliders. The script also includes an explanation of what a normal distribution represents.

References:
- "Normal Distribution." Wikipedia, Wikimedia Foundation, 15 May 2023, https://en.wikipedia.org/wiki/Normal_distribution.
- "SwiftUI." Apple Developer Documentation, https://developer.apple.com/documentation/swiftui.
*/

import SwiftUI

struct NormalDistributionView: View {
    // Slider values for mean, standard deviation, and sample size
    @State private var meanValue = 0.0
    @State private var stdDevValue = 1.0
    @State private var sampleSizeValue = 1000
    
    // Computed property to generate data points for the normal distribution
    private var data: [CGPoint] {
        let step = 6.0 / Double(sampleSizeValue)
        return stride(from: -3.0, through: 3.0, by: step).map { x in
            let exponent = -pow(x - meanValue, 2) / (2 * pow(stdDevValue, 2))
            let y = exp(exponent) / (stdDevValue * sqrt(2 * .pi))
            return CGPoint(x: x, y: y)
        }
    }
    
    var body: some View {
        VStack {
            // Title text
            Text("Normal Distribution")
                .font(.title)
                .padding()
            
            // Sliders to adjust mean, standard deviation, and sample size
            VStack {
                HStack {
                    Text("Mean:")
                    Slider(value: $meanValue, in: -3.0...3.0)
                }
                HStack {
                    Text("Standard Deviation:")
                    Slider(value: $stdDevValue, in: 0.1...2.0)
                }
                HStack {
                    Text("Sample Size:")
                    Slider(value: Binding(get: { Double(sampleSizeValue) }, set: { sampleSizeValue = Int($0) }), in: 100...5000, step: 100)
                }
            }
            .padding()
            
            // Graphical representation of the normal distribution
            GeometryReader { geometry in
                ZStack {
                    // X-axis
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2))
                    }
                    .stroke(Color.gray, lineWidth: 1)
                    
                    // Y-axis
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
                    }
                    .stroke(Color.gray, lineWidth: 1)
                    
                    // Bell curve
                    Path { path in
                        // Calculate the scale factors for x and y axes
                        let xScale = geometry.size.width / 6.0
                        let yScale = geometry.size.height / 2.0
                        
                        // Move the path to the starting point
                        path.move(to: CGPoint(x: (data[0].x + 3.0) * xScale, y: geometry.size.height - data[0].y * yScale))
                        
                        // Add lines to the path based on the data points
                        for point in data.dropFirst() {
                            let x = (point.x + 3.0) * xScale
                            let y = geometry.size.height - point.y * yScale
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                }
            }
            
            // Explanation text
            Text("A normal distribution is a probability distribution that is symmetric about the mean, showing that data near the mean are more frequent in occurrence than data far from the mean.")
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    NormalDistributionView()
}
