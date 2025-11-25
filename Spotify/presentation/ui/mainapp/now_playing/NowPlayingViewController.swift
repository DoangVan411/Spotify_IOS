//
//  NowPlayingViewController.swift
//  Spotify
//
//  Created by VanDoang on 09/09/2025.
//

import UIKit
import AVFoundation
import MediaPlayer

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
        print("Current idx view did load: \(currentIdx)")
        if let tabBarController = tabBarController as? CustomTabBarController {
            tabBarController.setTabBarHidden(true, animated: false)
        }
        
        let imageRepository = ImageRepositoryImpl()
        let getImageUseCase = GetImageUseCase(imageRepository: imageRepository)
        self.nowPlayingViewModel = NowPlayingViewModel(playerManager: PlayerManager.shared, tracks: self.tracks, getImageUseCase: getImageUseCase)
        
        setUpNavigationBar()
        nowPlayingViewModel?.currentIdx = currentIdx
        guard tracks.indices.contains(currentIdx) else { return }
        
        imageView.layer.cornerRadius = 32
        
        nowPlayingViewModel?.onTrackChanged = {[weak self] track in
            self?.setUpTrack(track: track)
        }
        
        let track = tracks[currentIdx]
        setUpTrack(track: track)
        setUpSlider()
        setUpActionForMediaControl()
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
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

    func updateNowPlaying(track: DeezerTrack, artwork: UIImage?) {
        guard let player = nowPlayingViewModel?.playerManager.player,
              let currentItem = player.currentItem else {
            print("Player or currentItem is nil")
            return
        }
        
        if currentItem.duration.seconds.isNaN {
            print("⏳ Duration chưa ready, đợi load...")
            
            // Observe khi duration ready
            let observer = currentItem.observe(\.duration, options: [.new]) { [weak self] item, _ in
                let duration = item.duration.seconds
                if !duration.isNaN && !duration.isInfinite {
                    print("✅ Duration ready: \(duration)")
                    self?.updateNowPlaying(track: track, artwork: artwork)
                }
            }
            
            return
        }
        
        let duration = currentItem.duration.seconds
        let currentTime = player.currentTime().seconds
        
        var info: [String: Any] = [
            MPMediaItemPropertyTitle: track.title,
            MPMediaItemPropertyArtist: track.artist.name,
            MPMediaItemPropertyPlaybackDuration: duration,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: currentTime,
            MPNowPlayingInfoPropertyPlaybackRate: Double(player.rate)
        ]
        
        if let image = artwork {
            info[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { _ in image }
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
        
        print("✅ Now Playing updated:")
        print("   Title: \(track.title)")
        print("   Duration: \(duration)")
        print("   Current: \(currentTime)")
        print("   Rate: \(player.rate)")
    }
    
    private func setUpTrack(track: DeezerTrack) {
        self.lblName.text = track.title
        self.lblAuthor.text = track.artist.name
        guard let url = URL(string: track.album.cover ?? "") else { return }
        nowPlayingViewModel?.getImage(url: url) {image in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.updateNowPlaying(track: track, artwork: image)
            }
        }
        
    }
    
    private func setUpActionForMediaControl () {
        mediaControl.onPlayTapped = {[weak self] in
            guard self?.nowPlayingViewModel?.togglePlayPause() == true else {
                self?.mediaControl.pauseSongBtnClicked()
                return
            }
            self?.mediaControl.playSongBtnClicked()
        }
        mediaControl.onPreviousTapped = {
            self.nowPlayingViewModel?.playPreviousTrack()
        }
        mediaControl.onNextTapped = {
            self.nowPlayingViewModel?.playNextTrack()
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
        guard let player = nowPlayingViewModel?.playerManager.player else {
             return
        }
        guard let duration = player.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        print("Total seconds: ", totalSeconds)
        print("Duration: ", duration)
        guard !totalSeconds.isNaN else { return }
        self.slider.value = 0
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        print("Duration: ", duration)
        lblMax.text = String(format: "%02d:%02d", minutes, seconds)
        slider.minimumValue = 0
        slider.maximumValue = Float(totalSeconds)
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        guard let player = nowPlayingViewModel?.playerManager.player else {
            return
        }
        let seconds = Int64(sender.value)
        let targetTime: CMTime = CMTime(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        player.play()
        mediaControl.playSongBtnClicked()
    }
    
    @objc func updateSlider() {
        guard let player = nowPlayingViewModel?.playerManager.player else {
            return
        }
        let currentTimeBySecond = CMTimeGetSeconds(player.currentTime())
        slider.value = Float(currentTimeBySecond)
        lblMin.text = String(format: "%02d:%02d", Int(currentTimeBySecond) / 60, Int(currentTimeBySecond) % 60)
    }
}
