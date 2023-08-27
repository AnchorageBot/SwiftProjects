//
//  HeaderView.swift
//  HII_Fit
//
//  Created on 8/19/23
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift UI

import SwiftUI

struct HeaderView: View {

    let exerciseName: String
    
    var body: some View {
        VStack {
            Text(exerciseName)
                .font(.largeTitle)
            HStack {
                Image(systemName: "1.circle")
                Image(systemName: "2.circle")
                Image(systemName: "3.circle")
                Image(systemName: "4.circle")
            }
            .font(.title2)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(exerciseName: "Squat")
            .previewLayout(.sizeThatFits)
    }
}
