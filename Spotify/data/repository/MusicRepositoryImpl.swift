//
//  MusicRepositoryImpl.swift
//  Spotify
//
//  Created by VanDoang on 31/10/25.
//

import Foundation
import UIKit

class MusicRepositoryImpl: MusicRepository {
    
    let apiService: APIService = APIService.shared
    
    func getHitTracks(completion: @escaping (Result<[DeezerTrack], any Error>) -> Void) {
        apiService.getHits(completion: completion)
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        apiService.getImage(url: url, completion: completion)
    }
}
