
//
//  LyricsViewController.swift
//  Spotify
//
//  Created by V000223 on 09/09/2025.
//

import UIKit

class LyricsViewController: UIViewController {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //samples
    let lyrics = ["Masih jelas teringat (jelas teringat) pelukanmu yang hangat", "Masih jelas teringat (jelas teringat) pelukanmu yang hangat", "Masih jelas teringat (jelas teringat) pelukanmu yang hangat", "Seakan semua tak mungkin menghilang (menghilang)", "Mengapa masih ada", "Di saat kau pergi begitu saja? (Begitu saja)", "Mampukah ku bertahan", "Tanpa hadirmu, sayang?", "Tanpa hadirmu, sayang?", "Tanpa hadirmu, sayang?", "Tanpa hadirmu, sayang?", "Masih jelas teringat (jelas teringat) pelukanmu yang hangat", "Masih jelas teringat (jelas teringat) pelukanmu yang hangat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let lyricNib = UINib(nibName: "LyricsViewCell", bundle: .main)
        tableView.register(lyricNib, forCellReuseIdentifier: "cell")
    }
    
    private func setUpUI() {
        songImage.layer.cornerRadius = songImage.frame.width / 2
        songImage.clipsToBounds = true
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Adele"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Montserrat-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
}

extension LyricsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LyricsViewCell
        cell.bindData(lyric: lyrics[indexPath.row])
        cell.forceClearAllBackgrounds()
        return cell
    }
    
    
}
