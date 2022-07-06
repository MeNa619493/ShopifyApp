//
//  FavoritesViewModel.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/4/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    var favoritesArray: [Product]? {
        didSet {
            bindingData(favoritesArray,nil)
        }
    }

    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }

    let databaseService: DatabaseService
    var bindingData: (([Product]?,Error?) -> Void) = {_, _ in }

    init(databaseService: DatabaseService = DatabaseManager()) {
        self.databaseService = databaseService
    }

    func fetchfavorites(appDelegate: AppDelegate) {
        databaseService.getFavourites(appDelegate: appDelegate) { favorites, error in

            if let favorites = favorites {
                self.favoritesArray = favorites
            }

            if let error = error {
                self.error = error
            }
        }
    }
    
}
