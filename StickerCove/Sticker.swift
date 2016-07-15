//
//  Sticker.swift
//  StickerCove
//
//  Created by Josh on 7/15/16.
//  Copyright © 2016 Josh Kim. All rights reserved.
//

import UIKit

class Sticker {
    var name = ""
    var price = ""
    var image = UIImage()
    
    static func createStickers() -> [Sticker] {
        let cat = Sticker()
        cat.name = "Grumpy Cat Sticker"
        cat.price = "4.99"
        if let catImage = UIImage(named: "cat") {
            cat.image = catImage
        }
        
        let pizza = Sticker()
        pizza.name = "🍕Pizza Sticker🍕"
        pizza.price = "1.99"
        if let pizzaIamge = UIImage(named: "pizza") {
            pizza.image = pizzaIamge
        }
        
        let tony = Sticker()
        tony.name = "SKATE OR DIE Sticker"
        tony.price = "3.99"
        if let tonyImage = UIImage(named: "tony") {
            tony.image = tonyImage
        }
        
        return [cat, pizza, tony]
    }
}


