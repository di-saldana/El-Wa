//
//  StartView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI

struct StartView: View {
    @State private var navigateToFamGame = false // Tracks navigation to FamGameView
    @State private var navigateToBoricuaGame = false // Tracks navigation to BoricuaGameView

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Wepa!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Button for FamGameView
                Button(action: startFamGame) {
                    Text("Fam")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // Button for BoricuaGameView
                Button(action: startBoricuaGame) {
                    Text("Bori")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                // Navigation links (hidden)
                NavigationLink(
                    destination: FamGameView(), // Destination for FamGameView
                    isActive: $navigateToFamGame,
                    label: { EmptyView() }
                )

                NavigationLink(
                    destination: BoriGameView(), // Destination for BoricuaGameView
                    isActive: $navigateToBoricuaGame,
                    label: { EmptyView() }
                )
            }
            .padding()
        }
    }

    func startFamGame() {
        startGame(orientation: .landscape) {
            navigateToFamGame = true
        }
    }

    func startBoricuaGame() {
        startGame(orientation: .landscape) {
            navigateToBoricuaGame = true
        }
    }

    func startGame(orientation: UIInterfaceOrientationMask, completion: @escaping () -> Void) {
        // Change orientation to landscape
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

        // Navigate to the selected game
        completion()
    }
}
