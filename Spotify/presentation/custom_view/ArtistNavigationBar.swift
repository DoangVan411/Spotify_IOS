//
//  ArtistNavigationBar.swift
//  Spotify
//
//  Created by VanDoang on 10/09/2025.
//

import UIKit

class ArtistNavigationBar: UINavigationBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
            var newSize = super.sizeThatFits(size)
            if prefersLargeTitles {
                newSize.height += 100
            }
            return newSize
        }

}
