//
//  ProductViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Kingfisher

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //ProductCellID
    var brandTitle = ""
    var productsArray = [Product](){
        didSet{
            print("the count is \(productsArray.count)")
        }
    }
    var filteredProductsArray = [Product](){
        didSet{
            print("the filtered products count is \(filteredProductsArray.count)")
        }
    }
    
    @IBOutlet weak var ProductsCollectionView: UICollectionView!{
        didSet {ProductsCollectionView.delegate = self
                ProductsCollectionView.dataSource = self}}
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
          let productsViewModel = ProductsViewModel()
            productsViewModel.fetchProducts(endPoint: "products.json")
            productsViewModel.bindingData = { [self] products, error in
                if let products = products {
                self.productsArray = products
                    for index in 0..<self.productsArray.count{
                        if self.brandTitle == self.productsArray[index].vendor{
                        self.filteredProductsArray.append(self.productsArray[index])}}
                    
                    DispatchQueue.main.async {
                        self.ProductsCollectionView.reloadData()
                    }
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }

        ProductsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellID")
        
    }
    

    
    // MARK: - COLLECTION VIEW FUNCTIONS
 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("the number of filtered products array items is \(filteredProductsArray.count)")
            return filteredProductsArray.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! ProductCollectionViewCell
        var imgLink = (filteredProductsArray[indexPath.row].image.src)
        var url = URL(string: imgLink)
        cell.productImage.kf.setImage(with: url)
        cell.productPrice.text = filteredProductsArray[indexPath.row].varients?[0].price
//        cell.productName.text = filteredProductsArray[indexPath.row].title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productInfoVC = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "MProductInfoVC") as! ProductInfoViewController
        productInfoVC.modalPresentationStyle = .fullScreen
            self.present(productInfoVC, animated: true, completion: nil)
           
        }
}

 
