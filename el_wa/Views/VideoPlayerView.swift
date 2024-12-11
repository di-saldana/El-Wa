//
//  VideoPlayerView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 12/11/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    let videoName: String
    
    @State private var showVideo = true

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Video file not found")
            return view
        }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = UIScreen.main.bounds

        view.layer.addSublayer(playerLayer)
        player.play()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
