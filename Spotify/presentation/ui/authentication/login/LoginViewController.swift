//
//  LoginViewController.swift
//  Spotify
//
//  Created by VanDoang on 25/08/2025.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var tfForgotPassword: UILabel!
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfPassword: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpTextFields()
    }
    
    private func setUpTextFields () {
        tfEmail.placeholder = "Enter Username Or Email"
        tfEmail.isPasswordField = false
        tfPassword.placeholder = "Password"
        tfPassword.isPasswordField = true
    }
    
    private func setUpNavigationBar () {
        let appIcon = UIImageView(image: UIImage(named: "app_icon"))
        appIcon.contentMode = .scaleAspectFit
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back_press"))
        
        navigationItem.titleView = appIcon
        navigationItem.backBarButtonItem = backIcon
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    
}
