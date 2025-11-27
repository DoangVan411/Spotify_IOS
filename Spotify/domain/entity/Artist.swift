//
//  Artist.swift
//  Spotify
//
//  Created by VanDoang on 04/09/2025.
//

import Foundation
import UIKit

struct ArtistsResponse: Codable {
    let data: [Artist]
}

struct Artist: Codable {
    let name: String
    let picture: String
    let numberOfAlbums: Int
    let tracklist: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case picture = "picture"
        case numberOfAlbums = "nb_album"
        case tracklist = "tracklist"
    }
}
