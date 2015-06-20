//
//  ClosetClassViewController.swift
//  mushroom
//
//  Created by Puyan on 2015/6/20.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ClosetClassViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var tableView: UITableView!
    
    var rowHeight:CGFloat!
    var tableClassName:String!
    var arrayProduct:[PFObject]=[]
    var rowNum:Int = 1
    var funcType:FunctionType=FunctionType.Overview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var funcBtn:UIButton=UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 35))
        
        funcBtn.setTitle("翻看衣櫃", forState: UIControlState.Normal)
        funcBtn.setTitle("預訂衣服", forState: UIControlState.Selected)
        let tintColor:UIColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        funcBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        funcBtn.setTitleColor(tintColor, forState: UIControlState.Selected)
        funcBtn.layer.borderWidth=1
        funcBtn.layer.borderColor=UIColor.whiteColor().CGColor
        funcBtn.layer.cornerRadius=5
        funcBtn.addTarget(self, action: "didClickfuncBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var barBtn:UIBarButtonItem=UIBarButtonItem(customView: funcBtn)
        self.navigationItem.rightBarButtonItem=barBtn
        
        rowHeight=self.view.frame.size.height > self.view.frame.size.width ? self.view.frame.size.height/4.5 : self.view.frame.size.height / 2.5
        
        self.tableView.registerNib(UINib(nibName: "ClosetCell", bundle: nil), forCellReuseIdentifier:"ClosetCell")
        
        var query:PFQuery=PFQuery(className: tableClassName)
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]?, error:NSError?) -> Void in
            self.arrayProduct=array as! [PFObject]
            
            self.rowNum = self.arrayProduct.count/3
            
            self.rowNum=self.rowNum < 1 ? 1 : self.rowNum
            
            if self.arrayProduct.count>3 && (self.arrayProduct.count % 3)>0 { self.rowNum+=1 }
            
//            println("product count \(self.arrayProduct.count)")
//            println("tableClassName \(self.tableClassName)")
//            println("row num \(self.rowNum)")
            
            UIView.transitionWithView(self.tableView, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                
                self.tableView.reloadData()
                }, completion: { (complete) -> Void in
                    
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        rowHeight=size.height > size.width ? size.height/4.5 : size.height / 2
        self.tableView.reloadData()
    }
    

    //MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ClosetCell") as! ClosetCell
        
        var products:[PFObject]=[]
        let start:Int =  indexPath.row * 3
        let end:Int = start + 2
        
        
        
        for index in start...end {
            if self.arrayProduct.count <= index { break }
            products.append(self.arrayProduct[index])
        }
        cell.funcType=self.funcType
        cell.setProducts(products)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset=UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins=false
        }
        if cell.respondsToSelector("setLayoutMargins:"){
            cell.layoutMargins=UIEdgeInsetsZero
        }
        
    }
    
    //MARK: UI Control Events
    func didClickfuncBtn(sender:UIButton){
        sender.selected = !sender.selected
        
        let tintColor:UIColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        sender.layer.borderColor = sender.selected ? tintColor.CGColor : UIColor.whiteColor().CGColor
        
        self.funcType = sender.selected ? FunctionType.Booking : FunctionType.Overview
        self.tableView.reloadData()
    }
    
}
