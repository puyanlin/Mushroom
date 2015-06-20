//
//  BookingManager.swift
//  mushroom
//
//  Created by Puyan on 6/20/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class BookingManager: NSObject {
    static let sharedManager : BookingManager = BookingManager()
    private var dicProducts = [String:PFObject]()
    private override init() {
        super.init()
    }
    
    func isContainProduct(product:PFObject)->Bool {
        
        return contains(dicProducts.keys.array, product["mushroomId"] as! String)
    }
    
    func addProduct(product:PFObject)->Bool{
        if isContainProduct(product) { return false }
        dicProducts.updateValue(product, forKey: product["mushroomId"] as! String)
        return true
    }
    
    func removeProduct(product:PFObject) -> Bool {
        if !isContainProduct(product) { return false }
        dicProducts.removeValueForKey(product["mushroomId"] as! String)
        return true
    }
}
