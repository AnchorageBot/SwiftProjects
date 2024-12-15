//
// BayesCalculator
// RoomDataView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import SwiftUI

struct RoomDataView: View {
    // MARK: - Properties
    
    @Binding var roomData: RoomData
    let isEditing: Bool
    
    // MARK: - Body View
    
    var body: some View {
        VStack {
            if isEditing {
                editModeContent
            } else {
                displayModeContent
            }
        }
    }
    
    // MARK: - Private Views
    
    private var editModeContent: some View {
        VStack(spacing: 12) {
            TextField("Room Name", text: $roomData.room)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("Room name input")
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Noise:")
                        .font(.caption)
                    TextField(
                        "Noise",
                        value: $roomData.noise,
                        format: .number
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("Noise count input")
                }
                
                VStack(alignment: .leading) {
                    Text("No Noise:")
                        .font(.caption)
                    TextField(
                        "No Noise",
                        value: $roomData.noNoise,
                        format: .number
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("No noise count input")
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private var displayModeContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(roomData.room)
                .font(.headline)
                .accessibilityLabel("Room name")
            
            HStack {
                Text("Noise: \(FormattingHelpers.observationCount(roomData.noise))")
                    .accessibilityLabel("Noise count")
                Spacer()
                Text("No Noise: \(FormattingHelpers.observationCount(roomData.noNoise))")
                    .accessibilityLabel("No noise count")
            }
            .font(.subheadline)
            
            Text("Total: \(FormattingHelpers.observationCount(roomData.total))")
                .font(.caption)
                .foregroundColor(.secondary)
                .accessibilityLabel("Total observations")
        }
    }
}

struct RoomDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoomDataView(
                roomData: .constant(RoomData(room: "Bedroom", noise: 15, noNoise: 135)),
                isEditing: false
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Display Mode")
            
            RoomDataView(
                roomData: .constant(RoomData(room: "Study", noise: 5, noNoise: 15)),
                isEditing: true
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Edit Mode")
        }
        .padding()
    }
}
