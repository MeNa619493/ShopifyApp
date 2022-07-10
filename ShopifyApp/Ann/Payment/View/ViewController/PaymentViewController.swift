//
//  PaymentViewController.swift
//  ShopifyApp
//
//  Created by Ann mohammed on 05/07/2022.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import PassKit

enum PayStatus {
    case applePay
    case cash
    case non
}

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var containerOfContinueToPaymentView: UIView!
    
    @IBOutlet weak var applePayButtonOutlet: UIButton!
    @IBOutlet weak var cashOnDeliveryButtonOutlet: UIButton!
    
    var selected: Int?
    
    var totalPrice: Double?
    
    var ShippingMethods: [PKShippingMethod] = []
    var ShipingMethods: PKShippingMethod?
    var paymentSummaryItems : [PKPaymentSummaryItem] = []
    var paymentRequest: PKPaymentRequest = PKPaymentRequest()
    
    var payStatus: PayStatus = .non
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payStatus = .non
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerOfContinueToPaymentView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    @IBAction func applePayButtonAction(_ sender: Any) {
        
        applePayButtonOutlet.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cashOnDeliveryButtonOutlet.setImage(UIImage(systemName: "circle"), for: .normal)
        
        payStatus = .applePay
        
    }
    
    @IBAction func cashOnDeliveryButtonAction(_ sender: Any) {
        
        applePayButtonOutlet.setImage(UIImage(systemName: "circle"), for: .normal)
        cashOnDeliveryButtonOutlet.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
        payStatus = .cash
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func continueToPayButtonAction(_ sender: Any) {
        
        switch payStatus {
            
        case .applePay:
            
            handleApplePay()
            
        case .cash:
            
            let VC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "ConfirmOrderViewController") as! ConfirmOrderViewController
            VC.totalPrice = totalPrice
            self.present(VC, animated: false, completion: nil)
            
        case .non:
            
            let alert = UIAlertController(title: "Warrning", message: "something Went wrrong", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        
        
        }
        
    }
    
    func handleApplePay() {
            
            paymentRequest.merchantIdentifier = "Ezzat.ShopifyApp"
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex, .discover, .mada]
            paymentRequest.supportedCountries = ["US"]
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.countryCode = "US"
            paymentRequest.currencyCode = "USD"
            paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Total Amount", amount: NSDecimalNumber(string: "100.0 US"), type: .final)]
            
            let total = PKPaymentSummaryItem.init(label: "Total", amount: NSDecimalNumber(string: "100.0 US"), type: .final)
            let tax   = PKPaymentSummaryItem.init(label: "Tax", amount: NSDecimalNumber(string: "0.15 %"), type: .final)
            let fare = PKPaymentSummaryItem.init(label: "Shopify company", amount: NSDecimalNumber(string: "100.0 US"), type: .final)
            paymentRequest.paymentSummaryItems = [ total, tax, fare ]
            
            paymentRequest.requiredShippingAddressFields = PKAddressField.all
            
            let twoday = PKShippingMethod(label: "Two Day", amount: NSDecimalNumber(string: "100.0 US"), type: .final)
            
            twoday.detail = "2 Day delivery"
            twoday.identifier = "2day"
            
            let shippingMethods : [PKShippingMethod] = [ twoday ]
            paymentRequest.shippingMethods = shippingMethods
            
            if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                controller.delegate = self
                present(controller, animated: true, completion: nil)
            }
            
        }
    
}

extension PaymentViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        //completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        
        // Perform some very basic validation on the provided contact information
        var errors = [Error]()
        var status = PKPaymentAuthorizationStatus.success
        
        if payment.shippingContact?.postalAddress?.isoCountryCode != "US" {
            let pickupError = PKPaymentRequest.paymentShippingAddressUnserviceableError(withLocalizedDescription: "Sample App only picks up in the United States")

            //payment.token.paymentData.llength == 0

            let countryError = PKPaymentRequest.paymentShippingAddressInvalidError(withKey: CNPostalAddressCountryKey, localizedDescription: "Invalid country")
            errors.append(pickupError)
            errors.append(countryError)
            status = .failure
            print(errors)
        } else {
            // Here you would send the payment token to your server or payment provider to process
            // Once processed, return an appropriate status in the completion handler (success, failure, etc)
        }
        let paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: paymentStatus, errors: errors))
        
        //print(completion(PKPaymentAuthorizationResult(status: paymentStatus, errors: errors)))
        
    }
 
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
 
}

