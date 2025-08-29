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

        setUpNavigationBar()
        createGradient()
        
    }
    
    private func setUpNavigationBar() {
        let appIcon = UIImageView(image: UIImage(named: "app_icon"))
        appIcon.contentMode = .scaleAspectFit
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = appIcon
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
