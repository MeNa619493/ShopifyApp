//
//  PaymentViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 05/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var containerOfContinueToPaymentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerOfContinueToPaymentView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func continueToPayButtonAction(_ sender: Any) {
        
        let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "ConfirmOrderViewController") as! ConfirmOrderViewController
        self.present(VC, animated: false, completion: nil)
        
    }
    
    
}
