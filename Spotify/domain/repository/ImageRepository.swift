//
//  ImageRepository.swift
//  Spotify
//
//  Created by Hồ Hải Hà on 31/10/25.
//

import Foundation
import UIKit

protocol ImageRepository {
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}
