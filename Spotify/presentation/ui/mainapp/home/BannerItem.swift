//
//  BannerItem.swift
//  Spotify
//
//  Created by V000223 on 04/09/2025.
//

import UIKit

class BannerItem: UICollectionViewCell {

    
    @IBOutlet weak var previousItem: UIImageView!
    @IBOutlet weak var nextItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 12
        previousItem.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func bindData (popular: Popular) {
        lblName.text = popular.name
        lblAuthor.text = popular.author
        image.image = popular.image
    }

}
