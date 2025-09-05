//
//  Song.swift
//  Spotify
//
//  Created by V000223 on 25/08/2025.
//

import Foundation
import UIKit

struct Song: Identifiable {
    let id: String
    let title: String
    let lyrics: String
    let releaseDate: Date
    let genre: String
    let duration: Int
    let image: UIImage?
    let author: String
}
