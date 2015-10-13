//
//  ModeSwitcherHeaderView.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/23/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

protocol ModeSwitcherHeaderViewDelegate:NSObjectProtocol {
    func didSwitcherChanged(isOn:Bool)
}

class ModeSwitcherHeaderView: UITableViewHeaderFooterView {
    
    
    @IBOutlet var modeSwitcher: UISwitch!
    
    var funcType:FunctionType=FunctionType.Overview{
        didSet{
            modeSwitcher.on = funcType==FunctionType.Booking
        }
    }
    
    var delegate:ModeSwitcherHeaderViewDelegate!
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        print( sender.on ? "true":"false" )
        delegate.didSwitcherChanged(sender.on)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
