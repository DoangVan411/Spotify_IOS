//
//  ArtistViewController.swift
//  Spotify
//
//  Created by VanDoang on 10/09/2025.
//

import UIKit

class ArtistViewController: UIViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var songTableView: UITableView!
    let appearance = UINavigationBarAppearance()
    
//    //sample data
//    let album = Album(images: [UIImage (named: "Adele")!])
    var testAlbums: [Album] = []
//
//    let song = Song(id: <#T##String#>)
    var songs: [SpotifyTrack] = []
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        setUpNavigationBar(image: UIImage(named: "Adele")!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let albumLayout = albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            albumLayout.scrollDirection = .horizontal
            albumLayout.itemSize = CGSize(width: 128, height: albumCollectionView.bounds.height)
            albumLayout.minimumInteritemSpacing = 16
        }
        
        let albumNib = UINib(nibName: "MusicCard", bundle: .main)
        albumCollectionView.register(albumNib, forCellWithReuseIdentifier: "cell")
        
        let songNib = UINib(nibName: "MusicViewCell", bundle: .main)
        songTableView.register(songNib, forCellReuseIdentifier: "cell2")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        appearance.backgroundImage = nil
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setUpNavigationBar(image: UIImage) {
        if let navBar = navigationController?.navigationBar {
            navBar.backgroundColor = .black
            navBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
            
            navBar.layer.shadowColor = UIColor.black.cgColor
            navBar.layer.shadowOpacity = 0.5
            navBar.layer.shadowOffset = CGSize(width: 0, height: 2)
            navBar.layer.shadowRadius = 8
            navBar.layer.masksToBounds = true
            
            let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: navBar.frame.maxY - 4, width: navBar.frame.width, height: 4))
            navBar.layer.shadowPath = shadowPath.cgPath
        }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 50
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: UIScreen.main.bounds.width, height: 200))
        
        let renderedImage = renderer.image { _ in
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
            imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        
        let followButton = UIButton(type: .system)
        followButton.backgroundColor = .clear
        followButton.layer.cornerRadius = 16
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            followButton.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        let followBarButton = UIBarButtonItem(customView: followButton)

        let moreBarBtn = UIBarButtonItem(image: UIImage(named: "more_horizontal"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onMoreTapped))
        
        navigationItem.rightBarButtonItems = [moreBarBtn, followBarButton]
        
        appearance.configureWithOpaqueBackground()
        
        navigationItem.title = "Adele"
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24)
        ]
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24)
        ]
        
        appearance.backgroundImage = renderedImage
        appearance.backgroundColor = .black
        appearance.shadowColor = UIColor.clear
        
        appearance.shadowColor = UIColor.white.withAlphaComponent(0.3)
        
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc private func onMoreTapped(_ sender: UIButton) {
        
    }
}

extension ArtistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCard
        let album = testAlbums[indexPath.row]
        cell.bindAlbumData(album: album)
        return cell
    }
    
    
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MusicViewCell
        
        let track: SpotifyTrack = songs[indexPath.row]
        
        cell.label2.isHidden = true
        
        cell.bindData(label1: "", label2: "", iv: UIImage(named: "Adele")!)
        return cell
    }
    
    
}
