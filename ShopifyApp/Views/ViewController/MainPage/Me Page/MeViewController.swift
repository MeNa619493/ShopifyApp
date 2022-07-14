//
//  MeViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 12/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MeViewController: UIViewController{
    var favoritesArray = [Product]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favoritesViewModel: FavoritesViewModel?
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    
    @IBOutlet weak var welcomeName: UILabel!

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
    
    @IBOutlet weak var favouritesCV: UICollectionView!{
        didSet {
            favouritesCV.delegate = self
            favouritesCV.dataSource = self
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        favoritesViewModel = FavoritesViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard Connectivity.shared.isConnectedToInternet() else {
            self.showAlertForInterNetConnection()
            return
        }
        
//        if !UserDefaultsManager.shared.getUserStatus() {
//            self.showAlertError(title: "Alert", message: "You must login")
//            return
//        }
        
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
        favoritesViewModel?.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
                DispatchQueue.main.async {
                    self.favouritesCV.reloadData()
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
        }
        favoritesViewModel?.fetchfavorites(appDelegate: appDelegate, userId: UserDefaultsManager.shared.getUserID() ?? 1)
    }
    func registerNibFile() {
        favouritesCV.register(UINib(nibName: "MiniProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MiniProductCellID")
        
        print ("line 90 - Favorites array count \(favoritesArray.count)")

    }
    


    // MARK: - Navigation

    }

extension MeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesArray.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniProductCellID", for: indexPath) as! MiniProductCollectionViewCell
            cell.favouritesView = self
            cell.configureCell(product: favoritesArray[indexPath.row], isFavourite: true, isInFavouriteScreen: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfoVC = UIStoryboard(name: Storyboards.productInfo.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.productInfo.rawValue) as! ProductInfoViewController
        productInfoVC.productId = favoritesArray[indexPath.row].id
        productInfoVC.modalPresentationStyle = .fullScreen
        self.present(productInfoVC, animated: true, completion: nil)
    }
}

extension MeViewController: FavoriteActionFavoritesScreen {
    func deleteFavourite(appDelegate: AppDelegate, product: Product) {
        favoritesViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
        favoritesArray = favoritesArray.filter { $0.id != product.id }
        favouritesCV.reloadData()
    }
}
