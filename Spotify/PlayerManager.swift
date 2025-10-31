//
//  PlayerManager.swift
//  Spotify
//
//  Created by VanDoang on 31/10/25.
//

import Foundation
import AVFoundation

class PlayerManager {
    static let shared = PlayerManager()
    private var player: AVPlayer?
    
    private init () {}
    
    func play(track: DeezerTrack) {
        guard let url = URL(string: track.preview) else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func togglePlayPause() {
        if player?.timeControlStatus == .paused {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    func stop () {
        player?.pause()
        player = nil
    }
}
