//
//  ProductDetailView.swift
//  mushroom
//
//  Created by Puyan on 2015/6/20.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ProductDetailView: UIView {

    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var submitBtn: UIButton!
    var product:PFObject!{
        didSet{
            productImageView.sd_setImageWithURL(NSURL(string: product["imgUrl"] as! String)!)
            
            if BookingManager.sharedManager.isContainProduct(product) {
                submitBtn.setTitle("取消選取", forState: UIControlState.Normal)
                submitBtn.backgroundColor=UIColor(red: 236.0/255, green: 107.0/255, blue: 104.0/255, alpha: 1)
            }else{
                submitBtn.setTitle("加入衣櫃", forState: UIControlState.Normal)
                submitBtn.backgroundColor=UIColor(red: 50.0/255, green: 203.0/255, blue: 113.0/255, alpha: 1)
            }
            
        }
    }
        
    @IBAction func didClose(sender: UIButton) {
        if sender.tag == 100 {
            if BookingManager.sharedManager.isContainProduct(product) {
                BookingManager.sharedManager.removeProduct(product)
            }else{
                BookingManager.sharedManager.addProduct(product)
            }
        }
        self.removeFromSuperview()
    }

}