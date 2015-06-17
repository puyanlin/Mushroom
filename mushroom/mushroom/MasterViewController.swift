//
//  ViewController.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/16/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MasterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate{

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    var appConfig:PFConfig!
    
    let arrayTitle=["最新消息","香菇衣櫃","找香菇"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title="香菇日韓服飾"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        self.tableView.registerNib(UINib(nibName: "OpenOffCell", bundle: nil), forCellReuseIdentifier:"OpenOffCell")
        self.tableView.registerNib(UINib(nibName: "SalesCell", bundle: nil), forCellReuseIdentifier:"SalesCell")
        self.tableView.tableFooterView=UIView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterBackground:", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadingIndicator.hidden=false
        self.tableView.hidden=true
        
        PFConfig.getConfigInBackgroundWithBlock { (var cfg:PFConfig?, var error:NSError?) -> Void in
            self.appConfig = cfg as PFConfig!
            
            self.loadingIndicator.hidden=true
            self.tableView.hidden=false
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.fillMode = kCAFillModeForwards
            transition.duration = 0.5
            transition.subtype = kCATransitionFromBottom
            self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
            self.tableView.reloadData()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        //println("did enter foreground")
        self.viewDidAppear(false)
    }
    
    func applicationWillEnterBackground(notification: NSNotification) {
        //println("did enter background")
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.appConfig==nil ? 0 : 3
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 2:     return 3
        default:    return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
            case 0:
                var cell=tableView.dequeueReusableCellWithIdentifier("OpenOffCell") as! OpenOffCell
                
                let open=self.appConfig["open"] as! Bool
                cell.isOpen=open
                
                if open {
                    let opentime=self.appConfig["openTime"] as! String
                    let close=self.appConfig["closeTime"] as! String
                    cell.setOpeningTimeAndOffTime(opentime, off: close)
                }else{
                    cell.closeReason=self.appConfig["closeReason"] as! String
                }
                
                return cell
            case 1:
                var cell=tableView.dequeueReusableCellWithIdentifier("SalesCell") as! SalesCell
                return cell
            default:
                var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
                
                cell.textLabel?.text = arrayTitle[indexPath.row]
                
                return cell
        }
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section){
        case 0:     return 66.0
        case 1:     return 110.0
        default:    return 132.0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 1:     return "特別促銷"
        default:    return ""
        }
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


}

