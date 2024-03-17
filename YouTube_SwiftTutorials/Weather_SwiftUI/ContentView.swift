//
//  ContentView.swift
//  WxCoreLocate_V1
//
//  Created by ATS on 3/11/24
//  Revised on 3/16/24
//  Xcode 15.2
//

/*
 
 Abstract:
 
    A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
 
 References:
 
    https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller
 
    https://developer.apple.com/documentation/uikit/view_controllers/managing_content_in_your_app_s_windows/
 
 */


import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, weather!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
