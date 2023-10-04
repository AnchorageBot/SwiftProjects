/*

 StoryPageView.swift
 Explore_SwiftUI_V3

 How to create a View file with keyboard and Xcode commands:

    * Command Key (Splat) N -> Swift UI View

 References:

 https://developer.apple.com/tutorials/sample-apps/chooseyourownstory

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/App/body-swift.property

 https://developer.apple.com/documentation/SwiftUI/WindowGroup

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://developer.apple.com/documentation/uikit/uiimage/configuring_and_displaying_symbol_images_in_your_ui

 Created on 10/3/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct StoryPageView: View {

    let story: Story
    let pageIndex: Int

    var body: some View {

        VStack {
                    ScrollView {
                        Text(story[pageIndex].text)
                    }

                    ForEach(story[pageIndex].choices, id: \Choice.text) { choice in
                        NavigationLink(destination: StoryPageView(story: story, pageIndex: choice.destination)) {
                            Text(choice.text)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.gray.opacity(0.25))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .navigationTitle("Page \(pageIndex + 1)")
                .navigationBarTitleDisplayMode(.inline)
            }
        }


        struct NonlinearStory_Previews: PreviewProvider {
            static var previews: some View {
                StoryPageView(story: story, pageIndex: 0)
            }
        }
