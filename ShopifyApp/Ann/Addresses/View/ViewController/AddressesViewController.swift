//
//  AddressesViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 10/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class AddressesViewController: UIViewController {
    
    @IBOutlet weak var phoneTFOutlet: UITextField!
    @IBOutlet weak var countryTFOutlet: UITextField!
    @IBOutlet weak var cityTFOutlet: UITextField!
    @IBOutlet weak var addressTFOutlet: UITextField!
    
    var totalPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func backButtonOutlet(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        
        guard !(phoneTFOutlet.text?.isEmpty ?? false) else {
            
            print("phoneTFOutlet is empty")
            let alert = UIAlertController(title: "Warrning", message: "please, enter your phone", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        guard !(countryTFOutlet.text?.isEmpty ?? false) else {
            
            print("countryTFOutlet is empty")
            let alert = UIAlertController(title: "Warrning", message: "please, enter your country", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        guard !(cityTFOutlet.text?.isEmpty ?? false) else {
            
            print("cityTFOutlet is empty")
            let alert = UIAlertController(title: "Warrning", message: "please, enter your city", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        guard !(addressTFOutlet.text?.isEmpty ?? false) else {
            
            print("addressTFOutlet is empty")
            let alert = UIAlertController(title: "Warrning", message: "please, enter your address", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        print("All feilds is not empty")
        
        let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        VC.modalPresentationStyle = .fullScreen
        VC.totalPrice = self.totalPrice
        self.present(VC, animated: false, completion: nil)
        
    }
    
    @IBAction func AddressListButtonAction(_ sender: Any) {
        
        let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "AddressListViewController") as! AddressListViewController
        VC.totalPrice = totalPrice
        self.present(VC, animated: false, completion: nil)
        
    }
    
    
}
