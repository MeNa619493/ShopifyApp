//
//  ProductCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBAction func favoriteProduct(_ sender: Any) {
    }
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
