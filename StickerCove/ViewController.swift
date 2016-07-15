//
//  ViewController.swift
//  StickerCove
//
//  Created by Josh on 7/15/16.
//  Copyright © 2016 Josh Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stickers : [Sticker] = Sticker.createStickers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stickers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("stickerCell") as! StickerTableViewCell? {
            
            let sticker = self.stickers[indexPath.row]
            
            cell.nameLabel.text = sticker.name
            cell.priceLabel.text = "$\(sticker.price)"
            cell.stickerImageView.image = sticker.image
            
            return cell
        }
    
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sticker = self.stickers[indexPath.row]
        self.performSegueWithIdentifier("detailSegue", sender: sticker)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailVC = segue.destinationViewController as? ProductDetailViewController {
            if sender != nil {
                if let sticker = sender as? Sticker {
                    detailVC.sticker = sticker
                }
            }
        }
    }
    
}

