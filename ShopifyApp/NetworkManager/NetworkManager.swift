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
}
