//
//  UrlServices.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct UrlServices {
    var endPoint: String = ""
    var url: String {
        return "https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/\(endPoint)"
    }
}

enum EndPoint: String {
    case customers = "customers.json"
}
