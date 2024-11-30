//
//  GameView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI
import SwiftData

struct GameView: View {
    
    let samplePictures = [
        FamMember(imageName: "made", category: "Fam"),
        FamMember(imageName: "dana", category: "Fam"),
        FamMember(imageName: "diana", category: "Fam"),
        FamMember(imageName: "dayna", category: "Fam"),
    ]

    @StateObject private var motionManager = MotionManager()
    @State private var currentPicture: FamMember?
    @State private var score = 0
    @State private var timeRemaining = 60
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Time Remaining: \(timeRemaining)s")
                .font(.headline)

            // Display Image
            if let imageName = currentPicture?.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .padding()
            } else {
                Text("Get Ready!")
                    .font(.largeTitle)
                    .padding()
            }

            Spacer()

            // Display Score
            Text("Score: \(score)")
                .font(.title)
            
            Button("End Game") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            currentPicture = samplePictures.randomElement()
            startTimer()
            motionManager.startMotionUpdates()
        }
        // Monitor deviceTilt for changes
        .onChange(of: motionManager.deviceTilt) { tilt in
            if tilt == "up" {
                handleCorrectAnswer()
                print("CORRECT")
            } else if tilt == "down" {
                handlePass()
                print("WRONG")
            }
        }
        .onDisappear {
            motionManager.stopMotionUpdates()
        }
    }

    func handleCorrectAnswer() {
        score += 1
        currentPicture = samplePictures.randomElement()
        // TODO: CHANGE COLOR
    }

    func handlePass() {
        currentPicture = samplePictures.randomElement()
        // TODO: CHANGE COLOR
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}
