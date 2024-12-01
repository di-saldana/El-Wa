//
//  StartView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI

struct StartView: View {
    @State private var navigateToGame = false // Tracks navigation state

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Wepa!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Button(action: startGame) {
                    Text("START")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                NavigationLink(
                    destination: GameView(), // Destination is the GameView
                    isActive: $navigateToGame, // Bound to navigation state
                    label: { EmptyView() } // Invisible link
                )
            }
            .padding()
        }
    }

    func startGame() {
        // Change orientation to landscape
        AppDelegate.orientationLock = .landscape

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

        // Navigate to GameView
        navigateToGame = true
    }
}

