//
//  Playlist.swift
//  Spotify
//
//  Created by V000223 on 04/09/2025.
//

import Foundation
import UIKit

struct Playlist {
    let id: String
    let name: String
    let numOfSongs: Int
    let image: UIImage?
    var songs: [Song] = []
}
