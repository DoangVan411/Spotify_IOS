//
//  NowPlayingViewController.swift
//  Spotify
//
//  Created by VanDoang on 09/09/2025.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {
    
    var tracks: [DeezerTrack] = []
    var currentIdx: Int = 0
    
    var nowPlayingViewModel: NowPlayingViewModel?
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var mediaControl: CustomMediaControl!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBarController = tabBarController as? CustomTabBarController {
            tabBarController.setTabBarHidden(true, animated: false)
        }
        
        let imageRepository = ImageRepositoryImpl()
        let getImageUseCase = GetImageUseCase(imageRepository: imageRepository)
        self.nowPlayingViewModel = NowPlayingViewModel(playerManager: PlayerManager.shared, tracks: self.tracks, getImageUseCase: getImageUseCase)
        
        setUpNavigationBar()
        setUpTrack(idx: currentIdx)
        setUpSlider()
        setUpActionForMediaControl()
        imageView.layer.cornerRadius = 32
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nowPlayingViewModel?.playTrack(track: tracks[currentIdx])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let tabBarController = tabBarController as? CustomTabBarController {
            tabBarController.setTabBarHidden(false, animated: false)
        }
    }
    
    private func setUpTrack(idx: Int) {
        guard tracks.indices.contains(currentIdx) else { return }
        let track = tracks[idx]
        self.lblName.text = track.title
        self.lblAuthor.text = track.artist.name
        guard let url = URL(string: track.album.cover ?? "") else { return }
        nowPlayingViewModel?.getImage(url: url) {image in
            self.imageView.image = image
        }
        
    }
    
    private func setUpActionForMediaControl () {
        mediaControl.onPlayTapped = {[weak self] in
            self?.nowPlayingViewModel?.togglePlayPause()
        }
        mediaControl.onPreviousTapped = {[weak self] in
            self?.nowPlayingViewModel?.playPreviousTrack()
        }
        mediaControl.onNextTapped = {[weak self] in
            self?.nowPlayingViewModel?.playNextTrack()
        }
    }
    
    private func changeTrack(track: DeezerTrack) {
//        appDelegate?.player = AVPlayer(url: URL(string: track.preview)!)
//        NowPlayingViewController.player = appDelegate?.player
//        NowPlayingViewController.player?.play()
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
//        guard let player = NowPlayingViewController.player else {
//             return
//        }
//        guard let duration = player.currentItem?.duration else { return }
//        let totalSeconds = CMTimeGetSeconds(duration)
//        print("Total seconds: ", totalSeconds)
//        print("Duration: ", duration)
//        guard !totalSeconds.isNaN else { return }
//        self.slider.value = 0
//        let minutes = Int(totalSeconds) / 60
//        let seconds = Int(totalSeconds) % 60
//        print("Duration: ", duration)
//        lblMax.text = String(format: "%02d:%02d", minutes, seconds)
//        slider.minimumValue = 0
//        slider.maximumValue = Float(totalSeconds)
//        
//        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
//        guard let player = NowPlayingViewController.player else {
//            return
//        }
//        let seconds = Int64(sender.value)
//        let targetTime: CMTime = CMTime(value: seconds, timescale: 1)
//        player.seek(to: targetTime)
//        NowPlayingViewController.player?.play()
//        mediaControl.playSongBtnClicked()
    }
    
    @objc func updateSlider() {
//        guard let player = NowPlayingViewController.player else {
//            return
//        }
//        let currentTimeBySecond = CMTimeGetSeconds(player.currentTime())
//        slider.value = Float(currentTimeBySecond)
//        lblMin.text = String(format: "%02d:%02d", Int(currentTimeBySecond) / 60, Int(currentTimeBySecond) % 60)
    }
}
