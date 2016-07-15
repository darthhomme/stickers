//
//  PorductDetailViewController.swift
//  StickerCove
//
//  Created by Josh on 7/15/16.
//  Copyright © 2016 Josh Kim. All rights reserved.
//

import UIKit
import PassKit

class ProductDetailViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var applePayView: UIView!
    
    var email :String? = nil
    
    var sticker = Sticker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = self.sticker.name
        self.imageView.image = self.sticker.image
        self.priceLabel.text = "$\(self.sticker.price)"
        
        let button : PKPaymentButton
        
        if PKPaymentAuthorizationViewController.canMakePayments() {
            button = PKPaymentButton(type: .Buy, style: .Black)
        } else {
            button = PKPaymentButton(type: .SetUp, style: .Black)
        }
        
        self.view.layoutIfNeeded()
        button.addTarget(self, action: "applePayTapped", forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: self.applePayView.frame.size.width, height: self.applePayView.frame.size.height)
        self.applePayView.addSubview(button)
        
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (PKPaymentAuthorizationStatus) -> Void) {
        self.email = payment.shippingContact?.emailAddress
        completion(.Success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true) { () -> Void in
            if let email = self.email {
                self.performSegueWithIdentifier("thankYouSegue", sender: email)
                self.email = nil
            }
        }
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingMethod shippingMethod: PKShippingMethod, completion: (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        completion(.Success, allTheSummaryItems(shippingMethod))
    }
    
    func allTheSummaryItems(shippingMethod:PKShippingMethod) -> [PKPaymentSummaryItem] {
        let sticker = PKPaymentSummaryItem(label: self.sticker.name, amount: NSDecimalNumber(string: self.sticker.price))
        let shipping = PKPaymentSummaryItem(label: shippingMethod.label, amount: shippingMethod.amount)
        let total = PKPaymentSummaryItem(label: "Sticker Cove", amount: sticker.amount.decimalNumberByAdding(shipping.amount))
        return [sticker, shipping, total]
    }
    
    func applePayTapped() {
        let request = PKPaymentRequest()
        request.supportedNetworks = [PKPaymentNetworkAmex, PKPaymentNetworkVisa]
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.merchantIdentifier = "merchant.com.zappycode.stickercove"
        request.merchantCapabilities = .Capability3DS
        
        request.requiredShippingAddressFields = .Email
        
        let freeShipping = PKShippingMethod(label: "Free Shipping", amount: NSDecimalNumber(double: 0.0))
        freeShipping.identifier = "freeShipping"
        freeShipping.detail = "Usually ships in 5-12 days"
        
        let expressShipping = PKShippingMethod(label: "Express Shipping", amount: NSDecimalNumber(double: 5.49))
        expressShipping.identifier = "expressShipping"
        expressShipping.detail = "Usually ships in 2-3 days"
        
        let overNightShipping = PKShippingMethod(label: "Overnight Shipping", amount: NSDecimalNumber(double: 13.99))
        overNightShipping.identifier = "overnightShipping"
        overNightShipping.detail = "Usually ships in 1 day"
        
        request.shippingMethods = [freeShipping, expressShipping, overNightShipping]

        request.paymentSummaryItems = allTheSummaryItems(freeShipping)
    
        let applePayContoller = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayContoller.delegate = self
        self.presentViewController(applePayContoller, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let thankyouVC = segue.destinationViewController as? ThankYouViewController {
            if sender != nil {
                if let email = sender as? String {
                    thankyouVC.email = email
                }
            }
        }
    }

}
