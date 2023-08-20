//
//  ExerciseView.swift
//  HII_Fit
//
//  Created on 8/19/23, updated 8/20/2023
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift UI

import SwiftUI
import AVKit  // used to play videos, provides playback controls

struct ExerciseView: View {

    let index: Int
    var exercise: Exercise {
        Exercise.exercises[index]
    }

/*
     https://github.com/kodecocodes/suia-materials/tree/editions/2.0/02-planning-a-paged-app/projects/starter/HIITFit/HIITFit/Videos
*/

    var body: some View {
        GeometryReader { geometry in
            VStack {

                HeaderView(exerciseName: exercise.exerciseName)
                    .padding()

                if let url = Bundle.main.url(
                  forResource: exercise.videoName,
                  withExtension: "mp4")  {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.045)
                } else {
                    Text("Couldn't find \(exercise.videoName).mp4")
                      .foregroundColor(.red)
                }

                Text("Timer")
                Text("Start/Done Button")
                Text("Rating")
                Text("History Button")
            }
            .padding()
        }
        .padding()
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}
