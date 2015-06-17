//
//  SalesCell.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/16/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

class SalesCell: UITableViewCell {

    @IBOutlet weak var salesImage: UIImageView!
    @IBOutlet weak var tvSales: UITextView!
    
    var imgUrl:String=""{
        didSet{
            if count(imgUrl)>10 {
                self.salesImage.sd_setImageWithURL(NSURL(string: imgUrl))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
