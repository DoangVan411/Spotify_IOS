//
//  MusicViewCell.swift
//  Spotify
//
//  Created by VanDoang on 05/09/2025.
//

import UIKit

class MusicViewCell: UITableViewCell {
    
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        iv.layer.cornerRadius = 12
        contentView.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(label1: String, label2: String, iv: UIImage) {
        self.label1.text = label1
        self.label2.text = label2
        self.iv.image = iv
    }
    
}
