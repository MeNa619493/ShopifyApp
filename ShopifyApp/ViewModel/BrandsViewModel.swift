//
//  BrandsViewModel.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 05/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class BrandsViewModel {
    var brandsArray: [SmartCollection]? {
        didSet {
            bindingData(brandsArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: (([SmartCollection]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    func fetchData(endPoint: String) {
        apiService.fetchBrands(endPoint: endPoint) { brands, error in
            if let brands = brands {
                self.brandsArray = brands
            }
            if let error = error {
                self.error = error
            }
        }
    }
}
