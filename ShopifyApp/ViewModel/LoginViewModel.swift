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
            guard error == nil else {return}
            guard let customers = customers else {return}
            var currentCustomer: Customer?
            
            for customer in customers {
                if customer.email == email && customer.tags == password {
                    currentCustomer = customer
                }
            }
            
            if currentCustomer != nil{
                guard let customerID = currentCustomer?.id else {return}
                guard let userFirstName = currentCustomer?.first_name else {return}
                guard let userEmail = currentCustomer?.email  else {return}

                self.userDefaults.setUserID(customerID: customerID)
                self.userDefaults.setUserName(userName: userFirstName)
                self.userDefaults.setUserEmail(userEmail: userEmail)

                completion(currentCustomer)
            } else {
                completion(nil)
            }
        }
    }
    
}
