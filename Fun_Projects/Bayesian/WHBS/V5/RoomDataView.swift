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

/// View component for displaying and editing room data
/// This view handles both the display and edit modes for room statistics
struct RoomDataView: View {
    // MARK: - Properties
    
    /// Binding to the room data being displayed/edited
    /// Using a binding allows the parent view to maintain source of truth
    @Binding var roomData: RoomData
    
    /// Controls whether the view is in edit mode
    /// When true, shows text fields; when false, shows formatted text
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
    
    /// Content shown when in edit mode
    /// Provides text fields for room name and observation counts
    private var editModeContent: some View {
        VStack(spacing: 12) {
            // Room name input field
            TextField("Room Name", text: $roomData.room)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("Room name input")
            
            // Noise observations input fields
            HStack(spacing: 16) {
                // Noise count input
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
                
                // No-noise count input
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
    
    /// Content shown when in display mode
    /// Shows formatted room statistics
    private var displayModeContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Room name display
            Text(roomData.room)
                .font(.headline)
                .accessibilityLabel("Room name")
            
            // Observation counts display
            HStack {
                Text("Noise: \(FormattingHelpers.observationCount(roomData.noise))")
                    .accessibilityLabel("Noise count")
                Spacer()
                Text("No Noise: \(FormattingHelpers.observationCount(roomData.noNoise))")
                    .accessibilityLabel("No noise count")
            }
            .font(.subheadline)
            
            // Total observations display
            Text("Total: \(FormattingHelpers.observationCount(roomData.total))")
                .font(.caption)
                .foregroundColor(.secondary)
                .accessibilityLabel("Total observations")
        }
    }
}

// MARK: - Preview Provider

#Preview {
    Group {
        // Preview in display mode
        RoomDataView(
            roomData: .constant(RoomData(room: "Bedroom", noise: 15, noNoise: 135)),
            isEditing: false
        )
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Display Mode")
        
        // Preview in edit mode
        RoomDataView(
            roomData: .constant(RoomData(room: "Study", noise: 5, noNoise: 15)),
            isEditing: true
        )
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Edit Mode")
    }
}
