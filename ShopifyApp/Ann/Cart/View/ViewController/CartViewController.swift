//
//  CartViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 05/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//
//let viewController = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartViewController")
import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAndConfigureCartTableView()
        
    }
    
    func setupAndConfigureCartTableView() {
        
        cartTableView.register(UINib(nibName: "CartProductTableViewCell", bundle: nil), forCellReuseIdentifier: "CartProductTableViewCell")
        cartTableView.register(UINib(nibName: "SubTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "SubTotalTableViewCell")
        cartTableView.register(UINib(nibName: "ProceedToCheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "ProceedToCheckoutTableViewCell")
        
        cartTableView.separatorStyle = .none
        
        let frame = CGRect(x: 0, y: 0, width: cartTableView.frame.size.width, height: 1)
        cartTableView.tableFooterView = UIView(frame: frame)
        cartTableView.tableHeaderView = UIView(frame: frame)
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartProductTableViewCell", for: indexPath) as? CartProductTableViewCell else { return UITableViewCell() }
            
            return cell
            
        }else if indexPath.section == 1 {
            
            guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "SubTotalTableViewCell", for: indexPath) as? SubTotalTableViewCell else { return UITableViewCell() }
            
            return cell
            
        }else if indexPath.section == 2 {
            
            guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "ProceedToCheckoutTableViewCell", for: indexPath) as? ProceedToCheckoutTableViewCell else { return UITableViewCell() }
            
            cell.PorceedButtonTapped = { [weak self] in
                
                guard let self = self else { return }
                
                let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
                VC.modalPresentationStyle = .fullScreen
                self.present(VC, animated: false, completion: nil)
                
            }
            
            return cell
            
        }else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }else if indexPath.section == 1 {
            return 50
        }else if indexPath.section == 2 {
            return 80
        }else {
            return 0
        }
    }
    
}
