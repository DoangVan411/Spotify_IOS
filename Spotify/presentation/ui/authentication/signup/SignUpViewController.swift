//
//  SignUpViewController.swift
//  Spotify
//
//  Created by V000223 on 29/08/2025.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfFullname: CustomTextField!
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfPassword: CustomTextField!
    @IBOutlet weak var tfConfirm: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpTextFields()
    }
    
    private func setUpTextFields () {
        tfFullname.placeholder = "Fullname"
        tfFullname.isPasswordField = false
        tfEmail.placeholder = "Email"
        tfEmail.isPasswordField = false
        tfPassword.placeholder = "Password"
        tfPassword.isPasswordField = true
        tfConfirm.placeholder = "Repeat password"
        tfConfirm.isPasswordField = true
    }
    
    private func setUpNavigationBar () {
        let appIcon = UIImageView(image: UIImage(named: "app_icon"))
        appIcon.contentMode = .scaleAspectFit
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back_press"))
        
        navigationItem.titleView = appIcon
        navigationItem.backBarButtonItem = backIcon
        navigationController?.navigationBar.barTintColor = .black
        
        appIcon.widthAnchor.constraint(equalToConstant: 133).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
