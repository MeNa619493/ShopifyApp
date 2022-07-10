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
import NVActivityIndicatorView

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
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var productId: Int?
    var product: Product?
    var isFavourite: Bool?
    var isAddedToCart: Bool?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var pageControlIndex = 0
    var productInfoViewModel: ProductInfoViewModel?
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        
        guard Connectivity.shared.isConnectedToInternet() else {
            self.showAlertForInterNetConnection()
            return
        }
        
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        
        let group = DispatchGroup()
        
        productInfoViewModel = ProductInfoViewModel()
        productInfoViewModel?.getProduct(endPoint: "products/\(productId ?? 7730623709398).json")
        productInfoViewModel?.bindingData = { product, error in
            if let product = product {
                self.product = product
                
                group.enter()
                self.isFavourite = self.productInfoViewModel?.getProductsInFavourites(appDelegate: self.appDelegate, product: product)
                group.leave()
                group.enter()
                self.isAddedToCart = self.productInfoViewModel?.getProductsInShopingCart(appDelegate: self.appDelegate, product: product)
                group.leave()
                
                group.notify(queue: .main) {
                    self.setupView()
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
                
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func registerNibFile() {
        productImageCollectionView.register(UINib(nibName: NibFiles.productInfoCell.rawValue , bundle: nil), forCellWithReuseIdentifier: IdentifierCell.productInfoCell.rawValue)
    }
    
    func checkIsFavourite() {
        if isFavourite! {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func checkIsInShoppingCart() {
        if isAddedToCart! {
            addToCartButton.setTitle("REMOVE FROM CART", for: .normal)
        } else {
            addToCartButton.setTitle("ADD TO CART", for: .normal)
        }
    }
    
    func setupView() {
        self.productImageCollectionView.reloadData()
        self.pageControl.numberOfPages = product?.images.count ?? 0
        self.productTitle.text = product?.title
        self.productPrice.text = "\(product?.varients?[0].price ?? "0") EGP"
        self.productDescription.text = product?.description
        self.addToCartButton.layer.cornerRadius = addToCartButton.frame.height / 2
        self.cosmosView.rating = 3
        checkIsFavourite()
        checkIsInShoppingCart()
    }
    
    @IBAction func onAddToCartPressed(_ sender: Any) {
        if isAddedToCart! {
            addToCartButton.setTitle("ADD TO CART", for: .normal)
            productInfoViewModel?.removeProductFromCart(appDelegate: appDelegate, product: product!)
        } else {
            addToCartButton.setTitle("REMOVE FROM CART", for: .normal)
            productInfoViewModel?.addProductToCart(appDelegate: appDelegate, product: product!)
        }
        isAddedToCart = !isAddedToCart!
    }
    
    @IBAction func onFavouritePressed(_ sender: Any) {
        if isFavourite! {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            productInfoViewModel?.removeProductFromFavourites(appDelegate: appDelegate, product: product!)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            productInfoViewModel?.addProductToFavourites(appDelegate: appDelegate, product: product!)
        }
        isFavourite = !isFavourite!
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProductInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierCell.productInfoCell.rawValue, for: indexPath) as! ProductInfoCollectionViewCell
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
