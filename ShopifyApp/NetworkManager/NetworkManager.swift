//
//  NetworkManager.swift
//  ShopifyApp
//
//  Created by Mina Ezzat on 7/2/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: ApiService {
    
    func register(newCustomer: NewCustomer, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlStr = UrlServices(endPoint: EndPoint.customers.rawValue).url
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
            print(try! newCustomer.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func getCustomers(email: String, complition: @escaping ([Customer]?, Error?)->Void) {
        let urlStr = UrlServices(endPoint: EndPoint.customers.rawValue).url
        guard let url = URL(string: urlStr) else { return }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { response in
            if let error = response.error {
                complition(nil, error)
            }
            
            guard let urlResponse = response.response else {return}
            if !(200..<300).contains(urlResponse.statusCode) {
                print("error in status code")
            }
            
            guard let data = response.data else { return }
            
            let decodedJson: LoginResponse = convertFromJson(data: data) ?? LoginResponse(customers: [Customer]())
                complition(decodedJson.customers, nil)
                print("customer retreived")
        }
    }
    
    func getProduct(endPoint: String, complition: @escaping (Product?, Error?)->Void) {
        let urlStr = UrlServices(endPoint: endPoint).url
        guard let url = URL(string: urlStr) else { return }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { response in
            if let data = response.data {
                let decodedJson: Model = convertFromJson(data: data) ?? Model(product: Product(id: 0, title: "", description: "", vendor: nil, productType: nil, images: [], options: nil, varients: nil, tags: "", image: ProductImage(id: 0, productID: 0, position: 0, width: 0, height: 0, src: "", graphQlID: "")))
                print(decodedJson.product)
                complition(decodedJson.product, nil)
                print("Product retreived")
            }
            
            if let error = response.error {
                complition(nil, error)
            }
        }
    }
    
    func fetchBrands(completion: @escaping (([SmartCollection]?, Error?) -> Void)) {
        if let  url = URL(string: UrlServices(endPoint: EndPoint.smartCollections.rawValue).url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print("data is here")
                    guard let decodedData : Brands = try? convertFromJson(data: data) else{ return}
                    completion(decodedData.smartCollections,nil)
                }
                if let error = error {
                   completion(nil, error)
                }
            }.resume()
        }

    }
    
    func fetchProducts(endPoint: String, completion: @escaping (([Product]?, Error?) -> Void)) {
        if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print("product data is here")
                    guard let decodedData : AllProducts = try? convertFromJson(data: data) else{ return}
                    completion(decodedData.products,nil)
                }
                if let error = error {
                   completion(nil, error)
                }
            }.resume()
        }

    }
    
    func fetchCollects(endPoint: String, completion: @escaping (([Collect]?, Error?) -> Void)) {
             if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
                 URLSession.shared.dataTask(with: url) { data, response, error in
                     if let data = data {
                         print("Collections data is here - line 112")
                         guard let decodedData : Collects = try? JSONDecoder().decode(Collects.self, from: data)
                         else {return}
                         completion(decodedData.collects,nil)
                     }
                     if let error = error {
                        completion(nil, error)
                     }
                 }.resume()
             }
         }

}


//func fetchCollects(endPoint: String, completion: @escaping (([Collect]?, Error?) -> Void)) {
//    if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                print("Collections data is here line 122")
//                let decodedData:[Collect] = convertFromJson(data: data) ?? []
//                completion(decodedData ,nil)
//                print("the data is \(data)")
//            }
//            if let error = error {
//               completion(nil, error)
//                print("ERROR line 121")
//
//            }
//        }.resume()
//    }
//
//}
