//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by VanDoang on 03/09/2025.
//

import UIKit

class PlaylistViewController: UIViewController {

    
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    @IBOutlet weak var navShadow: UIView!
    
    var playlists: [Playlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        createGradient()
        
        let playlistNib = UINib(nibName: "PlaylistItem", bundle: .main)
        playlistCollectionView.register(playlistNib, forCellWithReuseIdentifier: "cell")
        
        let samplePlayList = Playlist(id: "", name: "Liked songs", numOfSongs: 130, image: UIImage(named: "test_hit"))
        playlists = [samplePlayList, samplePlayList, samplePlayList, samplePlayList]
    }

    
    private func setUpNavigationBar () {
        
        let searchIcon = UIBarButtonItem(image: UIImage(named: "search_white"))
        let addIcon = UIBarButtonItem(image: UIImage(named: "add"))
        
        navigationItem.title = "Playlist"
        navigationItem.leftBarButtonItem = searchIcon
        navigationItem.rightBarButtonItem = addIcon
        
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

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaylistItem
        let playlist = playlists[indexPath.row]
        
        cell.bindPlaylistData(playlist: playlist)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 206)
    }
    
}
