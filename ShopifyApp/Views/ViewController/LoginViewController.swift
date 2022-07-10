//
//  LoginViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loginViewModel = LoginViewModel(networkManager: NetworkManager())
    }
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
        login()
    }
    
    @IBAction func onRegisterButtonPressed(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.register.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.register.rawValue) as! RegisterViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupView() {
        email.layer.cornerRadius = 15
        email.layer.borderWidth = 2
        password.layer.cornerRadius = 15
        password.layer.borderWidth = 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController {
    func login(){
        guard let email = email.text, !email.isEmpty, let password = password.text, !password.isEmpty else {
            self.showAlertError(title: "Missing Information", message: "to login you must fill all the information below.")
            return
        }
        
        loginViewModel?.Login(email: email, password: password) { customerLogged in
            
            if customerLogged != nil {
                UserDefaultsManager.shared.setUserStatus(userIsLogged: true)
                print("customer logged in successfully")
                //Navigation
            }else{
                UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
                print("failed to login")
            }
        }
    }
}
