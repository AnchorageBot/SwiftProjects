//
//  ExerciseView.swift
//  HII_Fit
//
//  Created on 8/19/23, updated 8/21/2023
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift UI

import SwiftUI
import AVKit  // used to play videos, provides playback controls

struct ExerciseView: View {

    let interval: TimeInterval = 30

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

                Text(Date().addingTimeInterval(interval),
                     style: .timer)
                  .font(.system(size: geometry.size.height * 0.07))
                Button("Start/Done") { }
                    .font(.title3)
                    .padding()
                RatingView()
                    .padding()
                Spacer()
                Button("History") { }
                    .padding(.bottom)
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
