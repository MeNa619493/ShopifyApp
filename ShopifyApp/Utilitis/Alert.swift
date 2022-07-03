//
//  Alert.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let Action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(Action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String, complition:@escaping (Bool)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "OK", style: .destructive) { _ in
            complition(true)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertForInterNetConnection(){
        let alert = UIAlertController(title: "Network Error", message: "please, check your internet connection.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
