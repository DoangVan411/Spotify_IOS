//
//  ImageRepositoryImpl.swift
//  Spotify
//
//  Created by Hồ Hải Hà on 31/10/25.
//

import Foundation
import UIKit

class ImageRepositoryImpl: ImageRepository {
    
    private let apiService = APIService.shared
    
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        apiService.getImage(url: url, completion: completion)
    }
}
