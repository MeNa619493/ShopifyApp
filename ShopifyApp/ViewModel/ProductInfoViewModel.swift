//
//  ProductInfoViewModel.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/6/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class ProductInfoViewModel {
    var product: Product? {
        didSet {
            bindingData(product ,nil)
        }
    }

    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }

    let networkService: ApiService
    let databaseService: DatabaseService
    var bindingData: ((Product?,Error?) -> Void) = {_, _ in }

    init(networkService: ApiService = NetworkManager(), databaseService: DatabaseService = DatabaseManager()) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func getProduct(endPoint: String) {
        networkService.getProduct(endPoint: endPoint) { product, error in

            if let product = product {
                self.product = product
            }

            if let error = error {
                self.error = error
            }
        }
    }
    
    func getProductsInShopingCart(appDelegate: AppDelegate, id: Int) -> Bool {
        var productsArray = [Product]()
        var isInShoppingCart: Bool = false
        databaseService.getShoppingCartProductList(appDelegate: appDelegate) { (products, error) in
            if let products = products {
                productsArray = products
            }
        }
        
        for item in productsArray {
            if item.id == id {
                isInShoppingCart = true
            }
        }
        return isInShoppingCart
    }
    
    func getProductsInFavourites(appDelegate: AppDelegate, id: Int) -> Bool {
        var productsArray = [Product]()
        var isFavourite: Bool = false
        databaseService.getFavourites(appDelegate: appDelegate) { (products, error) in
            if let products = products {
                productsArray = products
            }
        }
        
        for item in productsArray {
            if item.id == id {
                isFavourite = true
            }
        }
        return isFavourite
    }
    
    func addProductToCart(appDelegate: AppDelegate, product: Product) {
        databaseService.addProduct(appDelegate: appDelegate, product: product)
    }
    
    func removeProductFromCart(appDelegate: AppDelegate, id: Int) {
        databaseService.deleteProduct(appDelegate: appDelegate, id: id)
    }
    
    func addProductToFavourites(appDelegate: AppDelegate, product: Product) {
        databaseService.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func removeProductFromFavourites(appDelegate: AppDelegate, id: Int) {
        databaseService.deleteFavourite(appDelegate: appDelegate, id: id)
    }
}
