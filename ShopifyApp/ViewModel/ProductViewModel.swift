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
    var bindingData: (([Product]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    func fetchData(endPoint: String) {
        apiService.fetchProducts(endPoint: endPoint) { products, error in
            if let products = products {
                self.productsArray = products
            }
            if let error = error {
                self.error = error
            }
        }
    }
}
