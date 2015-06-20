//
//  ClostClassFooterConfirmView.swift
//  mushroom
//
//  Created by Puyan on 6/20/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

class ClostClassFooterConfirmView: UITableViewHeaderFooterView {

    @IBOutlet weak var sendBtn: UIButton!
    
    override func awakeFromNib() {
        sendBtn.layer.cornerRadius=5
    }

}
