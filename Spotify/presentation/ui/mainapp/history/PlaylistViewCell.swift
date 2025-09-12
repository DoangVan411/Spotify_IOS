//
//  PlaylistViewCell.swift
//  Spotify
//
//  Created by V000223 on 12/09/2025.
//

import UIKit

class PlaylistViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatar.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bindData(playlist: Playlist) {
        avatar.image = playlist.image
        name.text = playlist.name
    }
    
}
