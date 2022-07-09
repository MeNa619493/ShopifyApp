//
//  ProductViewModel.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class ProductsViewModel {
    var productsArray: [Product]? {
        didSet {
            bindingData(productsArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    let databaseService : DatabaseService
    var bindingData: (([Product]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager(), databaseService: DatabaseService = DatabaseManager()) {
        self.apiService = apiService
        self.databaseService = databaseService
    }
    func fetchProducts(endPoint: String) {
        apiService.fetchProducts(endPoint: endPoint) { products, error in
            if let products = products {
                self.productsArray = products
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getProductsInFavourites(appDelegate: AppDelegate, product: Product) -> Bool {
        var productsArray = [Product]()
        var isFavourite: Bool = false
        databaseService.getItemFromFavourites(appDelegate: appDelegate, product: product) { (products, error) in
            if let products = products {
                productsArray = products
            }
        }
        
        for item in productsArray {
            if item.id == product.id {
                isFavourite = true
            }
        }
        return isFavourite}
    
     func addFavourite (product: Product, appDelegate: AppDelegate){
         databaseService.addFavourite(appDelegate: appDelegate, product: product)
     }
    
     func deleteFavourite (product: Product, appDelegate: AppDelegate){
         databaseService.deleteFavourite(appDelegate: appDelegate, product: product)
     }
}
