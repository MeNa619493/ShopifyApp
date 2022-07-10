//
//  SettingViewModel.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 08/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation
import Combine

protocol SettingViewModelProtocol {
    func fetchData()
}

class SettingViewModel: SettingViewModelProtocol {
    
    var settingData = [SettingModel]()
    
    func fetchData() {
        settingData.append(contentsOf: [
            SettingModel(imageName: "",
                         title: "Ahmed"),
            SettingModel(imageName: "", title: "Ann"),
            SettingModel(imageName: "", title: "Hannen")
        ])
    }
    
}
