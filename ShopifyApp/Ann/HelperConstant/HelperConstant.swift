//
//  HelperConstant.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 12/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

//MARK:- HelperConstant
class HelperConstant: NSObject {
    
    //MARK:- userDefault
    static let userDefault = UserDefaults.standard
    
    //MARK:- Save Aceess Token
    class func saveTotal(access_token: String){
        
        userDefault.set(access_token, forKey: "totalPrice")
    }
    //MARK:- Get Aceess Token
    class func getTotal() -> String?{
        let defult = UserDefaults.standard
        
        return defult.object(forKey: "totalPrice") as? String
    }
    
    //MARK:- Save InitDefault AddressID
    class func saveInitDefaultAddresID(InitDefault: Int){
        
        userDefault.set(InitDefault, forKey: "InitDefault")
    }
    //MARK:- Get InitDefaultn AddressID
    class func getInitDefaultAddresID() -> Int?{
        let defult = UserDefaults.standard
        
        return defult.object(forKey: "InitDefault") as? Int
    }
    
    //MARK:- Save InitDefault AddressID
    class func saveDefaultAddresID(DefaultAddresID: Int){
        
        userDefault.set(DefaultAddresID, forKey: "DefaultAddresID")
    }
    //MARK:- Get InitDefaultn AddressID
    class func getDefaultAddresID() -> Int?{
        let defult = UserDefaults.standard
        
        return defult.object(forKey: "DefaultAddresID") as? Int
    }
    
    //MARK:- Save InitDefault AddressID
    class func setDefaultAddresID(SetDefaultAddresID: Int){
        
        userDefault.set(SetDefaultAddresID, forKey: "setDefaultAddresID")
    }
    //MARK:- Get InitDefaultn AddressID
    class func getsetDefaultAddresID() -> Int?{
        let defult = UserDefaults.standard
        
        return defult.object(forKey: "setDefaultAddresID") as? Int
    }
    
    //MARK:- Save DefaultCurrency
    class func saveSetDefaultCurrency(SetDefaultCurrency: String){
        
        userDefault.set(SetDefaultCurrency, forKey: "setDefaultCurrency")
    }
    //MARK:- Get DefaultCurrency
    class func getseDefaultCurrency() -> String?{
        let defult = UserDefaults.standard
        
        return defult.object(forKey: "setDefaultCurrency") as? String
    }
    
}
