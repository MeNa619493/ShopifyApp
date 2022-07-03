//
//  RegisterViewModel.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class RegisterViewModel{
    
    let networkManager: ApiService?
    let userDefaults = UserDefaultsManager()
    
    init(networkManager: ApiService) {
        self.networkManager = networkManager
    }
    
    
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String, compeltion: @escaping (String?) ->Void){
        
        if firstName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            compeltion("ErrorAllInfoIsNotFound")
            return
        }
        
        if !isValidEmail(email) {
            compeltion("ErrorEmail")
            return
        }
        
        if !isValidPassword(password: password, confirmPassword: confirmPassword) {
            compeltion("ErrorPassword")
            return
        }
    }
    
    func createNewCustomer(newCustomer: NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        networkManager?.register(newCustomer: newCustomer) { data, response, error in
            if error == nil {
                guard let data = data else {return}
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                let customer = json["customer"] as? Dictionary<String,Any>
                let customerID = customer?["id"] as? Int ?? 0
                let customerFirstName = customer?["first_name"] as? String ?? ""
                let customerEmail = customer?["email"] as? String ?? ""
                self.userDefaults.setUserID(customerID: customerID)
                self.userDefaults.setUserName(userName: customerFirstName)
                self.userDefaults.setUserEmail(userEmail: customerEmail)
                self.userDefaults.setUserStatus(userIsLogged: true)
                completion(data, response, nil)
            }else{
                completion(nil, nil, error)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String, confirmPassword: String) -> Bool{
        return !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
}
