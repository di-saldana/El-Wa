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
    
    let famGameKeyPhrase = "wepa" // Key phrase for FamGameView

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Wepa!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Button for FamGameView (password-protected)
                Button(action: { showPasswordPrompt = true }) {
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
                        .background(Color.green)
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
            .padding()
            .alert("Pon el Password", isPresented: $showPasswordPrompt, actions: {
                SecureField("Password", text: $passwordInput)
                Button("Submit") {
                    validatePassword()
                }
                Button("Cancel", role: .cancel) {
                    passwordInput = "" // Clear input
                    passwordError = false
                }
//            }, message: {
//                if passwordError {
//                    Text("ALERTA: FAKE FAMILY MEMBER!!")
//                        .foregroundColor(.red)
//                }
            })
        }
    }

    // Validate the entered password for FamGameView
    func validatePassword() {
        if passwordInput == famGameKeyPhrase {
            passwordError = false
            startFamGame()
        } else {
            passwordError = true
        }
        passwordInput = "" // Clear the input for security
    }

    // Navigate to FamGameView
    func startFamGame() {
        setOrientation(to: .landscape) {
            navigateToFamGame = true
        }
    }

    // Navigate to BoricuaGameView
    func startBoricuaGame() {
        setOrientation(to: .landscape) {
            navigateToBoricuaGame = true
        }
    }

    // Utility to set screen orientation and trigger navigation
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
