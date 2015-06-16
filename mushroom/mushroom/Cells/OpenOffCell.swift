//
//  OpenOffCell.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/16/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

class OpenOffCell: UITableViewCell {

    @IBOutlet var lblOpenOff: UILabel!
    @IBOutlet var lblOpeningTime: UILabel!
    
    var isOpen:Bool=false{
        didSet{
            lblOpeningTime.hidden = !isOpen
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
    
    func setOpeningTimeAndOffTime(open:String, off:String){
        lblOpeningTime.text="營業時間 \(open) ~ \(off)"
    }

    
}
