//
//  NowPlayingViewModel.swift
//  Spotify
//
//  Created by VanDoang on 31/10/25.
//

import Foundation
import UIKit

class NowPlayingViewModel {
    
    private let getImageUseCase: GetImageUseCase
    private let playerManager: PlayerManager
    private var tracks: [DeezerTrack]
    private var currentIdx: Int = 0
    
    init(playerManager: PlayerManager, tracks: [DeezerTrack], getImageUseCase: GetImageUseCase) {
        self.getImageUseCase = getImageUseCase
        self.playerManager = playerManager
        self.tracks = tracks
    }

    func togglePlayPause() {
        playerManager.togglePlayPause()
    }
    
    func playNextTrack() {
        guard currentIdx + 1 < tracks.count else { return }
        currentIdx += 1
        playerManager.play(track: tracks[currentIdx])
    }
    
    func playPreviousTrack() {
        guard currentIdx - 1 >= 0 else { return }
        currentIdx -= 1
        playerManager.play(track: tracks[currentIdx])
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        getImageUseCase.execute(url: url, completion: completion)
    }
    
    func playTrack(track: DeezerTrack) {
        playerManager.play(track: track)
    }
}
