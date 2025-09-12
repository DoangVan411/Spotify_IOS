//
//  SceneDelegate.swift
//  Spotify
//
//  Created by V000223 on 25/08/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let loginViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.isNavigationBarHidden = false


        let tabBarController = CustomTabBarController()
        
        let nowPlayingViewController = ArtistViewController(nibName: "ArtistViewController", bundle: nil)
        let navController = UINavigationController(navigationBarClass: ArtistNavigationBar.self, toolbarClass: nil)
        navController.viewControllers = [ArtistViewController()]
        
        setUpNavigationBar()
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func setUpNavigationBar() {
        let appearance = UINavigationBar.appearance()
        
        appearance.backgroundColor = .black
        appearance.tintColor = .white
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

