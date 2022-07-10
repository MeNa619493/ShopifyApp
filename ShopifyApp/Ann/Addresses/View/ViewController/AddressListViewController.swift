//
//  AddressListViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 10/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {
    
    @IBOutlet weak var AddressesListTableView: UITableView!
    
    var totalPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAndConfigureCartTableView()
        
    }
    
    func setupAndConfigureCartTableView() {
        
        AddressesListTableView.register(UINib(nibName: "AddressListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressListTableViewCell")
        
        AddressesListTableView.separatorStyle = .none
        
        let frame = CGRect(x: 0, y: 0, width: AddressesListTableView.frame.size.width, height: 1)
        AddressesListTableView.tableFooterView = UIView(frame: frame)
        AddressesListTableView.tableHeaderView = UIView(frame: frame)
        
        AddressesListTableView.contentInset.top = 40
        
        AddressesListTableView.delegate = self
        AddressesListTableView.dataSource = self
        
    }
    
}

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = AddressesListTableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell", for: indexPath) as? AddressListTableViewCell else { return UITableViewCell() }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
