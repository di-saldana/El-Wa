//
//  FamGameView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI
import SwiftData

struct FamGameView: View {
    
    let samplePictures = [
        FamMember(imageName: "made", category: "Fam"),
        FamMember(imageName: "dana", category: "Fam"),
        FamMember(imageName: "diana", category: "Fam"),
        FamMember(imageName: "dayna", category: "Fam"),
        FamMember(imageName: "jinny", category: "Fam"),
        FamMember(imageName: "dixon", category: "Fam"),
        FamMember(imageName: "tati", category: "Fam"),
        FamMember(imageName: "goldo", category: "Fam"),
        FamMember(imageName: "oly", category: "Fam"),
        FamMember(imageName: "julio", category: "Fam"),
        FamMember(imageName: "tusca", category: "Fam"),
        FamMember(imageName: "cesar", category: "Fam"),
        FamMember(imageName: "nelson", category: "Fam"),
    ]

    @StateObject private var motionManager = MotionManager()
    @State private var currentPicture: FamMember?
    @State private var score = 0
    @State private var timeRemaining = 60
    @State private var backgroundColor = Color.yellow
    @Environment(\.presentationMode) var presentationMode
    
    let colorCycle: [Color] = [.yellow, .red, .green, .blue]
    @State private var colorIndex = 0

    var body: some View {
        ZStack {
            // Background color
            backgroundColor
                .ignoresSafeArea()
            
            // Main content area
            VStack {
                Spacer()

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
            }

            // Time at the top-right corner
            VStack {
                HStack {
                    Spacer()
                    Text("\(timeRemaining)s")
                        .font(.title)
                        .padding(.top, 10)
                        .padding(.trailing, 15)
                }
                Spacer()
            }

            // Score at the bottom-right corner
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title)
                        .padding(.bottom, 10)
                        .padding(.trailing, 15)
                }
            }
        }
        .onAppear {
            currentPicture = samplePictures.randomElement()
            startTimer()
            motionManager.startMotionUpdates()
        }
        .onChange(of: motionManager.deviceTilt) { tilt in
            if tilt == "up" {
                handleCorrectAnswer()
            } else if tilt == "down" {
                handlePass()
            }
        }
        .onDisappear {
            motionManager.stopMotionUpdates()
        }
    }

    
    func handleCorrectAnswer() {
        score += 1
        currentPicture = samplePictures.randomElement()
        cycleBackgroundColor()
    }

    func handlePass() {
        currentPicture = samplePictures.randomElement()
        cycleBackgroundColor()
    }
    
    func cycleBackgroundColor() {
        colorIndex = (colorIndex + 1) % colorCycle.count
        backgroundColor = colorCycle[colorIndex]
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                // DISPLAY "SE ACABÓ LO QUE SE DABA"
            }
        }
    }
}
