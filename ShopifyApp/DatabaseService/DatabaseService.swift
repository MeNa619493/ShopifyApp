//
//  DatabaseService.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/6/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol DatabaseService{
    func getShoppingCartProductList(appDelegate: AppDelegate, complition: @escaping ([Product]?, Error?)->Void)
    func addProduct(appDelegate: AppDelegate, product: Product)
    func updateProductFromList(appDelegate: AppDelegate, product: Product)
    func deleteProduct(appDelegate: AppDelegate, id: Int)
    func emptyCart(appDelegate: AppDelegate)
    func addFavourite(appDelegate: AppDelegate, product: Product)
    func getFavourites(appDelegate: AppDelegate, complition: @escaping ([Product]?, Error?)->Void)
    func deleteFavourite(appDelegate: AppDelegate, id: Int)
}
