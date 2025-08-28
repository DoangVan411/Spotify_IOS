//
//  Song.swift
//  Spotify
//
//  Created by V000223 on 25/08/2025.
//

import Foundation

struct Song: Identifiable {
    let id: String
    let title: String
    let lyrics: String
    let releaseDate: ip_timestamp
    let genre: String
    let duration: Int
}
