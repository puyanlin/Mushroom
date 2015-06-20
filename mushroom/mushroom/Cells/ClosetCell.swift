//
//  ClosetCell.swift
//  mushroom
//
//  Created by Puyan on 2015/6/20.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

enum FunctionType:Int{
    case Overview=0
    case Booking
}

class ClosetCell: UITableViewCell {

    let TAG_IMAGE:Int = 50
    
    @IBOutlet weak var pos0View: UIView!
    @IBOutlet weak var pos1View: UIView!
    @IBOutlet weak var pos2View: UIView!
    
    @IBOutlet weak var pos0Checkmark: UIImageView!
    @IBOutlet weak var pos1Checkmark: UIImageView!
    @IBOutlet weak var pos2Checkmark: UIImageView!
    
    var productViews:[UIView]=[]
    var checkmarkViews:[UIImageView]=[]
    var funcType:FunctionType=FunctionType.Overview
    var arrayProduct:[PFObject]=[]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productViews.append(self.pos0View)
        productViews.append(self.pos1View)
        productViews.append(self.pos2View)
        
        checkmarkViews.append(self.pos0Checkmark)
        checkmarkViews.append(self.pos1Checkmark)
        checkmarkViews.append(self.pos2Checkmark)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProducts(products:[PFObject]){
        arrayProduct=products
        for index in 0...2 {
            if products.count <= index {
                productViews[index].hidden=true
                continue
            }else{
                productViews[index].hidden=false
                let imgView:UIImageView = productViews[index].viewWithTag(TAG_IMAGE) as! UIImageView
                imgView.sd_setImageWithURL(NSURL(string: products[index]["imgUrl"] as! String))
                
                if funcType == FunctionType.Overview {
                    for checkmark in checkmarkViews {
                        checkmark.hidden=true
                    }
                }else{
                    let p = products[index]
                    let checkmark = checkmarkViews[index]
                    checkmark.hidden = !BookingManager.sharedManager.isContainProduct(p)
                }
                
            }
            
        }
    }
    
    @IBAction func clickProductThumb(sender: UIButton) {
        let index=sender.tag-100
        
        if funcType == FunctionType.Booking {
            checkmarkViews[index].hidden = !checkmarkViews[index].hidden
            
            if !checkmarkViews[index].hidden {
                BookingManager.sharedManager.addProduct(arrayProduct[index])
            }else{
                BookingManager.sharedManager.removeProduct(arrayProduct[index])
            }
            
        }
    }
}
