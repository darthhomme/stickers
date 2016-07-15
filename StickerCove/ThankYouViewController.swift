//
//  ThankYouViewController.swift
//  StickerCove
//
//  Created by Josh on 7/15/16.
//  Copyright © 2016 Josh Kim. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var conView: UIView!
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.thankYouLabel.text = "Your order has been completed and a receipt has been sent to \(self.email). Thank you for your purchase! ☺️"
        
        let confettiView = SAConfettiView(frame: self.conView.bounds)
        self.conView.addSubview(confettiView)
        confettiView.startConfetti()
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
