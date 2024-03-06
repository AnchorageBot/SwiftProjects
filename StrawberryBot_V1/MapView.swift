//
//  AppViews Group
//  MapView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 

/*
 Abstract:
 
 The map view that shows the garden's location
 
 References:
 
 https://developer.apple.com/tutorials/swiftui/creating-and-combining-views
 
 */

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(initialPosition: .region(region))
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 61.217_381, longitude: -149.863_129),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

#Preview {
    MapView()
}
