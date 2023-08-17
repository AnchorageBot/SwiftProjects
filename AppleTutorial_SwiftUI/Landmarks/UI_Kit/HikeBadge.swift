//
//  HikeBadge.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/4/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->File->SwiftUI View
//

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
