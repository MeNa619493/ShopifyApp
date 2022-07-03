//
//  Customer.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct NewCustomer: Codable {
    let customer: Customer
}

struct Customers: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    let first_name, email, phone, tags: String?
    let id: Int?
    let verified_email: Bool?
    let addresses: [Address]?
}

struct Address: Codable {
    var address1, city, province, phone: String?
    var zip, last_name, first_name, country: String?
    let id: Int?
}

struct LoginResponse: Codable {
    let customers: [Customer]
}
