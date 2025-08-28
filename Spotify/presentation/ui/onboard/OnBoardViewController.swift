//
//  OnBoardViewController.swift
//  Spotify
//
//  Created by V000223 on 25/08/2025.
//

import UIKit

class OnBoardViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGradient()
        
    }

    private func createGradient () {
        let gradient = CAGradientLayer()
        gradient.frame = background.bounds
        gradient.colors = [    UIColor.white.withAlphaComponent(0.0).cgColor,
                               UIColor.white.withAlphaComponent(0.5).cgColor,
                               UIColor.white.withAlphaComponent(0.8).cgColor,
                               UIColor.white.withAlphaComponent(0.8).cgColor,
                               UIColor.white.withAlphaComponent(0.5).cgColor,
                               UIColor.white.withAlphaComponent(0.0).cgColor ]
        gradient.locations = [0.1, 0.2, 0.3, 0.8, 0.9, 1.0]
        background.layer.mask = gradient
    }

}
