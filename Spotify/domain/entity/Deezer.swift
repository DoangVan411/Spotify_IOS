//
//  Deezer.swift
//  Spotify
//
//  Created by VanDoang on 29/10/25.
//

import Foundation

// MARK: - Root response (danh sách bài hát)
struct DeezerPlaylistResponse: Codable {
    let id: Int
    let title: String
    let description: String?
    let picture: String?
    let tracks: TrackList
    struct TrackList: Codable {
        let data: [DeezerTrack]
    }
}

// MARK: - Track
struct DeezerTrack: Codable {
    let id: Int
    let title: String
    let duration: Int
    let preview: String
    let artist: DeezerArtist
    let album: DeezerAlbum
}

// MARK: - Artist
struct DeezerArtist: Codable {
    let id: Int
    let name: String
    let picture: String?
}

// MARK: - Album
struct DeezerAlbum: Codable {
    let id: Int
    let title: String
    let cover: String?
}
