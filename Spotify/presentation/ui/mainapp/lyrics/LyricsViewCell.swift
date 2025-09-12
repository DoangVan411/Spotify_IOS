//
//  LyricsViewCell.swift
//  Spotify
//
//  Created by V000223 on 09/09/2025.
//

import UIKit

class LyricsViewCell: UITableViewCell {

    
    @IBOutlet weak var lblLyric: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Cell bg: \(String(describing: backgroundColor))")
        print("ContentView bg: \(String(describing: contentView.backgroundColor))")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func bindData(lyric: String) {
        lblLyric.text = lyric
    }
}

extension LyricsViewCell {
    func forceClearAllBackgrounds() {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        clearSubviewsBackground(self.contentView)
    }
    
    private func clearSubviewsBackground(_ view: UIView) {
        view.backgroundColor = UIColor.clear
        for subview in view.subviews {
            clearSubviewsBackground(subview)
        }
    }
}
