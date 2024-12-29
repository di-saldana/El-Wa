//
//  StartView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI


struct StartView: View {
    @State private var navigateToFamGame = false
    @State private var navigateToBoricuaGame = false
    @State private var showPasswordPrompt = false
    @State private var passwordInput = ""
    @State private var passwordError = false
    @State private var showVideo = true // Manage video visibility
    @State private var backgroundColor = Color(red: 133/255, green: 210/255, blue: 218/255)


    let famGameKeyPhrase = "wepa" // Key phrase for FamGameView
    let videoName = "intro"

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                if showVideo {
                    VideoPlayerView(videoName: videoName)
                        .ignoresSafeArea()
                }

                VStack(spacing: 20) {
//                    Text("Wepa!")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .shadow(radius: 10)

                    // Button for FamGameView
                    Button(action: startFamGame) {
                        Text("Fam Game")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    // Button for BoricuaGameView (no password required)
                    Button(action: startBoricuaGame) {
                        Text("Bori Game")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.red)
                            .cornerRadius(10)
                    }

                    // Navigation links (hidden)
                    NavigationLink(
                        destination: FamGameView(),
                        isActive: $navigateToFamGame,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: BoriGameView(),
                        isActive: $navigateToBoricuaGame,
                        label: { EmptyView() }
                    )
                }
//                .padding()
//                .alert("Pon el Password", isPresented: $showPasswordPrompt, actions: {
//                    SecureField("Password", text: $passwordInput)
//                    Button("Submit") {
//                        validatePassword()
//                    }
//                    Button("Cancel", role: .cancel) {
//                        passwordInput = "" // Clear input
//                        passwordError = false
//                    }
//                })
            }
        }
    }

    func validatePassword() {
        if passwordInput == famGameKeyPhrase {
            passwordError = false
            startFamGame()
        } else {
            passwordError = true
        }
        passwordInput = "" // Clear the input for security
    }

    func startFamGame() {
        showVideo = false // Hide video
        setOrientation(to: .landscape) {
            navigateToFamGame = true
        }
    }

    func startBoricuaGame() {
        showVideo = false // Hide video
        setOrientation(to: .landscape) {
            navigateToBoricuaGame = true
        }
    }

    func setOrientation(to orientation: UIInterfaceOrientationMask, completion: @escaping () -> Void) {
        AppDelegate.orientationLock = orientation

        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: AppDelegate.orientationLock))
                }
            }
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }

        completion()
    }
}
