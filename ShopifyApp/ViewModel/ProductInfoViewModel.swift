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
    var bindingData: ((Product?,Error?) -> Void) = {_, _ in }

    init(networkService: ApiService = NetworkManager()) {
        self.networkService = networkService
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
    
}
