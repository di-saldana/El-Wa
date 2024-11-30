//
//  MotionManager.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import SwiftUI
import CoreMotion


class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var deviceTilt: String = "" // "up", "down", or ""

    init() {
        startMotionUpdates()
    }

    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1 // Update interval in seconds
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let motion = motion, error == nil else { return }

                // Detect tilt
                let roll = motion.attitude.roll // Tilt left/right in radians
                // pitch = motion.attitude.pitch // Forward/backward tilt in radians

                if roll > 0.5 { // Tilt up (approx. 30 degrees)
                    self?.deviceTilt = "up"
                } else if roll < -0.5 { // Tilt down (approx. -30 degrees)
                    self?.deviceTilt = "down"
                } else {
                    self?.deviceTilt = ""
                }
            }
        }
    }

    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
