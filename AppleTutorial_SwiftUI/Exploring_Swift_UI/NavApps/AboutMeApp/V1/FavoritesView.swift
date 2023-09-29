/*

 FavoritesView.swift
 Explore_SwiftUI_V1

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/27/2023 with Swift 5.9, Xcode 15.0
 Updated on 9/28/2023

*/

import SwiftUI

struct FavoritesView: View {

    var body: some View {

        VStack {

            Text("Favorites")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            Text("Hobbies")
                .font(.title2)

            HStack {
                ForEach(information.hobbies, id: \.self) { hobby in
                    //Image(systemName: hobby)
                        //.resizable()
                        //.frame(maxWidth: 80, maxHeight: 60)
                    Text(hobby)
                        .font(.system(size: 48))

                }
                .padding()
            }
            .padding()

            Text("Foods")
                .font(.title2)

            HStack(spacing: 60) {
                ForEach(information.foods, id: \.self) { food in
                    Text(food)
                        .font(.system(size: 48))
                }
            }
            .padding()

            Text("Colors")
                .font(.title2)

            HStack(spacing: 30) {
                ForEach(information.colors, id: \.self) { color in
                    color
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                }
            }
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
