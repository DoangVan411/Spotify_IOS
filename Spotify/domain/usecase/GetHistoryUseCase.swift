//
//  GetHistoryUseCase.swift
//  Spotify
//
//  Created by Hồ Hải Hà on 28/11/25.
//

import Foundation

class GetHistoryUseCase {
    private let musicRepository: MusicRepository
    
    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }
    
    func execute() -> [Song] {
        return musicRepository.getHistory()
    }
}
