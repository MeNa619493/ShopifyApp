//
//  ProductCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    var isFavourite: Bool?
    var product: Product?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var productsView: FavouriteActionProductScreen?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(product: Product, isFavourite: Bool) {
        let imgLink = (product.image.src)
        let url = URL(string: imgLink)
        productImage.kf.setImage(with: url)
        productPrice.text = product.varients?[0].price
        if isFavourite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        self.product = product
        self.isFavourite = isFavourite
    }
    
    @IBAction func favoriteProduct(_ sender: Any) {
        if isFavourite! {
            productsView?.deleteFavourite(appDelegate: appDelegate, product: product!)
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            productsView?.addFavourite(appDelegate: appDelegate, product: product!)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        isFavourite = !isFavourite!
    }
}
