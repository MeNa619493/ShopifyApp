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
    
    var totalPrice: Double?
    
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

extension CartViewController {
    
    // to get events data from server
//    private func getData() {
//        
//        let url = "https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/carts.json"
//        
//        guard let endPoint = URL(string: url) else { return }
//        
//        
//        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
//                    if let error = error {
//                        
//                        print(error)
//                        
//                        return
//                    }
//                    
//                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                        
//                        print("invalid url")
//                        
//                        return
//                    }
//                    
//                    guard let data = data else{
//                        
//                        print("invalid data")
//                        
//                        return
//                    }
//                    
//                    do {
//                        
//                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//                        let events = try decoder.decode(EventsModel.self, from: data)
//                        print(events)
//                        
//                        self.eventsData = events.events ?? []
//                        print("league Data model : \(self.eventsData)")
//                        
//                        DispatchQueue.main.async { [weak self] in
//                            guard let self = self else  { return }
//                            self.detailsTableView.reloadData()
//                        }
//                        
//                        
//                    } catch {
//                        
//                        print(error)
//                        
//                    }
//                }
//                task.resume()
//        
//    }
    
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
            
            cell.MinusTapped = { [weak self] in
                guard let self = self else { return }
                
                // to calculate time
                let dispatchAfter = DispatchTimeInterval.seconds(Int(1))  //0.1
                //To call or execute function after some time(After sec)
                DispatchQueue.main.asyncAfter(deadline: .now() + dispatchAfter) { [weak self] in
                    guard let self = self else { return }
                    
                    if  (Int(cell.countLabelOutlet.text ?? "0") ?? 0) != 1 {
                        cell.countLabelOutlet.text = String((Int(cell.countLabelOutlet.text ?? "0") ?? 0) - 1)
                        
                        // call function => send quantity to server
                        
                    }
                    
                }
                
            }
            
            cell.plusTapped = { [weak self] in
                guard let self = self else { return }
                
                // to calculate time
                let dispatchAfter = DispatchTimeInterval.seconds(Int(1)) //0.1
                //To call or execute function after some time(After sec)
                DispatchQueue.main.asyncAfter(deadline: .now() + dispatchAfter) { [weak self] in
                    guard let self = self else { return }
                    
                    cell.countLabelOutlet.text = String((Int(cell.countLabelOutlet.text ?? "0") ?? 0) + 1)
                    
                }
                
            }
            
            return cell
            
        }else if indexPath.section == 1 {
            
            guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "SubTotalTableViewCell", for: indexPath) as? SubTotalTableViewCell else { return UITableViewCell() }
            
//            let item = CartModel[indexPath.row]
//
//            let totalPrice = item.map { Int($0.price ?? 0 * $0.quantity) }.reduce(0, +)
//
//            cell.textLabel?.text = "\(totalPrice)"
            
            return cell
            
        }else if indexPath.section == 2 {
            
            guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "ProceedToCheckoutTableViewCell", for: indexPath) as? ProceedToCheckoutTableViewCell else { return UITableViewCell() }
            
            cell.PorceedButtonTapped = { [weak self] in
                
                guard let self = self else { return }
                
                let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "AddressesViewController") as! AddressesViewController
                VC.modalPresentationStyle = .fullScreen
                VC.totalPrice = self.totalPrice
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
