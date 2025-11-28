//
//  AddSongToHistoryUseCase.swift
//  Spotify
//
//  Created by VanDoang on 28/11/25.
//

import Foundation

class AddSongToHistoryUseCase {
    private let musicRepository: MusicRepository
    
    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }
    
    func execute (deezerTrack: DeezerTrack) {
        musicRepository.addSongToHistory(deezerTrack: deezerTrack)
    }
}
