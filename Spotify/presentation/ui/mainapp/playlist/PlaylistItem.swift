//
//  PlaylistItem.swift
//  Spotify
//
//  Created by VanDoang on 04/09/2025.
//

import UIKit

class PlaylistItem: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numOfSongs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.layer.cornerRadius = 12
        
    }
    
    func bindPlaylistData(playlist: Playlist) {
        name.text = playlist.name
        numOfSongs.text = "\(playlist.numOfSongs) songs"
        image.image = playlist.image
    }

}
