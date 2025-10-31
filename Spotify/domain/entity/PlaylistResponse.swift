//
//  Tracks.swift
//  Spotify
//
//  Created by Van Doang on 27/10/25.
//

import Foundation

struct PlaylistResponse: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let track: SpotifyTrack
}

struct SpotifyTrack: Decodable {
    let name: String
    let artists: [Artist]
    let album: Album
    
    struct Artist: Decodable {
        let id: String
        let name: String
    }
}


