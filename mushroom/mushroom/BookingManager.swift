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
    private var arrayProducts:[PFObject] = []
    private override init() {
        super.init()
    }
    
    func isContainProduct(product:PFObject)->Bool {
        return contains(arrayProducts, product)
    }
    
    func addProduct(product:PFObject)->Bool{
        if isContainProduct(product) { return false }
        arrayProducts.append(product)
        return true
    }
    
    func removeProduct(product:PFObject) -> Bool {
        if isContainProduct(product) { return false }
        var index = find(arrayProducts, product)
        arrayProducts.removeAtIndex(index!)
        return true
    }
}
