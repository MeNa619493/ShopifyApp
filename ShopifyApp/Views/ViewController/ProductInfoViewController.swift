//
//  ProductInfoViewController.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/4/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class ProductInfoViewController: UIViewController {

    @IBOutlet weak var productImageCollectionView: UICollectionView! {
        didSet {
            productImageCollectionView.delegate = self
            productImageCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var productDescription: UILabel!
    
    
    let images = ["https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580", "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8a029d2035bfb80e473361dfc08449be.jpg?v=1656280580","https://cdn.shopify.com/s/files/1/0659/3796/5270/products/ad50775123e20f3d1af2bd07046b777d.jpg?v=1656280580","https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580"]
    
    var pageControlIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        pageControl.numberOfPages = images.count
        cosmosView.rating = 3
        productDescription.text = "hjgdashjgadjkgfdhfgdjgfsgfhjadghjdgshjfsgjhgfsdhgfjsgfjdshgfjdgf∂˙gfjdgf§dsgfjhdsgfhdsgfhdgsjfdsjgf∂©fgjfhdgsjfhdgjahfjahgjgfdsjfhghadsgfhjdgsagfjadgagsjdshgfdhgfjadgjjhfdgsjfgdsgfjdsghfhjsgfdhagfjhadgfhdgafhgjdghasjghfsjghfjdsgjfgdsjgfdfgdshgfdshgfdshgf∂agjhghdgshjgdsjgfshdgfdjsgfdshgfjdgfdshgf∂ß©fhdsgfhdsgfhdgsfjgdsjgfsdjfgdjhfgdshgfhsdgfjdsgjdshhdsgfhsdgfjhdsgfjhdsgfjhdsgfjdsgf∂ß©fhhjsgfhjdsgfjhdgjhgdjfgjdjshgfhjgdfjhgdsjgfjdhgfjdsgfdjhgfjdgfjhdsgfjdgfhdgfdjgfdshgfdhgfdhsgfdshgfjgfjdgfdhgfdjsfhgdsgfjdgfhdghjgfdshgfdjsgfdsgfjhdgfhgfjdgfdjgfhdgfdsjgfdsjgfdghfhjgdsgfdsjgfsdgfjdgfdshgfdshgfdsjgfjhgfdsjgfdshgfdsjgfdsjgfhdsgf∂ß©fdsgfjdsgfjhdgf"
    }
    
    func registerNibFile() {
        productImageCollectionView.register(UINib(nibName: "ProductInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductInfoCell")
    }

}

extension ProductInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfoCell", for: indexPath) as! ProductInfoCollectionViewCell
        let url = URL(string: images[indexPath.item])
        cell.productImage.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlIndex = Int(scrollView.contentOffset.x / productImageCollectionView.frame.width)
        pageControl.currentPage = pageControlIndex
    }
}
