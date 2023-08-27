/*Copyright © 2022 Apple Inc.

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
See LICENSE folder for this sample’s licensing information.

Abstract:
The root content view for the app, displaying the user's flight itinerary.

   ContentView.swift
   FlightPlanner App

   Created on 8/27/23
   Made with Swift 5.8, Xcode 14.3.1

   Command N -> Swift UI

*/

import SwiftUI

struct ContentView: View {
    @Environment(\.editMode) private var editMode
    @State private var selection: FlightLeg?
    @State private var showBookingForm = false
    @StateObject private var flightData = FlightData()
    
    var body: some View {
        NavigationSplitView {
            // Workaround for a known issue where `NavigationSplitView`
            // and `NavigationStack` fail to update when their contents
            // are conditional. For more information,
            // see the iOS 16 Release Notes. (91311311)"
            ZStack {
                Group {
                    if flightData.segments.isEmpty {
                        Text("No Flights")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundStyle(.tertiary)
                    } else {
                        FlightItineraryList(
                            selection: $selection,
                            segments: $flightData.segments,
                            onDelete: onDelete)
                    }
                }
                .task {
                    Task.detached { @MainActor in
                        await flightData.load()
                    }
                }
                .navigationTitle("My Flights")
                .sheet(isPresented: $showBookingForm) {
                    BookingFormModal(flightData: flightData)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .disabled(flightData.segments.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Spacer()
                            Button {
                                showBookingForm.toggle()
                            } label: {
                                Label("Add Flight", systemImage: "square.and.pencil")
                            }
                            .disabled(isAddFlightButtonDisabled)
                        }
                    }
                }
            }
        } detail: {
            // Workaround for a known issue where `NavigationSplitView`
            // and `NavigationStack` fail to update when their contents
            // are conditional. For more information,
            // see the iOS 16 Release Notes. (91311311)"
            ZStack {
                if let leg = selection {
                    FlightLegDetail(leg: leg)
                }
            }
        }
    }
    
    func onDelete(atOffsets offsets: IndexSet, in segment: FlightSegment) {
        flightData.removeLegs(atOffsets: offsets, in: segment)
    }
    
    var isAddFlightButtonDisabled: Bool {
        editMode?.wrappedValue.isEditing == true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
