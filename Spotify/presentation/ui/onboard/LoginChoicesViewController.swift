//
//  LoginChoicesViewController.swift
//  Spotify
//
//  Created by VanDoang on 28/08/2025.
//

import UIKit

class LoginChoicesViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGradient()
        addButtons()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        let appIcon = UIImageView(image: UIImage(named: "app_icon"))
        appIcon.contentMode = .scaleAspectFit
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back_press"))
        
        navigationItem.titleView = appIcon
        navigationItem.backBarButtonItem = backIcon
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func addButtons() {
        let btnPhone = CustomButton (title: "Continue with phone number", image: UIImage(named: "phone")!)
        let btnGoogle = CustomButton (title: "Continue with Google", image: UIImage(named: "google")!)
        let btnFacebook = CustomButton (title: "Continue with Facebook", image: UIImage(named: "facebook")!)


        btnPhone.translatesAutoresizingMaskIntoConstraints = false
        btnGoogle.translatesAutoresizingMaskIntoConstraints = false
        btnFacebook.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnPhone)
        view.addSubview(btnGoogle)
        view.addSubview(btnFacebook)

        NSLayoutConstraint.activate([
            btnPhone.leadingAnchor.constraint(equalTo: btnSignUp.leadingAnchor),
            btnPhone.trailingAnchor.constraint(equalTo: btnSignUp.trailingAnchor),
            btnPhone.topAnchor.constraint(equalTo: btnSignUp.bottomAnchor, constant: 12),
            btnPhone.heightAnchor.constraint(equalTo: btnSignUp.heightAnchor),

            btnGoogle.leadingAnchor.constraint(equalTo: btnSignUp.leadingAnchor),
            btnGoogle.trailingAnchor.constraint(equalTo: btnSignUp.trailingAnchor),
            btnGoogle.topAnchor.constraint(equalTo: btnPhone.bottomAnchor, constant: 12),
            btnGoogle.heightAnchor.constraint(equalTo: btnSignUp.heightAnchor),

            btnFacebook.leadingAnchor.constraint(equalTo: btnSignUp.leadingAnchor),
            btnFacebook.trailingAnchor.constraint(equalTo: btnSignUp.trailingAnchor),
            btnFacebook.topAnchor.constraint(equalTo: btnGoogle.bottomAnchor, constant: 12),
            btnFacebook.heightAnchor.constraint(equalTo: btnSignUp.heightAnchor),

            btnLogin.topAnchor.constraint(equalTo: btnFacebook.bottomAnchor, constant: 16)
        ])
    }
    
    private func createGradient () {
        let gradient = CAGradientLayer()
        gradient.frame = background.bounds
        gradient.colors = [    UIColor.white.withAlphaComponent(0.0).cgColor,
                               UIColor.white.withAlphaComponent(0.5).cgColor,
                               UIColor.white.withAlphaComponent(0.8).cgColor,
                               UIColor.white.withAlphaComponent(0.8).cgColor,
                               UIColor.white.withAlphaComponent(0.5).cgColor,
                               UIColor.white.withAlphaComponent(0.0).cgColor ]
        gradient.locations = [0.1, 0.2, 0.3, 0.8, 0.9, 1.0]
        background.layer.mask = gradient
    }

}
