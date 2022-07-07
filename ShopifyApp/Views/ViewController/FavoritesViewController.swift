//
//  FavoritesViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/4/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView! {
        didSet {
            favoritesCollectionView.delegate = self
            favoritesCollectionView.dataSource = self
        }
    }
    
    var favoritesArray = [Product]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoritesFromCoreData()
        
    }
    
    func getFavoritesFromCoreData(){
        let favoritesViewModel = FavoritesViewModel()
        favoritesViewModel.fetchfavorites(appDelegate: appDelegate)

            favoritesViewModel.bindingData = { favorites, error in
                if let favorites = favorites {
                    self.favoritesArray = favorites

                    DispatchQueue.main.async {
                        self.favoritesCollectionView.reloadData()
                    }
                }

                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) 
        return cell
    }
}
