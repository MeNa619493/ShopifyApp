//
//  SettingViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 05/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        settingViewModel.fetchData()
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.settingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        let item = settingViewModel.settingData[indexPath.row]
        
        cell.imageNameOutlet.image = UIImage(systemName: item.imageName ?? "")
        cell.titleLabelOutlet.text = item.title ?? ""
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0:
            
            let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "AddressesViewController") as! AddressesViewController
            VC.modalPresentationStyle = .fullScreen
            //VC.totalPrice = self.totalPrice
            self.present(VC, animated: false, completion: nil)
            
        case 1:
            
            let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
            VC.modalPresentationStyle = .fullScreen
            //VC.totalPrice = self.totalPrice
            self.present(VC, animated: false, completion: nil)
            
        case 2:
            
            let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "AddressesViewController") as! AddressesViewController
            VC.modalPresentationStyle = .fullScreen
            //VC.totalPrice = self.totalPrice
            self.present(VC, animated: false, completion: nil)
            
        case 3:
            
            let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "AddressesViewController") as! AddressesViewController
            VC.modalPresentationStyle = .fullScreen
            //VC.totalPrice = self.totalPrice
            self.present(VC, animated: false, completion: nil)
            
        default:
            break
            
        }
    }
    
}

