//
//  HistoryViewController.swift
//  Spotify
//
//  Created by VanDoang on 03/09/2025.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var navShadow: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //sample code
//    let song = Song(id: "", title: "Hello", lyrics: "", releaseDate: Date.now, genre: "", duration: 120, image: UIImage(named: "Adele"), author: "Adele")
//    var playlist = Playlist(id: "", name: "Happiers", numOfSongs: 9, image: UIImage(named: "test_hit"))
    var playlists: [Playlist] = []
    let titles: [String] = ["Today", "Yesterday", "2 days ago"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        createGradient()
//        playlist.songs = [song, song, song, song, song]
//        playlists = [playlist, playlist, playlist]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let songNib = UINib(nibName: "MusicViewCell", bundle: .main)
        let playlistNib = UINib(nibName: "PlaylistViewCell", bundle: .main)
        
        tableView.register(CustomSectionHeader.self, forHeaderFooterViewReuseIdentifier: "section_cell")
        tableView.register(songNib, forCellReuseIdentifier: "song_cell")
        tableView.register(playlistNib, forCellReuseIdentifier: "playlist_cell")
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

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "section_cell") as! CustomSectionHeader
        header.setTitle(with: titles[section])
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + playlists[section].songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playlist_cell") as! PlaylistViewCell
            let playlist = playlists[indexPath.section]
            cell.bindData(playlist: playlist)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "song_cell") as! MusicViewCell
            let song: SpotifyTrack = playlists[indexPath.section].songs[indexPath.row - 1]
            cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            cell.bindData(label1: "", label2: "", iv: UIImage(named: "Adele")!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playSongVC = NowPlayingViewController(nibName: "NowPlayingViewController", bundle: nil)
        navigationController?.pushViewController(playSongVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 92 : 76
    }
}
