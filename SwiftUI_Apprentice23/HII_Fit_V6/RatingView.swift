//
//  RatingView.swift
//  HII_Fit
//
//  Created on 8/21/23
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift UI

import SwiftUI

struct RatingView: View {
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { _ in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
            .previewLayout(.sizeThatFits)
    }
}
