//
//  ProductViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //ProductCellID
    var brandTitle = ""
    var productsArray = [Product]()
    var productsViewModel: ProductsViewModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    @IBOutlet weak var ProductsCollectionView: UICollectionView!{
        didSet {
                ProductsCollectionView.delegate = self
                ProductsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard Connectivity.shared.isConnectedToInternet() else {
            self.showAlertForInterNetConnection()
            return
        }
        
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
        productsViewModel = ProductsViewModel()
        productsViewModel?.fetchProducts(endPoint: "products.json", brandTitle: brandTitle)
        productsViewModel?.bindingData = { [self] products, error in
                if let products = products {
                    self.productsArray = products
                    DispatchQueue.main.async {
                        self.ProductsCollectionView.reloadData()
                        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                    }
                }
            
                if let error = error {
                    print(error.localizedDescription)
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
    }
    
    func registerNibFile() {
        ProductsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellID")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productsArray.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! ProductCollectionViewCell
        cell.productsView = self
        let isFavorite = productsViewModel!.getProductsInFavourites(appDelegate: appDelegate, product: productsArray[indexPath.row])
        cell.configureCell(product: productsArray[indexPath.row], isFavourite: isFavorite)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productInfoVC = UIStoryboard(name: Storyboards.productInfo.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.productInfo.rawValue) as! ProductInfoViewController
        productInfoVC.productId = productsArray[indexPath.row].id
        productInfoVC.modalPresentationStyle = .fullScreen
        self.present(productInfoVC, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ProductViewController: FavouriteActionProductScreen {
    func addFavourite(appDelegate: AppDelegate, product: Product) {
        productsViewModel?.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Product) {
        productsViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
    }
}

extension ProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        productsViewModel?.search(searchInput: searchText)
    }
}

 
