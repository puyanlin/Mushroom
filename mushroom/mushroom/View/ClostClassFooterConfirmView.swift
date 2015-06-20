//
//  ClostClassFooterConfirmView.swift
//  mushroom
//
//  Created by Puyan on 6/20/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

protocol ClostClassFooterConfirmViewDelegate:NSObjectProtocol{
    func didConfirm();
}

class ClostClassFooterConfirmView: UITableViewHeaderFooterView {

    @IBOutlet weak var sendBtn: UIButton!
    
    var delegate:ClostClassFooterConfirmViewDelegate!
    
    override func awakeFromNib() {
        sendBtn.layer.cornerRadius=5
    }

    @IBAction func confirm(sender: UIButton) {
        delegate.didConfirm()
    }
}
