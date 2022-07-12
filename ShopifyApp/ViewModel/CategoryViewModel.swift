//
//  CategoryViewModel.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 12/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation


class CategoriesViewModel {
    var allProductsArray = [Product]()
    var filteredArray = [Product]()
    var menCategory = [Product]()
    var womenCategory = [Product]()
    var kidCategory = [Product]()
    var saleCategory = [Product]()
    var shownArray: [Product]? {
        didSet {
            bindingData(shownArray,nil)
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
                self.allProductsArray = products
                self.filteredArray = products
                self.mainCategoryProducts(mainCategory: "men")
            }
            
            if let error = error {
                self.error = error
            }
        }
    }
    
    func mainCategoryProducts(mainCategory: String) {
        shownArray = filteredArray.filter({ (product) -> Bool in
            return product.tags!.contains(mainCategory)
        })
    }
    
    func selectedMenCategory() {
        filteredArray = allProductsArray
        mainCategoryProducts(mainCategory: " men")
    }
    
    func selectedWomenCategory() {
        filteredArray = allProductsArray
        mainCategoryProducts(mainCategory: " women")
    }
    
    func selectedKidsCategory() {
        filteredArray = allProductsArray
        mainCategoryProducts(mainCategory: "kid")
    }
    
    func selectedSaleCategory() {
        filteredArray = allProductsArray
        mainCategoryProducts(mainCategory: "sale")
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
            shownArray = filteredArray
        } else {
            shownArray = shownArray!.filter({ (product) -> Bool in
                return product.title.hasPrefix(searchInput.lowercased()) ||          product.title.hasPrefix(searchInput.uppercased()) ||
                    product.title.contains(searchInput.lowercased()) ||     product.title.contains(searchInput.uppercased())
            })
        }
    }
    
}
