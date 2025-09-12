//
//  CustomTabBar.swift
//  Spotify
//
//  Created by V000223 on 03/09/2025.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private var indicatorLayer: CAShapeLayer!
    let centerButton = UIButton(type: .custom)

    private func setupIndicator() {
        indicatorLayer = CAShapeLayer()
        indicatorLayer.fillColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1.0).cgColor
        tabBar.layer.addSublayer(indicatorLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        setUpViewControllers()
        setupIndicator()
        setupCenterButton()
    }
    
    init () {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateIndicatorPosition()
    }
    
    private func setUpTabBar() {
        tabBar.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        tabBar.tintColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = true
        tabBar.barStyle = .black
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateIndicatorPosition()
    }

    private func setUpViewControllers() {
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNavi = UINavigationController(rootViewController: homeViewController)
        homeNavi.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home_gray")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_green")?.withRenderingMode(.alwaysOriginal)
        )
        
        let playlistViewController = PlaylistViewController(nibName: "PlaylistViewController", bundle: nil)
        let playlistNavi = UINavigationController(rootViewController: playlistViewController)
        playlistNavi.tabBarItem = UITabBarItem(
            title: "Playlist",
            image: UIImage(named: "music-filter")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "music-filter_green")?.withRenderingMode(.alwaysOriginal)
        )
        
        let historyViewController = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        let historyNavi = UINavigationController(rootViewController: historyViewController)
        historyNavi.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(named: "clock")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "clock_green")?.withRenderingMode(.alwaysOriginal)
        )
        
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let profileNavi = UINavigationController(rootViewController: profileViewController)
        profileNavi.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile_gray")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        )
        
        let navigationController = UINavigationController()
        
        viewControllers = [homeNavi, playlistNavi, navigationController, historyNavi, profileNavi]
        selectedIndex = 0
    }
    
    private func updateIndicatorPosition() {
        guard let selectedItem = tabBar.selectedItem else { return }
        let tabBarItems = tabBar.items ?? []
        
        if let index = tabBarItems.firstIndex(of: selectedItem) {
            let itemWidth = tabBar.frame.width / CGFloat(tabBarItems.count)
            let targetX = itemWidth * CGFloat(index) + itemWidth / 2
            
            let ellipseWidth: CGFloat = 24
            let ellipseHeight: CGFloat = 8
            let rect = CGRect(
                x: targetX - ellipseWidth/2,
                y: tabBar.bounds.minY,
                width: ellipseWidth,
                height: ellipseHeight
            )
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY),
                controlPoint: CGPoint(x: rect.midX, y: rect.minY + ellipseHeight)
            )
            path.close()
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = indicatorLayer.path
            animation.toValue = path.cgPath
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            indicatorLayer.add(animation, forKey: "pathAnimation")
            indicatorLayer.path = path.cgPath
        }
    }

    
    private func setupCenterButton() {
        centerButton.layer.cornerRadius = 30
        centerButton.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        
        if let spotifyIcon = UIImage(named: "spotify_icon") {
            centerButton.setImage(spotifyIcon, for: .normal)
            centerButton.imageView?.contentMode = .scaleAspectFit
        }
        
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        centerButton.layer.shadowRadius = 5
        centerButton.layer.shadowOpacity = 0.3
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        view.addSubview(centerButton)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerButton.widthAnchor.constraint(equalToConstant: 64),
            centerButton.heightAnchor.constraint(equalToConstant: 64),
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -16)
        ])
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        tabBar.isHidden = hidden
        centerButton.isHidden = hidden
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func centerButtonTapped() {
        print("Center button tapped!")
    }
}

class CustomTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}
