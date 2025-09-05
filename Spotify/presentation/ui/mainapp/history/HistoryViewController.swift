//
//  HistoryViewController.swift
//  Spotify
//
//  Created by V000223 on 03/09/2025.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var navShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        createGradient()
        
    }
    
    private func setUpNavigationBar () {
        
        let moreIcon = UIBarButtonItem(image: UIImage(named: "more_horizontal"))
        
        navigationItem.title = "History"
        navigationItem.rightBarButtonItem = moreIcon
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func createGradient () {
        let gradient = CAGradientLayer()
        gradient.frame = navShadow.bounds
        gradient.colors = [    UIColor.white.withAlphaComponent(0.0).cgColor,
                               UIColor.white.withAlphaComponent(0.15).cgColor,
                               UIColor.white.withAlphaComponent(0.1).cgColor,
                               UIColor.white.withAlphaComponent(0.05).cgColor]
        gradient.locations = [0.1, 0.3, 0.5]
        navShadow.layer.mask = gradient
    }

}
