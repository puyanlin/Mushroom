//
//  NewsCell.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/18/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

enum NewsType:Int{
    case New=0
    case Declaration
    case Activity
    case Close
}

class NewsCell: UITableViewCell {

    
    @IBOutlet var tagView: UIView!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var tvContent: UITextView!
    
    var type:NewsType=NewsType.New{
        didSet{
            switch(type){
            case .New:
                self.lblType.text="新貨"
                self.tagView.backgroundColor=UIColor(red: 101.0/255, green: 181.0/255, blue: 245.0/255, alpha: 1)
                self.backgroundColor=UIColor(red: 111.0/255, green: 207.0/255, blue: 236.0/255, alpha: 1)
            case .Declaration:
                self.lblType.text="公告"
                self.tagView.backgroundColor=UIColor(red: 1, green: 171.0/255, blue: 44.0/255, alpha: 1)
                self.backgroundColor=UIColor(red: 254.0/255, green: 193.0/255, blue: 7.0/255, alpha: 1)
            case .Activity:
                self.lblType.text="活動"
                self.tagView.backgroundColor=UIColor(red: 150.0/255, green: 150.0/255, blue: 150.0/255, alpha: 1)
                self.backgroundColor=UIColor.lightGrayColor()
            case .Close:
                self.lblType.text="公休"
                self.tagView.backgroundColor=UIColor(red: 228.0/255, green: 0, blue: 58.0/255, alpha: 1)
                self.backgroundColor=UIColor(red: 1, green: 64.0/255, blue: 86.0/255, alpha: 1)
            default: break
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
