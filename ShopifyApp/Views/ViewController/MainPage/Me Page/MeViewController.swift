//
//  MeViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 12/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    @IBOutlet weak var welcomeName: UILabel!
    
    @IBOutlet weak var ordersPrice: UILabel!
    
    @IBOutlet weak var ordersTime: UILabel!
    
    @IBAction func ordersMore(_ sender: Any) {
    }
    
    @IBAction func wishlistMore(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.favourites.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.favourites.rawValue) as! FavoritesViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.login.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.login.rawValue) as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.register.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.register.rawValue) as! RegisterViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        
        let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
        
    }
    
    @IBAction func cartButtonAction(_ sender: Any) {
        
        let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        //VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
        
    }
    
}
