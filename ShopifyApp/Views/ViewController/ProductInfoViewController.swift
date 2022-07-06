//
//  ProductInfoViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/4/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class ProductInfoViewController: UIViewController {

    @IBOutlet weak var productImageCollectionView: UICollectionView! {
        didSet {
            productImageCollectionView.delegate = self
            productImageCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var productDescription: UILabel!
    
    var productId: Int?
    var product: Product?
    
    var pageControlIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        
        let productViewModel = ProductInfoViewModel()
            productViewModel.getProduct(endPoint: "products/7730623709398.json")
            productViewModel.bindingData = { product, error in
                if let product = product {
                    self.product = product
                    DispatchQueue.main.async {
                        self.productImageCollectionView.reloadData()
                        self.pageControl.numberOfPages = product.images.count
                        self.productDescription.text = product.description
                        self.cosmosView.rating = 3
                    }
                }
                
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        
    }
    
    func registerNibFile() {
        productImageCollectionView.register(UINib(nibName: "ProductInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductInfoCell")
    }

}

extension ProductInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfoCell", for: indexPath) as! ProductInfoCollectionViewCell
        let url = URL(string: product?.images[indexPath.item].src ?? "")
        cell.productImage.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlIndex = Int(scrollView.contentOffset.x / productImageCollectionView.frame.width)
        pageControl.currentPage = pageControlIndex
    }
}
