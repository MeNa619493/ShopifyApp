//
//  CategoriesViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 10/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var productsArray = [Product]()
    var categoriesViewModel: CategoriesViewModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    @IBOutlet weak var productsCV: UICollectionView!{
        didSet {
            productsCV.delegate = self
            productsCV.dataSource = self
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
        
        categoriesViewModel = CategoriesViewModel()
        categoriesViewModel?.fetchProducts(endPoint: "products.json")
        categoriesViewModel?.bindingData = { products, error in
            if let products = products{
                self.productsArray = products
                DispatchQueue.main.async {
                    self.productsCV.reloadData()
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
          
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func registerNibFile() {
        productsCV.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellID")
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCV.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! ProductCollectionViewCell
        cell.productsView = self
        let isFavorite = categoriesViewModel!.getProductsInFavourites(appDelegate: appDelegate, product: productsArray[indexPath.row])
        cell.configureCell(product: productsArray[indexPath.row], isFavourite: isFavorite)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfoVC = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "MProductInfoVC") as! ProductInfoViewController
        productInfoVC.productId = productsArray[indexPath.row].id
        productInfoVC.modalPresentationStyle = .fullScreen
        self.present(productInfoVC, animated: true, completion: nil)
    }
    
    @IBAction func women(_ sender: Any) {
        categoriesViewModel?.selectedWomenCategory()
    }
    
    @IBAction func men(_ sender: Any) {
       categoriesViewModel?.selectedMenCategory()
    }
    
    @IBAction func kids(_ sender: Any) {

        categoriesViewModel?.selectedKidsCategory()
    }
    
    @IBAction func sale(_ sender: Any) {
        categoriesViewModel?.selectedSaleCategory()
    }
    
    
    @IBAction func onFavoriteButtonPressed(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.favourites.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.favourites.rawValue) as! FavoritesViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
   
extension CategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        categoriesViewModel?.search(searchInput: searchText)
    }
}

extension CategoriesViewController: FavouriteActionProductScreen {
    func addFavourite(appDelegate: AppDelegate, product: Product) {
        categoriesViewModel?.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Product) {
        categoriesViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
    }
}





//var collectsArray = [Collect](){
//        didSet{print("the collects count is \(collectsArray.count)")}}
//var womenProductIDs = [Int]()
//    var menProductIDs = [Int]()
//    var kidsProductIDs = [Int]()
//    var salesProductIDs = [Int]()
//    let womenCollectionID = 409147506902
//    let menCollectionID = 409147474134
//    let kidsCollectionID = 409147539670
//    let saleCollectionID = 409147605206
//    var menProductsArray = [Product]()
//    var womenProductsArray = [Product]()
//    var kidsProductsArray = [Product]()
//    var SaleProductsArray = [Product]()



// MARK: - FETCHING COLLECTS DATA
//        let collectsViewModel = CollectsViewModel()
//          collectsViewModel.fetchCollects(endPoint: "collects.json")
//          collectsViewModel.bindingData = { [self] collects, error in
//                  if let collects = collects {
//                  self.collectsArray = collects
//                  }
//                  if let error = error {
//                      print(error.localizedDescription)
//                  }
//              // MARK: - Categorization OF COLLECTS
////                    categorizeResults()
//          }




// MARK: - Categorization IMPLEMENTATION

//func categorizeResults(){
//        for index in 0..<self.collectsArray.count{
//            if collectsArray[index].collectionID == womenCollectionID {
//                self.womenProductIDs.append(self.collectsArray[index].productID)}
//            else if collectsArray[index].collectionID == menCollectionID{
//                self.menProductIDs.append(self.collectsArray[index].productID) }
//            else if collectsArray[index].collectionID == kidsCollectionID{
//                self.kidsProductIDs.append(self.collectsArray[index].productID) }
//            else if collectsArray[index].collectionID == saleCollectionID{
//                self.salesProductIDs.append(self.collectsArray[index].productID) } }
//
//}

// MARK: - Collection View Functions
  /*  
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              return shownProductsArray.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = productsCV.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! ProductCollectionViewCell
              var imgLink = (shownProductsArray[indexPath.row].image.src)
              var url = URL(string: imgLink)
              cell.productImage.kf.setImage(with: url)
              cell.productPrice.text = shownProductsArray[indexPath.row].varients?[0].price
              return cell
      }

      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let productInfoVC = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "MProductInfoVC") as! ProductInfoViewController
          productInfoVC.modalPresentationStyle = .fullScreen
              self.present(productInfoVC, animated: true, completion: nil)
      }
    
    }
   */
