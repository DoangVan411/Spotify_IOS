//
//  TableItem.swift
//  Spotify
//
//  Created by VanDoang on 04/09/2025.
//

import UIKit

class TableItem: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numOfListeners: UILabel!
    @IBOutlet weak var btnDetail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData (name: String, image: UIImage, numOfListeners: Int) {
        self.name.text = name
        self.numOfListeners.text = "\(numOfListeners) monthly listeners"
        avatar.image = image
    }
    
}
