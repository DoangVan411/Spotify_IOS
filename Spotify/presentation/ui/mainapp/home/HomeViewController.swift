//
//  HomeViewController.swift
//  Spotify
//
//  Created by V000223 on 03/09/2025.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var hitCollectionView: UICollectionView!
    @IBOutlet weak var segmentShadow: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let bannerDelegate = BannerCollectionViewDelegate()
    let hitDelegate = HitCollectionViewDelegate()
    
    private let segmentControl = ScrollableSegmentControlView(
            titles: ["Artists", "Album", "Podcast", "Genre"]
        )
    
    
    //sample data
    let popularSong = Popular(name: "Sisa Rasa", author: "Mahalini", image: UIImage(named: "Mahalini"))
    lazy var testPopulars = [popularSong, popularSong, popularSong, popularSong, popularSong]
    
    let hit = Hit(name: "Runtuh", author: "Feby Putri, Fiersa", image: UIImage(named: "test_hit"))
    lazy var testHits = [hit, hit, hit, hit, hit]
    
    let artist = Artist(name: "Adele", numOfListeners: 1000000, image: UIImage(named: "Mahalini"))
    lazy var artists = [artist, artist, artist, artist, artist]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        createGradient()
        
        bannerCollectionView.delegate = bannerDelegate
        bannerCollectionView.dataSource = bannerDelegate
        bannerDelegate.testPopulars = testPopulars
        
        hitCollectionView.delegate = hitDelegate
        hitCollectionView.dataSource = hitDelegate
        hitDelegate.testHits = testHits
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSegmentControl()
        if let bannerLayout = bannerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            bannerLayout.scrollDirection = .horizontal
            bannerLayout.itemSize = CGSize(width: bannerCollectionView.bounds.width, height: bannerCollectionView.bounds.height)
        }
        if let hitLayout = hitCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            hitLayout.scrollDirection = .horizontal
            hitLayout.itemSize = CGSize(width: 128, height: hitCollectionView.bounds.height)
            hitLayout.minimumInteritemSpacing = 16
        }
        
        let bannerNib = UINib(nibName: "BannerItem", bundle: .main)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: "cell1")
        
        let hitNib = UINib(nibName: "MusicCard", bundle: .main)
        hitCollectionView.register(hitNib, forCellWithReuseIdentifier: "cell2")
        
        let tableNib = UINib(nibName: "TableItem", bundle: .main)
        tableView.register(tableNib, forCellReuseIdentifier: "table_cell")
    }
    
    private func setupSegmentControl() {
            view.addSubview(segmentControl)
            NSLayoutConstraint.activate([
                segmentControl.topAnchor.constraint(equalTo: hitCollectionView.bottomAnchor, constant: 32),
                segmentControl.leadingAnchor.constraint(equalTo: hitCollectionView.leadingAnchor),
                segmentControl.trailingAnchor.constraint(equalTo: hitCollectionView.trailingAnchor),
                segmentControl.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
    
    private func setUpNavigationBar () {
        let appIcon = UIImageView(image: UIImage(named: "app_icon"))
        appIcon.contentMode = .scaleAspectFit
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        let searchIcon = UIBarButtonItem(image: UIImage(named: "search_white"))
        let settingIcon = UIBarButtonItem(image: UIImage(named: "setting"))
        
        navigationItem.titleView = appIcon
        navigationItem.leftBarButtonItem = searchIcon
        navigationItem.rightBarButtonItem = settingIcon
        navigationController?.navigationBar.standardAppearance = appearance
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func reloadData(for index: Int) {
        tableView.reloadData()
    }

    private func createGradient () {
        let gradient = CAGradientLayer()
        gradient.frame = segmentShadow.bounds
        gradient.colors = [    UIColor.white.withAlphaComponent(0.0).cgColor,
                               UIColor.white.withAlphaComponent(0.15).cgColor,
                               UIColor.white.withAlphaComponent(0.1).cgColor,
                               UIColor.white.withAlphaComponent(0.05).cgColor]
        gradient.locations = [0.1, 0.3, 0.5]
        segmentShadow.layer.mask = gradient
    }
    
}

class BannerCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var testPopulars: [Popular] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BannerItem
        let popular = testPopulars[indexPath.row]
        cell.bindData(popular: popular)
        return cell
    }
}

class HitCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var testHits: [Hit] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! MusicCard
        
        let hit = testHits[indexPath.row]
        cell.bindHitData(hit: hit)
        return cell
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath) as! TableItem
        let artist = artists[indexPath.row]
        cell.bindData(name: artist.name, image: artist.image!, numOfListeners: artist.numOfListeners)
        return cell
    }
}

