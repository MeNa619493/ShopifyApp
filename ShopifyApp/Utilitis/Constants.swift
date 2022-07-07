//
//  Constants.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/7/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

enum Storyboards: String {
    case productInfo = "ProductInfo"
    case register = "Register"
    case login = "Login"
    case favourites = "Favorites"
}

enum StoryboardID: String {
    case productInfo = "MProductInfoVC"
    case register = "RegisterVC"
    case login = "LoginVC"
    case favourites = "FavoritesVC"
}

enum NibFiles: String {
    case productInfoCell = "ProductInfoCollectionViewCell"
}

enum IdentifierCell: String {
    case productInfoCell = "ProductInfoCell"
}
