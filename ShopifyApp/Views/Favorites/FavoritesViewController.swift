//
//  FavoritesViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/4/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView! {
        didSet {
            favoritesCollectionView.delegate = self
            favoritesCollectionView.dataSource = self
        }
    }
    
    var favoritesArray = [Product]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favoritesViewModel: FavoritesViewModel?
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    
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
        
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
        //should get user id from user defaults and use it here
        favoritesViewModel?.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
                DispatchQueue.main.async {
                    self.favoritesCollectionView.reloadData()
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
        }
        favoritesViewModel?.fetchfavorites(appDelegate: appDelegate, userId: 0)
    }
    
    func registerNibFile() {
        favoritesCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellID")
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! ProductCollectionViewCell
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

extension FavoritesViewController: FavoriteActionFavoritesScreen {
    func deleteFavourite(appDelegate: AppDelegate, product: Product) {
        favoritesViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
        favoritesArray = favoritesArray.filter { $0.id != product.id }
        favoritesCollectionView.reloadData()
    }
}
