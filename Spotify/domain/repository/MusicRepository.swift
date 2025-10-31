//
//  MusicRepository.swift
//  Spotify
//
//  Created by VanDoang on 31/10/25.
//

import Foundation
import UIKit

protocol MusicRepository {
    func getHitTracks (completion: @escaping (Result<[DeezerTrack], Error>) -> Void)
    func getImage (url: URL, completion: @escaping (UIImage?) -> Void)
}
