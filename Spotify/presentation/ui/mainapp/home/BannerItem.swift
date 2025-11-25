//
//  BannerItem.swift
//  Spotify
//
//  Created by VanDoang on 04/09/2025.
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
    
    func bindData (popular: DeezerTrack) {
        lblName.text = popular.title
        if let url = URL(string: popular.album.cover ?? "") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }.resume()
        }
    }

}
