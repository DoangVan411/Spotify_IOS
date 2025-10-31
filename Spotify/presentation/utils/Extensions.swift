//
//  Extensions.swift
//  Spotify
//
//  Created by VanDoang on 10/09/2025.
//

import Foundation
import UIKit

extension UIView {
    func removeAllConstraints() {
        let _subviews = self.subviews
        while _subviews.count > 0 {
            _subviews[0].removeFromSuperview()
        }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
