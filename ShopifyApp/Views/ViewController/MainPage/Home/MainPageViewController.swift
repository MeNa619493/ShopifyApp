//
//  MainPageViewController.swift
//  ShopifyApp
//
//  Created by Abdelrahman Magdy on 04/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

class MainPageViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{


    @IBOutlet weak var adsCollectionView: UICollectionView! {
        didSet {
            adsCollectionView.delegate = self
            adsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var brandsCollectionView: UICollectionView! {
        didSet {
            brandsCollectionView.delegate = self
            brandsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var BrandsArray = [SmartCollection]()
    var brandsViewModel: BrandsViewModel?
    let indicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .label, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFiles()
        
        guard Connectivity.shared.isConnectedToInternet() else {
            self.showAlertForInterNetConnection()
            return
        }
        
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        
        brandsViewModel = BrandsViewModel()
        brandsViewModel?.fetchData()
        brandsViewModel?.bindingData = { brands, error in
            if let brands = brands {
                self.BrandsArray = brands
                DispatchQueue.main.async {
                    self.adsCollectionView.reloadData()
                    self.brandsCollectionView.reloadData()
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
        }
    }
    
    func registerNibFiles() {
        adsCollectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCellID")
        
        brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "brandsCellID")
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
        let imgLink = (BrandsArray[indexPath.row].image?.src)!
        let url = URL(string: imgLink)
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
    
    
    @IBAction func onFavouritesButton(_ sender: Any) {
        let vc = UIStoryboard(name: Storyboards.favourites.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.favourites.rawValue) as! FavoritesViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        brandsViewModel?.search(searchInput: searchText)
    }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollectionView {
             return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height / 2.5)
        }
    }
}



