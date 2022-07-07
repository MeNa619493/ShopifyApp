//
//  DatabaseManager.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/6/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager: DatabaseService {
    
    func getShoppingCartProductList(appDelegate: AppDelegate, complition: @escaping ([Product]?, Error?)->Void) {
            var productList = [Product]()
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
            do{
                let productArray = try managedContext.fetch(fetchRequest)
                print("get products from shopping cart successfully")
                for product in productArray{
                    let id = product.value(forKey: "id") as! Int
                    let count = product.value(forKey: "count") as! Int
                    let price = product.value(forKey: "price") as! String
                    let quantity = product.value(forKey: "quantity") as! Int
                    let title = product.value(forKey: "title") as! String
                    let imgUrl = product.value(forKey: "imgUrl") as! String
                    let product = Product(id: id, title: title, description: "", vendor: nil, productType: "", images: [ProductImage(id: id, productID: 1, position: 1, width: 1, height: 1, src: imgUrl, graphQlID: "")], options: nil, varients: [Varient(id: id, productID: 0, title: "", price: price,quantity: quantity)], image: ProductImage(id: id, productID: 1, position: 1, width: 1, height: 1, src: imgUrl, graphQlID: ""),count: count)
                    productList.append(product)
                }
                complition(productList, nil)
            }catch{
                print("failed to load products from core data \(error.localizedDescription)")
                complition(nil, error)
            }
        }
    
    func addProduct(appDelegate: AppDelegate, product: Product) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ProductCD", in: managedContext)
        
        let productCD = NSManagedObject(entity: entity!, insertInto: managedContext)
        productCD.setValue(product.id , forKey: "id")
        productCD.setValue(product.count + 1, forKey: "count")
        productCD.setValue(product.varients?[0].price ?? "0.0", forKey: "price")
        productCD.setValue(product.varients?[0].quantity ?? "0", forKey: "quantity")
        productCD.setValue(product.title, forKey: "title")
        productCD.setValue(product.image.src, forKey: "imgUrl")
        do{
            try managedContext.save()
            print("product saved successfully")
        }catch let error as NSError{
            print("failed to add product in core data \(error.localizedDescription)")
        }
    }
    
    func deleteProduct(appDelegate: AppDelegate, id: Int) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        do{
            let productsArray = try managedContext.fetch(fetchRequest)
            for product in productsArray {
                managedContext.delete(product)
            }
            try managedContext.save()
            print("product deleted successfully")
        }catch{
            print("failed to delete product from core data \(error)")
        }
    }
    
    func emptyCart(appDelegate: AppDelegate){
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCD")
        do{
            let productCDArray = try managedContext.fetch(fetchRequest)
            for product in productCDArray {
                managedContext.delete(product)
            }
            try managedContext.save()
            print("products deleted successfully")
        }catch{
            print("failed to delete product from core data \(error)")
        }
    }
    
    func addFavourite(appDelegate: AppDelegate, product: Product) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteCD", in: managedContext)
            
        let productCD = NSManagedObject(entity: entity!, insertInto: managedContext)
        productCD.setValue(product.id , forKey: "id")
        productCD.setValue(product.varients?[0].price ?? "0.0", forKey: "price")
        productCD.setValue(product.title, forKey: "title")
        productCD.setValue(product.image.src, forKey: "imgUrl")
        do{
            try managedContext.save()
            print("favourite saved successfully")
        }catch let error as NSError{
            print("failed to add favourite in core data \(error.localizedDescription)")
        }
    }
        
    func getFavourites(appDelegate: AppDelegate, complition: @escaping ([Product]?, Error?)->Void){
        var favouriteList = [Product]()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCD")
        do{
            let productArray = try managedContext.fetch(fetchRequest)
            print("get products from favourites successfully")
            for product in productArray{
                let id = product.value(forKey: "id") as! Int
   
                let price = product.value(forKey: "price") as! String
                let title = product.value(forKey: "title") as! String
                let imgUrl = product.value(forKey: "imgUrl") as! String
                let product = Product(id: id, title: title, description: "", vendor: nil, productType: "", images: [ProductImage(id: id, productID: 1, position: 1, width: 1, height: 1, src: imgUrl, graphQlID: "")], options: nil, varients: [Varient(id: id, productID: 0, title: "", price: price,quantity: 0)], image: ProductImage(id: id, productID: 1, position: 1, width: 1, height: 1, src: imgUrl, graphQlID: ""), count: 0)
    
                    favouriteList.append(product)
            }
            complition(favouriteList, nil)
        }catch{
            print("failed to load favourites from core data \(error.localizedDescription)")
            complition(nil, error)
        }
    }
    
    func deleteFavourite(appDelegate: AppDelegate, id: Int) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCD")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        do{
            let productsArray = try managedContext.fetch(fetchRequest)
            for product in productsArray {
                managedContext.delete(product)
            }
            try managedContext.save()
            print("product deleted successfully")
        }catch{
            print("failed to delete favourite from core data \(error)")
        }
    }
    
}
