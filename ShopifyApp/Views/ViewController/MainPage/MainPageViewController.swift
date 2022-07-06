//
//  MainPageViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 04/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MainPageViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    var imagesExamples = ["image1","image3","image3"]

    @IBOutlet weak var adsCollectionView: UICollectionView!{didSet {adsCollectionView.delegate = self
        adsCollectionView.dataSource = self}}
    
    @IBOutlet weak var brandsCollectionView: UICollectionView!{didSet {brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self}}
    
    var BrandsArray = [SmartCollection](){
        didSet{
            print("the count is \(BrandsArray.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let brandsViewModel = BrandsViewModel()
        brandsViewModel.fetchData(endPoint: "smart_collections.json#")
        brandsViewModel.bindingData = { brands, error in
            if let brands = brands {
                self.BrandsArray = brands
                DispatchQueue.main.async {
                    self.adsCollectionView.reloadData()
                    self.brandsCollectionView.reloadData()

                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }

        adsCollectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCellID")
        
        brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "brandsCellID")
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == brandsCollectionView){
            print("the number of brand array items is \(BrandsArray.count)")
            return BrandsArray.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == brandsCollectionView){
        let cell1 = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: "brandsCellID", for: indexPath) as! BrandsCollectionViewCell
        cell1.brandName.text = BrandsArray[indexPath.row].title
        var imgLink = (BrandsArray[indexPath.row].image?.src)!
        var url = URL(string: imgLink)
            cell1.brandLogo.kf.setImage(with: url)
            
            return cell1
        }
        let cell2 = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "AdsCellID", for: indexPath) as! AdsCollectionViewCell
        cell2.backgroundColor = UIColor.blue
        return cell2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == brandsCollectionView){

            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVCID") as! ProductViewController
            
            productVC.brandTitle = BrandsArray[indexPath.row].title
            
            productVC.modalPresentationStyle = .fullScreen
            self.present(productVC, animated: true, completion: nil)
            print("The brand title is \(BrandsArray[indexPath.row].title)")
        }
        
           
        }
        



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



