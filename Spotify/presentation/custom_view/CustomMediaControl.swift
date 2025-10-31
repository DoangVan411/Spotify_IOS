//
//  CustomMediaControl.swift
//  Spotify
//
//  Created by VanDoang on 09/09/2025.
//

import UIKit

class CustomMediaControl: UIView {
    
    var onRewindTapped: (() -> Void)?
    var onPreviousTapped: (() -> Void)?
    var onPlayTapped: (() -> Void)?
    var onNextTapped: (() -> Void)?
    var onShuffleTapped: (() -> Void)?
    
    private let btnRewind = UIButton(type: .system)
    private let btnPrevious = UIButton(type: .system)
    private let btnPlay = UIButton(type: .system)
    private let btnNext = UIButton(type: .system)
    private let btnShuffle = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        backgroundColor = .clear
        let buttonSize: CGFloat = 24
        
        btnPlay.imageView?.contentMode = .scaleAspectFit
        btnPlay.contentHorizontalAlignment = .center
        btnPlay.contentVerticalAlignment = .center
        
        btnRewind.setImage(UIImage(named: "repeat_one")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnPrevious.setImage(UIImage(named: "previous")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnPlay.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnNext.setImage(UIImage(named: "next")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnShuffle.setImage(UIImage(named: "shuffle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        [btnRewind, btnPrevious, btnPlay, btnNext, btnShuffle].forEach { btn in
            btn.backgroundColor = .clear
            btn.translatesAutoresizingMaskIntoConstraints = false
            addSubview(btn)
        }
        
        btnRewind.addTarget(self, action: #selector(rewindAction), for: .touchUpInside)
        btnPrevious.addTarget(self, action: #selector(previousAction), for: .touchUpInside)
        btnPlay.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        btnShuffle.addTarget(self, action: #selector(shuffleAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            btnRewind.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnRewind.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnRewind.widthAnchor.constraint(equalToConstant: buttonSize),
            btnRewind.heightAnchor.constraint(equalToConstant: buttonSize),
            
            btnPrevious.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnPrevious.leadingAnchor.constraint(equalTo: btnRewind.trailingAnchor, constant: 32),
            btnPrevious.widthAnchor.constraint(equalToConstant: buttonSize),
            btnPrevious.heightAnchor.constraint(equalToConstant: buttonSize),
            
            btnPlay.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnPlay.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnPlay.widthAnchor.constraint(equalToConstant: 64),
            btnPlay.heightAnchor.constraint(equalToConstant: 64),
            
            btnNext.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnNext.leadingAnchor.constraint(equalTo: btnPlay.trailingAnchor, constant: 20),
            btnNext.widthAnchor.constraint(equalToConstant: buttonSize),
            btnNext.heightAnchor.constraint(equalToConstant: buttonSize),
            
            btnShuffle.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnShuffle.leadingAnchor.constraint(equalTo: btnNext.trailingAnchor, constant: 32),
            btnShuffle.trailingAnchor.constraint(equalTo: trailingAnchor),
            btnShuffle.widthAnchor.constraint(equalToConstant: buttonSize),
            btnShuffle.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    @objc private func rewindAction() { onRewindTapped?() }
    @objc private func previousAction() { onPreviousTapped?() }
    @objc private func playAction() {
        onPlayTapped?()
    }
    @objc private func nextAction() { onNextTapped?() }
    @objc private func shuffleAction() { onShuffleTapped?() }
    
    func playSongBtnClicked () {
        self.btnPlay.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func pauseSongBtnClicked() {
        self.btnPlay.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
