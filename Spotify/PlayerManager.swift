//
//  PlayerManager.swift
//  Spotify
//
//  Created by VanDoang on 31/10/25.
//

import Foundation
import AVFoundation
import MediaPlayer

class PlayerManager {
    static let shared = PlayerManager()
    var player: AVPlayer?
    
    private init () {}
    
    func play(track: DeezerTrack) {
        guard let url = URL(string: track.preview) else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func togglePlayPause() -> Bool {
        if player?.timeControlStatus == .paused {
            player?.play()
            return true
        } else {
            player?.pause()
            return false
        }
    }
    
    func stop () {
        player?.pause()
        player = nil
    }
    
    func setUpRemoteCommand() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { _ in
            self.player?.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { _ in
            self.player?.pause()
                    return .success
                }

        commandCenter.nextTrackCommand.addTarget { _ in
            NotificationCenter.default.post(name: .init("NextTrack"), object: nil)
            return .success
        }

        commandCenter.previousTrackCommand.addTarget { _ in
            NotificationCenter.default.post(name: .init("PrevTrack"), object: nil)
            return .success
        }
    }
}
