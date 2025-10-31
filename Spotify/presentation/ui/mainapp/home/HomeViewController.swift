//
//  HomeViewController.swift
//  Spotify
//
//  Created by VanDoang on 03/09/2025.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var hitCollectionView: UICollectionView!
    @IBOutlet weak var segmentShadow: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let segmentControl = ScrollableSegmentControlView(
        titles: ["Artists", "Album", "Podcast", "Genre"]
    )
    
    private var tracks: [DeezerTrack] = []
    private var testPopulars: [Popular] = []
    private var artists: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        createGradient()
        setupDelegates()
        setupCollectionViews()
        setupTableView()
        fetchHitsTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSegmentControlLayout()
        setupCollectionLayouts()
    }
}

// MARK: - Setup
extension HomeViewController {
    
    private func setupDelegates() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        hitCollectionView.delegate = self
        hitCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionViews() {
        let bannerNib = UINib(nibName: "BannerItem", bundle: .main)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: "cell1")
        
        let hitNib = UINib(nibName: "MusicCard", bundle: .main)
        hitCollectionView.register(hitNib, forCellWithReuseIdentifier: "cell2")
    }
    
    private func setupTableView() {
        let tableNib = UINib(nibName: "TableItem", bundle: .main)
        tableView.register(tableNib, forCellReuseIdentifier: "table_cell")
    }
    
    private func setupSegmentControlLayout() {
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: hitCollectionView.bottomAnchor, constant: 32),
            segmentControl.leadingAnchor.constraint(equalTo: hitCollectionView.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: hitCollectionView.trailingAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupCollectionLayouts() {
        if let bannerLayout = bannerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            bannerLayout.scrollDirection = .horizontal
            bannerLayout.itemSize = CGSize(width: bannerCollectionView.bounds.width, height: bannerCollectionView.bounds.height)
        }
        if let hitLayout = hitCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            hitLayout.scrollDirection = .horizontal
            hitLayout.itemSize = CGSize(width: 128, height: hitCollectionView.bounds.height)
            hitLayout.minimumInteritemSpacing = 16
        }
    }
    
    private func setupNavigationBar() {
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
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = segmentShadow.bounds
        gradient.colors = [
            UIColor.white.withAlphaComponent(0.0).cgColor,
            UIColor.white.withAlphaComponent(0.15).cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor,
            UIColor.white.withAlphaComponent(0.05).cgColor
        ]
        gradient.locations = [0.1, 0.3, 0.5]
        segmentShadow.layer.mask = gradient
    }
    
    private func fetchHitsTrack() {
        APIService.shared.getHits { result in
            switch result {
            case .success(let tracks):
                DispatchQueue.main.async {
                    self.tracks = tracks
                    self.hitCollectionView.reloadData()
                }
            case .failure(let error):
                print("Home error:", error)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return testPopulars.count
        } else {
            return tracks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BannerItem
            let popular = testPopulars[indexPath.row]
            cell.bindData(popular: popular)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! MusicCard
            let track = tracks[indexPath.row]
            cell.bindData(track: track)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hitCollectionView {
            let playSongVC = NowPlayingViewController(nibName: "NowPlayingViewController", bundle: nil)
            playSongVC.currentIdx = indexPath.row
            playSongVC.tracks = tracks
            navigationController?.pushViewController(playSongVC, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath) as! TableItem
        let artist = artists[indexPath.row]
        cell.bindData(name: "", image: UIImage(named: "Adele")!, numOfListeners: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artistVC = ArtistViewController(nibName: "ArtistViewController", bundle: nil)
        navigationController?.pushViewController(artistVC, animated: false)
    }
}
