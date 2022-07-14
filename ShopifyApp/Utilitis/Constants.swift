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
    case splashScreen = "SplashScreen"
    case reviews = "Reviews"
}

enum StoryboardID: String {
    case productInfo = "MProductInfoVC"
    case register = "RegisterVC"
    case login = "LoginVC"
    case favourites = "FavoritesVC"
    case splashScreen = "SplashScreenVC"
    case reviews = "ReviewsVC"
}

enum NibFiles: String {
    case productInfoCell = "ProductInfoCollectionViewCell"
    case reviewCell = "ReviewTableViewCell"
}

enum IdentifierCell: String {
    case productInfoCell = "ProductInfoCell"
    case reviewCell = "ReviewCell"
}

enum collectionID: Int {
    case womenCollectionID = 409147506902
    case menCollectionID = 409147474134
    case kidsCollectionID = 409147539670
    case saleCollectionID = 409147605206
}

