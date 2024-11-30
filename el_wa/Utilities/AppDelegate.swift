//
//  AppDelegate.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import Foundation
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {
static var orientationLock = UIInterfaceOrientationMask.portrait {
    didSet {
        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                }
            }
            UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if orientationLock == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                              forKey: "orientation" )
                }
            }
        }
    }
}
