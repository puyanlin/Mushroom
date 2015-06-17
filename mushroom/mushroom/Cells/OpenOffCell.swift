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
            //lblOpeningTime.hidden = !isOpen
            self.contentView.backgroundColor = isOpen ? UIColor(red: 49.0/255, green: 199.0/255, blue: 190.0/255, alpha: 1): UIColor(red: 241.0/255, green: 40.0/255, blue: 48.0/255, alpha: 1)
            self.lblOpenOff.text = isOpen ? "今天有開":"今天沒開"
        }
    }
    
    var closeReason:String=""{
        didSet{
            self.lblOpeningTime.text=closeReason
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
