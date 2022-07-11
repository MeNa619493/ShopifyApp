//
//  CategoriesViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 10/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBAction func women(_ sender: Any) {
        shownProductsArray.removeAll()
        mainCategoryProducts(mainCategory: "women")
    }
    @IBAction func men(_ sender: Any) {
        shownProductsArray.removeAll()
        mainCategoryProducts(mainCategory: "men")
    }
    @IBAction func kids(_ sender: Any) {
        shownProductsArray.removeAll()
        mainCategoryProducts(mainCategory: "kid")
    }
    @IBAction func sale(_ sender: Any) {
        shownProductsArray.removeAll()
        mainCategoryProducts(mainCategory: "sale")
    }
    
    var productsArray = [Product]()
    var shownProductsArray = [Product]()
    
    
    @IBOutlet weak var productsCV: UICollectionView!{
        didSet {productsCV.delegate = self
            productsCV.dataSource = self}}
    

      override func viewDidLoad() {
              super.viewDidLoad()
             
              // MARK: - FETCHING PRODUCTS DATA
          let categoriesViewModel = CategoriesViewModel()
          categoriesViewModel.fetchProducts(endPoint: "products.json")
          categoriesViewModel.bindingData = { [self] products, error in
                if let products = products{
                self.productsArray = products
//                    self.shownProductsArray = products
                    for item in productsArray{
                        if item.tags!.contains("women"){
                            self.shownProductsArray.append(item)
                            print("line 63- the shown array count is  \(shownProductsArray.count)")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.productsCV.reloadData()
                    }
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
          productsCV.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellID")
      }
   
    // MARK: - buttons Functions
    func mainCategoryProducts(mainCategory: String){

        for item in productsArray{
            if item.tags!.contains(mainCategory){
                self.shownProductsArray.append(item)
                print("line 63- the shown array count is  \(shownProductsArray.count)")
            }
            DispatchQueue.main.async {
                self.productsCV.reloadData()
            }
        }
    }
    
// MARK: - Collection View Functions
    
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
   
