//
//  LoginViewModel.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LoginViewModel {
    let networkManager: ApiService?
    let userDefaults = UserDefaultsManager()
       
    init(networkManager: ApiService) {
        self.networkManager = networkManager
    }
    
    func Login(email: String, password: String, completion: @escaping (Customer?)-> Void){
        networkManager?.getCustomers(email: email){ customers, error in
            guard error != nil else {return}
            guard let customers = customers else {return}
            let filetredCustomers = customers.filter { customer in
                return customer.email == email && customer.tags == password
            }
            
            if filetredCustomers.count != 0{
                guard let customerID = filetredCustomers[0].id else {return}
                guard let userFirstName = filetredCustomers[0].first_name else {return}
                guard let userEmail = filetredCustomers[0].email  else {return}
                
                self.userDefaults.setUserID(customerID: customerID)
                self.userDefaults.setUserName(userName: userFirstName)
                self.userDefaults.setUserEmail(userEmail: userEmail)
                
                completion(filetredCustomers[0])
            } else {
                completion(nil)
            }
        }
    }
    
}
