//
//  NowPlayingViewController.swift
//  Spotify
//
//  Created by V000223 on 09/09/2025.
//

import UIKit

class NowPlayingViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mediaControl: CustomMediaControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBarController = tabBarController as? CustomTabBarController {
                    tabBarController.setTabBarHidden(true, animated: false)
                }
        setUpNavigationBar()
        setUpSlider()
        imageView.layer.cornerRadius = 32
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let tabBarController = tabBarController as? CustomTabBarController {
                    tabBarController.setTabBarHidden(false, animated: false)
                }
    }
    
    private func setUpNavigationBar () {
        navigationItem.title = "Now Playing"
        
        let backButton = UIImage(named: "back_press_gray")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24),
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setUpSlider () {
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    @objc private func sliderChanged(_ sender: UISlider) {
        
    }

}
