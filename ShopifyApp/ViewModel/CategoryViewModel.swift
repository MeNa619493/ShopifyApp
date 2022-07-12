//
//  CategoryViewModel.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 12/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation


class CategoriesViewModel {
    var filteredArray = [Product]()
    
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
        //should change user id and get it from user defaults
        databaseService.getItemFromFavourites(appDelegate: appDelegate, product: product, complition: { (products, error) in
            if let products = products {
                productsArray = products
            }
        })

        for item in productsArray {
            if item.id == product.id {
                isFavourite = true
            }
        }
        return isFavourite
    }
    
    func addFavourite(appDelegate: AppDelegate, product: Product){
         databaseService.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Product){
         databaseService.deleteFavourite(appDelegate: appDelegate, product: product)
    }
    
    func search(searchInput: String) {
        if searchInput.isEmpty {
            productsArray = filteredArray
        } else {
            productsArray = filteredArray.filter({ (product) -> Bool in
                return product.title.hasPrefix(searchInput.lowercased()) ||          product.title.hasPrefix(searchInput.uppercased()) ||
                    product.title.contains(searchInput.lowercased()) ||     product.title.contains(searchInput.uppercased())
            })
        }
    }
}