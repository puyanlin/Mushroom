//
//  BookingView.swift
//  mushroom
//
//  Created by Puyan on 2015/6/21.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit

class BookingView: UIView {

    @IBOutlet var dialogView: UIView!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        dialogView.layer.cornerRadius=5
        submitBtn.layer.cornerRadius=5
        cancelBtn.layer.cornerRadius=5
    }
    @IBAction func cancel(sender: UIButton) {
        self.nameField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
        self.removeFromSuperview()
    }
}
