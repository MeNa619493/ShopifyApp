//
//  ConfirmOrderViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 06/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: UIViewController {
    
    @IBOutlet weak var subTotalLabelOutlet: UILabel!
    @IBOutlet weak var subTotalValueLabelOutlet: UILabel!
    
    @IBOutlet weak var shoppingFeeLabelOutlet: UILabel!
    @IBOutlet weak var shoppingFeeValueLabelOutlet: UILabel!
    
    @IBOutlet weak var couponTFOutlet: UITextField!
    @IBOutlet weak var couponStatusLabel: UILabel!
    
    @IBOutlet weak var discountLabelOutlet: UILabel!
    @IBOutlet weak var discountValueLabelOutlet: UILabel!
    
    @IBOutlet weak var priceLabelOutlet: UILabel!
    
    @IBOutlet weak var placeOrderButtonOutlet: UIButton!
    
    var totalPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func placeOrderButtonAction(_ sender: Any) {
        
        
        
    }
    
    
}
