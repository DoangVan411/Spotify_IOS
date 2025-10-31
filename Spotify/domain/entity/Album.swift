//
//  Album.swift
//  Spotify
//
//  Created by VanDoang on 10/09/2025.
//

import Foundation
import UIKit

struct Album: Decodable {
    let name: String
    let images: [APIImage]
    struct APIImage: Decodable {
        let url: String
    }
}
