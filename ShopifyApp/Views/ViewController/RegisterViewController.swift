//
//  RegisterViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var customerName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var registerViewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerViewModel = RegisterViewModel(networkManager: NetworkManager())
    }
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        //Navigation
    }
    
    @IBAction func onRegisterButtonPressed(_ sender: Any) {
        guard let name = customerName.text else {return}
        guard let emailText = email.text else {return}
        guard let password = password.text else {return}
        guard let confirmPass = confirmPassword.text else {return}
        if ValdiateCustomerInfomation(firstName: name, email: emailText, password: password, confirmPassword: confirmPass) {
            register(firstName: name, email: emailText, password: password, confirmPassword: confirmPass)
        } else {
            showAlertError(title: "Couldnot register", message: "Please try again later.")
        }
    }
    
    func setupView() {
        customerName.layer.cornerRadius = 15
        customerName.layer.borderWidth = 2
        email.layer.cornerRadius = 15
        email.layer.borderWidth = 2
        password.layer.cornerRadius = 15
        password.layer.borderWidth = 2
        confirmPassword.layer.cornerRadius = 15
        confirmPassword.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 15
    }
}

extension RegisterViewController {
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String) -> Bool{
            
        var isSuccess = true
        self.registerViewModel?.ValdiateCustomerInfomation(firstName: firstName, email: email, password: password, confirmPassword: confirmPassword) { message in
                
                switch message {
                case "ErrorAllInfoIsNotFound":
                    isSuccess = false
                    self.showAlertError(title: "Missing Information", message: "please, enter all the required information.")
                    
                case "ErrorPassword":
                    isSuccess = false
                    self.showAlertError(title: "Check Password", message: "please, enter password again.")
                    
                case "ErrorEmail":
                    isSuccess = false
                    self.showAlertError(title: "Invalid Email", message: "please, enter correct email.")
                    
                default:
                    isSuccess = true
                }
            }
        return isSuccess
    }
    
    func register(firstName: String, email: String, password: String, confirmPassword: String){
        
        let customer = Customer(first_name: firstName, email: email, tags: password, id: nil, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        self.registerViewModel?.createNewCustomer(newCustomer: newCustomer) { data, response, error in
                    
            guard error == nil else {
                DispatchQueue.main.async {
                    self.showAlertError(title: "Couldnot register", message: "Please, try again later.")
                }
                return
            }
            
            guard response?.statusCode != 422 else {
                DispatchQueue.main.async {
                    self.showAlertError(title: "Couldnot register", message: "Please, try another email.")
                }
                return
            }
                    
            print("registered successfully")
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
            
    }
    
}


