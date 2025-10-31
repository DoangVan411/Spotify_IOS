//
//  ProfileViewController.swift
//  Spotify
//
//  Created by VanDoang on 03/09/2025.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var navShadow: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // sample data
//    let song = Song(id: "", title: "Dekat Di Hati", lyrics: "", releaseDate: Date.now, genre: "", duration: 0, image: UIImage(named: "test_hit")!, author: "RAN")
    var songs = [Hit(id: "", name: "", author: "", image: UIImage(named: "Adele"))]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 24
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ivAvatar.layer.cornerRadius = ivAvatar.frame.width / 2
        
        setUpNavigationBar()
        createGradient()
        
    }
    
    private func setUpNavigationBar () {
        
        let moreIcon = UIBarButtonItem(image: UIImage(named: "more_horizontal"))
        
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = moreIcon
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24),
        ]
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let songNib = UINib(nibName: "MusicViewCell", bundle: .main)
        tableView.register(songNib, forCellReuseIdentifier: "cell")
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MusicViewCell
        let song = songs[indexPath.row]
        cell.bindData(label1: "", label2: "", iv: UIImage(named: "Adele")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    
}
