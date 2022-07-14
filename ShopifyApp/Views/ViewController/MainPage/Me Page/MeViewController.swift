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
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
