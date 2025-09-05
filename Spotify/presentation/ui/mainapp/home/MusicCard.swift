//
//  MusicCard.swift
//  Spotify
//
//  Created by V000223 on 03/09/2025.
//

import UIKit

class MusicCard: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
    }
    
    func bindHitData(hit: Hit) {
        label1.text = hit.name
        label2.text = hit.author
        image.image = hit.image
    }

}
