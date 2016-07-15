//
//  StickerTableViewCell.swift
//  StickerCove
//
//  Created by Josh on 7/15/16.
//  Copyright © 2016 Josh Kim. All rights reserved.
//

import UIKit

class StickerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stickerImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
