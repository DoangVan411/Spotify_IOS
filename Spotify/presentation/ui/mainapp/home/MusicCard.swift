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

    func bindAlbumData(album: Album) {
        label1.text = album.name
        label2.text = album.publishYear.description
        image.image = album.image
    }
    
    func setupConstraints() {
        removeAllConstraints()
        NSLayoutConstraint.activate([
            // Constraint cho imageView
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),

            // Constraint cho topLabel
            label1.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            

            // Constraint cho bottomLabel
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
            label2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label2.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
