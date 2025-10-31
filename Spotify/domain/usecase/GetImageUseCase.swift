//
//  GetImageUseCase.swift
//  Spotify
//
//  Created by Hồ Hải Hà on 31/10/25.
//

import Foundation
import UIKit

class GetImageUseCase {
    private let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func execute(url: URL, completion: @escaping (UIImage?) -> Void) {
        imageRepository.getImage(from: url, completion: completion)
    }
}
