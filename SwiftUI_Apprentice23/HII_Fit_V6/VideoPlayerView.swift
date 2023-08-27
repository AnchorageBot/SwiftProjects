/*
  VideoPlayerView.swift
  HII_Fit

  Created on 8/27/23
  Made with Swift 5.8, Xcode 14.3.1

  Command N -> Swift UI

     https://github.com/kodecocodes/suia-materials/tree/editions/2.0/02-planning-a-paged-app/projects/starter/HIITFit/HIITFit/Videos

*/

import SwiftUI
import AVKit  // used to play videos, provides playback controls

struct VideoPlayerView: View {

    let videoName: String

    var body: some View {
        if let url = Bundle.main.url(
            forResource: videoName,
            withExtension: "mp4")  {
            VideoPlayer(player: AVPlayer(url: url))
              //.frame(height: geometry.size.height * 0.045)
        } else {
            Text("Couldn't find \(videoName).mp4")
                .foregroundColor(.red)
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoName: "squat")
    }
}
