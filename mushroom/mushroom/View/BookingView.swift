//
//  BookingView.swift
//  mushroom
//
//  Created by Puyan on 2015/6/21.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit

class BookingView: UIView {

    let KEY_USERNAME    : String = "USERNAME"
    let KEY_PHONE       : String = "PHONE"
    let KEY_SAVEINFO    : String = "SAVE_INFO"
    
    @IBOutlet var dialogView: UIView!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var switchSaveInfo: UISwitch!
    @IBOutlet var loadingView: UIView!
    
    override func awakeFromNib() {
        dialogView.layer.cornerRadius=5
        dialogView.clipsToBounds=true
        submitBtn.layer.cornerRadius=5
        cancelBtn.layer.cornerRadius=5
        
        self.nameField.layer.borderWidth=1
        self.nameField.layer.cornerRadius=5
        self.nameField.layer.borderColor=UIColor.lightGrayColor().CGColor
        
        self.phoneField.layer.borderWidth=1
        self.phoneField.layer.cornerRadius=5
        self.phoneField.layer.borderColor=UIColor.lightGrayColor().CGColor
        
        
        self.nameField.text=NSUserDefaults.standardUserDefaults().stringForKey(KEY_USERNAME)
        self.phoneField.text=NSUserDefaults.standardUserDefaults().stringForKey(KEY_PHONE)
        self.switchSaveInfo.on=NSUserDefaults.standardUserDefaults().boolForKey(KEY_SAVEINFO)
        
    }
    @IBAction func bookingBtn(sender: UIButton) {
        if self.nameField.text.isEmpty {
            self.nameField.layer.borderColor=UIColor.redColor().CGColor
            return
        }
        
        if self.phoneField.text.isEmpty {
            self.phoneField.layer.borderColor=UIColor.redColor().CGColor
            return
        }
        
        self.nameField.layer.borderColor=UIColor.lightGrayColor().CGColor
        self.phoneField.layer.borderColor=UIColor.lightGrayColor().CGColor
        self.nameField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
        
        if switchSaveInfo.on {
            NSUserDefaults.standardUserDefaults().setObject(self.nameField.text, forKey: KEY_USERNAME)
            NSUserDefaults.standardUserDefaults().setObject(self.phoneField.text, forKey: KEY_PHONE)
            
        }else{
            NSUserDefaults.standardUserDefaults().setObject("", forKey: KEY_USERNAME)
            NSUserDefaults.standardUserDefaults().setObject("", forKey: KEY_PHONE)
            
        }
        NSUserDefaults.standardUserDefaults().setBool(switchSaveInfo.on, forKey: KEY_SAVEINFO)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.loadingView.hidden=false
        //self.removeFromSuperview()
        
    }
    @IBAction func cancel(sender: UIButton) {
        self.nameField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
        self.removeFromSuperview()
    }
    @IBAction func editBegin(sender: UITextField) {
        sender.layer.borderColor=UIColor.lightGrayColor().CGColor
    }
}
