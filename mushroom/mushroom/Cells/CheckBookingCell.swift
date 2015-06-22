//
//  CheckBookingCell.swift
//  mushroom
//
//  Created by Puyan on 2015/6/22.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit

protocol CheckBookingCellDelegate:NSObjectProtocol{
    func didConfirmAtSection(section:Int)
}

class CheckBookingCell: UITableViewCell {

    @IBOutlet var lblPrice: UILabel!
    
    var section:Int!
    var delegate:CheckBookingCellDelegate!
    
    var price:Int=0{
        didSet{
            lblPrice.text="\(price)"
        }
    }
    
    @IBAction func confirm(sender: UIButton) {
        delegate.didConfirmAtSection(section)
    }
}
